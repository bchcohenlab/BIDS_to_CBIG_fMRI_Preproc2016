#!/bin/bash
# Script to batch run a pipeline in parallel for a BIDS dataset

# Presumes scripts can make their own directories in <bids_dir>/derivatives

if [ $# -lt 1 ] ; then
	echo "Usage: $0 <number_of_threads> <script_to_run> <bids_dir> <all_the_arguments>"
	echo "e.g. $0 ____"
	echo "====================================="
	echo ""
	echo "This script..."
	echo "output:"
	echo "In <bids_dir>/derivatives/___/<participant_id>:"
	echo "1) "
	echo "2) "
	echo "3) "
	echo ""
	echo "====================================="
	echo ""
	echo ""
	exit 1 ;
fi

number_of_threads=$1
script_to_run=$2
bids_dir=$3
shift 3
script_arguments=$*

echo ""
echo number_of_threads = ${number_of_threads}
echo script_to_run = ${script_to_run}
echo bids_dir = ${bids_dir}
echo script_arguments = ${script_arguments}
echo ""

pushd ${bids_dir}

	#subject_list=`ls -d sub*`

	ls -d sub* | \
	parallel \
	--max-args 1 \
	-j ${number_of_threads} \
	--delay 15 \
	--eta \
	--sshlogin :,caladan \
	"${script_to_run} ${bids_dir} {} ${script_arguments} \
	> {}.log"

popd
