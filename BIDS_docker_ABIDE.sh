#Script for running GNU parallel on specific ABIDE dataset - very narrow and brute force.

export subject=$1

docker run --name cbig_${subject} --rm \
-v /fileserver/gammu/collections/ABIDE1/Caltech:/BIDS_input \
-v /fileserver/gammu/projects/ABIDE1/freesurfer_v7.1.0/Caltech:/freesurfer_input \
-v /fileserver/gammu/projects/ABIDE1:/output \
-v /fileserver/caladan_ssd/repos/CBIG_compiled/stable_projects/preprocessing/CBIG_fMRI_Preproc2016/utilities:/extra_files \
petermcmanus/cbig /BIDS_to_CBIG_fMRI_Preproc2016/BIDS_2BP_docker_CBIG_fMRI_preprocess.sh /BIDS_input $subject /freesurfer_input /output /BIDS_to_CBIG_fMRI_Preproc2016/configs/ABIDE.config
