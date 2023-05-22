#! /bin/bash
#

# Load Specific Freesurfer version
export FREESURFER_HOME=/opt/freesurfer-6.0.0
export SUBJECTS_DIR=${FREESURFER_HOME}/subjects
export FS_LICENSE=${FREESURFER_HOME}/license.txt
source ${FREESURFER_HOME}/SetUpFreeSurfer.sh

if [ ! -e /freesurfer_input/fsaverage6/surf/lh.sphere.reg ]; then
    ln -sf /opt/freesurfer-6.0.0/subjects/fsaverage6 /freesurfer_input/fsaverage6
    ln -sf /opt/freesurfer-6.0.0/subjects/fsaverage5 /freesurfer_input/fsaverage5
fi

# PLEASE CHANGE: Please specify location of CBIG repository
export CBIG_CODE_DIR=/CBIG

# PLEASE CHANGE: define locations for these libraries
export FREESURFER_HOME=${FREESURFER_HOME}
export CBIG_MATLAB_DIR=/opt/matlab
export CBIG_SPM_DIR=/spm12
export CBIG_AFNI_DIR=/opt/afni-latest
export CBIG_ANTS_DIR=/opt/ants-2.2.0
export CBIG_WB_DIR=/opt/workbench
export CBIG_FSLDIR=/opt/fsl-5.0.10

# DO NOT CHANGE: define locations for unit tests data and replication data
export CBIG_TESTDATA_DIR=/mnt/eql/yeo1/CBIG_test_data/unit_tests
export CBIG_REPDATA_DIR=/mnt/eql/yeo1/CBIG_test_data/replication

# DO NOT CHANGE: define scheduler location
export CBIG_SCHEDULER_DIR=/apps/sysapps/TORQUE/bin
 
# DO NOT CHANGE: set up your environment with the configurations above
SETUP_PATH=${CBIG_CODE_DIR}/setup/CBIG_generic_setup.sh
source $SETUP_PATH

# DO NOT CHANGE: set up temporary directory for MRIread from FS6.0 for CBIG 
# members using the HPC, Other users should comment this out
#export TMPDIR=/tmpstore

# Do NOT CHANGE: set up MATLABPATH so that MATLAB can find startup.m in our repo 
export MATLABPATH=$CBIG_CODE_DIR/setup

# Matlab Setup
export MATLABROOT=/opt/matlab