# The "BIDS to CBIG_fMRI_Preproc2016" Wrapper script
This repository contains simple scripts for applying the CBIG pre-processing pipeline (https://github.com/ThomasYeoLab/Standalone_CBIG_fMRI_Preproc2016) to a BIDS-formatted directory

[![DOI](https://zenodo.org/badge/260431820.svg)](https://zenodo.org/badge/latestdoi/260431820)

## Usage:
```
# Whole BIDS directory:
BIDS_parallel.sh <num_of_threads_per_machine> BIDS_CBIG_fMRI_preprocess.sh <bids_dir> <config_file>

/fileserver/caladan_ssd/repos/BIDS_to_CBIG_fMRI_Preproc2016/BIDS_parallel.sh \
    64 \
    /fileserver/caladan_ssd/repos/BIDS_to_CBIG_fMRI_Preproc2016/BIDS_CBIG_fMRI_preprocess.sh \
    /fileserver/corrin/collections/GSP \
    /fileserver/caladan_ssd/repos/BIDS_to_CBIG_fMRI_Preproc2016/configs/Legacy_GSP.config


# Single Subject:
BIDS_CBIG_fMRI_preprocess.sh <bids_dir> <participant_id> <config_file>

/fileserver/caladan_ssd/repos/BIDS_to_CBIG_fMRI_Preproc2016/BIDS_CBIG_fMRI_preprocess.sh \  
    /fileserver/corrin/collections/GSP sub-0001 \  
    /fileserver/caladan_ssd/repos/BIDS_to_CBIG_fMRI_Preproc2016/configs/Legacy_GSP.config
```

## Notes
### CBIG-related
- We have our own fork of the original CBIG repository that is confirmed to work with this code, and was used to create the *GSP1000* normative connectome, available here: (https://github.com/bchcohenlab/CBIG)
- Minor modifications were made to allow for a separate smoothing mask for subcortical/cerebellum vs the rest of the brain, as was done in [Buckner et al, 2011](https://doi.org/10.1152/jn.00339.2011) but was retired from the CBIG pipeline since.
- The **Legacy_GSP.config** is the exact processing steps used to generate the GSP1000 connectome, and closely approximates the original *Yeo1000* connectome generated in 2010 and viewable in [neurosynth.org](https://neurosynth.org)

### If using the [original CBIG pipeline](https://github.com/ThomasYeoLab/Standalone_CBIG_fMRI_Preproc2016)
- `CBIG_preproc_fslmcflirt_outliers.csh` appears to have a bug:
  - Line 170: set numof_tps = `fslnvols $boldfile"_mc_tmp"`
  - Should be: set numof_tps = `fslnvols $boldfile`
- Requires git 2.x (due to use of -C option)
    - For Centos 7:
        ```
        sudo yum install -y https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        sudo yum install -y yum-plugin-replace
        sudo yum replace -y git --replace-with git224
        ```
- Pipeline config files need all options for each step on a single line, not separated with slashes
- Comments in pipeline config files need # marks as the first character of the line (no preceeding spaces)

### Wrapper script-related
- Can use a `CBIG_config.sh` file in the `<bids_dir>/code` directory (this can be omitted if you set paramaters at log-in)
- Requires `jq` be installed to parse the BIDS json files
- Requires a `task-rest_bold.json` either in the study directory or the `<bids_dir>/<participant_id>/func` directory
- Requires freesurfer already available for each subject and in standard directory: `<bids_dir>/derivatives/<freesurfer>/<participant_id>`
- Requires that config files MUST use an extension of `.config`
- Output is stored in `<bids_dir>/derivatives/CBIG_fMRI_preprocess_<config_name>/<participant_id>`
