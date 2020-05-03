#!/bin/bash
# Script to run the CBIG Preproc2016 pipeline for a single subject in BIDS format


if [ $# -lt 1 ] ; then
	echo "Usage: $0 <bids_dir> <participant_id> <config_file>"
	echo "e.g. $0 /fileserver/corrin/connectome/GSP sub-001 /fileserver/corrin/connectome/GSP/code/FS_to_MNI.config"
	echo "====================================="
	echo ""
	echo "This script..."
	echo "output:"
	echo "In <bids_dir>/derivatives/CBIG_fMRI_preprocess/<participant_id>:"
	echo "1) "
	echo "2) "
	echo "3) "
	echo ""
	echo "====================================="
	echo ""
	echo ""
	exit 1 ;
fi

bids_dir=$1
participant_id=$2
config_file=$3
config_name=`basename ${config_file} .config`

# Run CBIG initialization script:
BIDSPATH=${bids_dir}/code # path to scripts
if [ -f "${BIDSPATH}/CBIG_config.sh" ]; then
	source ${BIDSPATH}/CBIG_config.sh
fi

# Create output directory, exit if participant_id output bold file already exists (for now):
output_dir=${bids_dir}/derivatives/CBIG_fMRI_preprocess_${config_name}
if [ -f ${output_dir}/${participant_id}/vol/sub*gz ]; then
	echo "It appears ${participant_id} has already been run with ${config_name}"
	echo "delete the outputs in ${output_dir}/${participant_id}/vol if you want to re-run"
	exit 0
else
	mkdir -p ${output_dir}/${participant_id}
fi

# Make copy of config file:
cp ${config_file} ${output_dir}

# Create fmrinii file from BIDS-formatted files:
fmrinii_file=${output_dir}/${participant_id}/${participant_id}_bold.fmrinii
ls -1 ${bids_dir}/${participant_id}/func/${participant_id}_*_bold.nii.gz | nl -w2 -n rz \
	> ${fmrinii_file}

# Create slice timing file from BIDS-formatted json files:
export st_file=${output_dir}/${participant_id}/${participant_id}_bold.slicetiming
if [ -f "${bids_dir}/task-rest_bold.json" ]; then
	jq .'SliceTiming'[] ${bids_dir}/task-rest_bold.json > $st_file
	echo "Used ${bids_dir}/task-rest_bold.json for slice timing information"

elif [ -f "${bids_dir}/${participant_id}/func/task-rest_bold.json" ]; then
	jq .'SliceTiming'[] ${bids_dir}/${participant_id}/func/task-rest_bold.json > $st_file
	echo "Used ${bids_dir}/${participant_id}/func/task-rest_bold.json for slice timing information"

else
	echo "Could not find a task-rest_bold json file for slice timing information"
	exit 0
fi

# Check for freesurfer output:
freesurfer_dir=${bids_dir}/derivatives/freesurfer
if [ -f "${freesurfer_dir}/${participant_id}/mri/brain.mgz" ]; then
	echo "Found freesurfer output"

else
	echo "Could not find freesurfer output"
	exit 0
fi


CBIG_preproc_fMRI_preprocess.csh \
	-s  ${participant_id} \
	-fmrinii  ${fmrinii_file} \
	-anat_s  ${participant_id} \
	-anat_d  ${freesurfer_dir} \
	-output_d  ${output_dir} \
	-config  ${config_file} \

