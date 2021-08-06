#!/bin/bash

RELEASE=$1
ISO_FILE=iso/smr-ubuntu-$RELEASE.iso

aws s3 cp $ISO_FILE s3://smr-iso/.
