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
export FREESURFER_HOME=/opt/freesurfer-6.0.0
export FS_LICENSE=${FREESURFER_HOME}/license.txt
source ${FREESURFER_HOME}/SetUpFreeSurfer.sh

# PLEASE CHANGE: Please specify location of CBIG repository
export CBIG_CODE_DIR=/repos/CBIG_compiled

# PLEASE CHANGE: define locations for these libraries
export FREESURFER_HOME=${FREESURFER_HOME}
# export CBIG_MATLAB_DIR=/opt/matlab/current
export CBIG_SPM_DIR=/spm12
export CBIG_AFNI_DIR=/opt/afni-latest
export CBIG_ANTS_DIR=/opt/ants-2.2.0
export CBIG_WB_DIR=${caladan_opt}/workbench
export CBIG_FSLDIR=/opt/fsl-5.0.10

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
# export MATLABPATH=$CBIG_CODE_DIR/setup

# Matlab Setup
# 	export MATLABROOT=/opt/matlab/current
# MCR Setup
#	export MCRROOT=${MATLABROOT}
	export MCRROOT=/usr/lib/x86_64-linux-gnu:/opt/matlabmcr-2021a/v94/
	LD_LIBRARY_PATH=.:${MCRROOT}/runtime/glnxa64 ;
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/bin/glnxa64 ;
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/sys/os/glnxa64;
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${MCRROOT}/sys/opengl/lib/glnxa64;
	export LD_LIBRARY_PATH;
	# Preload glibc_shim in case of RHEL7 variants
  	test -e /usr/bin/ldd &&  ldd --version |  grep -q "(GNU libc) 2\.17" \
	&& export LD_PRELOAD="${MCRROOT}/bin/glnxa64/glibc-2.17_shim.so"

# specified the default Python environment.
# Please UNCOMMENT if you follow CBIG's set up for Python environments.
# We use Python version 3.5 as default.
# Please see $CBIG_CODE_DIR/setup/python_env_setup/README.md for more details.
# source activate CBIG_py3
