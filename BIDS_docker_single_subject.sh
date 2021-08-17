#!/bin/bash

#Script to run a single subject through the CBIG Docker. Currently in a testing stage.

if [ $# -lt 1 ] ; then
        echo "Usage: $0 <BIDS_input> <subject> <freesurfer_input> <output> <extra_files> <config_file> <image_id>"
        echo "e.g. $0 ____"
        echo "====================================="
        echo ""
        echo ""
        exit 1 ;
fi

export BIDS_input=$1
export subject=$2
export freesurfer_input=$3
export output=$4
export extra_files=$5
export config_file=$6
export image_id=$7

docker run --name cbig_${subject} --rm \
-v ${BIDS_input}:/BIDS_input \
-v ${freesurfer_input}:/freesurfer_input \
-v ${output}:/output \
-v ${extra_files}:/extra_files \
petermcmanus/cbig BIDS_to_CBIG_fMRI_Preproc2016/BIDS_2BP_docker_CBIG_fMRI_preprocess.sh /fileserver/gammu/collections/ABIDE1/Caltech $subject /fileserver/gammu/projects/ABIDE1/freesurfer_v7.1.0/Caltech /fileserver/gammu/projects/ABIDE1 $config_file
