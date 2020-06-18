#! /bin/sh
#

# DO NOT CHANGE: This clears old freesurfer variables if they previously exists
if [ -n "$FREESURFER_HOME" ]; then
	$FREESURFER_HOME/bin/clear_fs_env.csh 
fi

### activating software on E2:
# Load biogrids (provides: afni, ANTs, datalad, freesurfer v6.0.1, spm, and wb_command)
source /programs/biogrids.shrc
export BIOGRIDS_BIN=/programs/x86_64-linux/system/biogrids_bin

# Load Matlab
module load matlab

#Load FSL
module load fsl
source ${FSLDIR}/etc/fslconf/fsl.sh

# Load Specific Freesurfer version
export FS_LICENSE=/programs/local/licenses/freesurfer/license.txt
export SUBJECTS_DIR=/lab-share/Neuro-Cohen-e2/Public/projects/FS_default_subjects
export FREESURFER_HOME=/lab-share/Neuro-Cohen-e2/Public/software/freesurfer
source ${FREESURFER_HOME}/SetUpFreeSurfer.sh

# PLEASE CHANGE: Please specify location of CBIG repository
export CBIG_CODE_DIR=/lab-share/Neuro-Cohen-e2/Public/repos/Standalone_CBIG_fMRI_Preproc2016

# PLEASE CHANGE: define locations for these libraries
## Many of these identified on E2 using 'command --sbapp:L'
export FREESURFER_HOME=$FREESURFER_HOME
export CBIG_MATLAB_DIR=/programs/local/MATLAB/R2019a
export CBIG_SPM_DIR=/lab-share/Neuro-Cohen-e2/Public/software/spm12
export CBIG_AFNI_DIR=/programs/x86_64-linux/afni/19.2.01/bin
export CBIG_ANTS_DIR=/programs/x86_64-linux/ants/2.3.1/bin
export CBIG_WB_DIR=/programs/x86_64-linux/workbench/1.4.2
export CBIG_FSLDIR=${FSLDIR}
export CBIG_CARET_DIR=/lab-share/Neuro-Cohen-e2/Public/software/caret

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

