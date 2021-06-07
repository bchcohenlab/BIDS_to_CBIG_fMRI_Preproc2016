#! /bin/sh
#

# DO NOT CHANGE: This clears old freesurfer variables if they previously exists
if [ -n "$FREESURFER_HOME" ]; then
	$FREESURFER_HOME/bin/clear_fs_env.csh 
fi

# 2BP Server software location
export caladan_opt=/fileserver/caladan_ssd/opt

# Load Specific Freesurfer version
export SUBJECTS_DIR=/fileserver/caladan_ssd/temp/FS_default_subjects
export FREESURFER_HOME=${caladan_opt}/freesurfer_v6.0.0
export FS_LICENSE=${FREESURFER_HOME}/license.txt
source ${FREESURFER_HOME}/SetUpFreeSurfer.sh

# PLEASE CHANGE: Please specify location of CBIG repository
export CBIG_CODE_DIR=/fileserver/caladan_ssd/repos/CBIG

# PLEASE CHANGE: define locations for these libraries
export FREESURFER_HOME=${FREESURFER_HOME}
export CBIG_MATLAB_DIR=/opt/matlab/current
export CBIG_SPM_DIR=${caladan_opt}/spm12
export CBIG_AFNI_DIR=/home/ch186161/abin
export CBIG_ANTS_DIR=${caladan_opt}/ANTs/install/bin
export CBIG_WB_DIR=${caladan_opt}/workbench
export CBIG_FSLDIR=${caladan_opt}/fsl

# DO NOT CHANGE: define locations for unit tests data and replication data
export CBIG_TESTDATA_DIR=/mnt/eql/yeo1/CBIG_test_data/unit_tests
export CBIG_REPDATA_DIR=/mnt/eql/yeo1/CBIG_test_data/replication

# DO NOT CHANGE: define scheduler location
export CBIG_SCHEDULER_DIR=/apps/sysapps/TORQUE/bin

# DO NOT CHANGE: set up your environment with the configurations above
SETUP_PATH=$CBIG_CODE_DIR/setup/CBIG_generic_setup.sh
source $SETUP_PATH

# DO NOT CHANGE: set up temporary directory for MRIread from FS6.0 for CBIG 
# members using the HPC, Other users should comment this out
#export TMPDIR=/tmpstore

# Do NOT CHANGE: set up MATLABPATH so that MATLAB can find startup.m in our repo 
export MATLABPATH=$CBIG_CODE_DIR/setup

# specified the default Python environment.
# Please UNCOMMENT if you follow CBIG's set up for Python environments.
# We use Python version 3.5 as default.
# Please see $CBIG_CODE_DIR/setup/python_env_setup/README.md for more details.
# source activate CBIG_py3
