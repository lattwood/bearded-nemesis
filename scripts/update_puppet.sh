#!/usr/bin/env bash
base=$(dirname $BASH_SOURCE)
. "${base}/functions.sh"

install_dir=puppet/modules/vendor
puppetfile=./Puppetfile

mkdir -p $install_dir

PUPPETFILE=$puppetfile PUPPETFILE_DIR=$install_dir r10k --verbose 3 puppetfile install

