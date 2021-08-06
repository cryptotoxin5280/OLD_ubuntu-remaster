# Sea Machines Robotics Ubuntu ISO Remastering Tool
This tool generates a 'remastered' version of the Ubuntu ISO installation media that performs a completely automated install of the Ubuntu OS and any additional specified softare.

## What the tool does under the hood...
1. Downloads Ubuntu Server ISO image.

2. Copies SMR software and install scripts onto the ISO image.

3. Copies custom 'preseed' instructions onto the ISO image that automate the entire install process, including: OS install, SMR software install and configuration, and 

4. Modifies both the Legacy and UEFI boot configurations.

## Usage Instructions

1. Generate an SMR-Remastered Ubuntu ISO Image
`sudo ./make-iso.sh [SMR Version Number]`

_The image file is generated under the 'iso' directory._

2. Publish the ISO to AWS S3.
`./publish-iso.sh [SMR Version Number]`

3. Clean up the 'ISO' and 'stage' folders.
`./clean.sh`

## Burning the ISO to USB
The generated ISO image can be burned onto a bootable USB stick with the following opensource application:

balenaEtcher
https://www.balena.io/etcher/

## Support for Additional Software Installs
Additional install modes (AC, AICV, and Beacon) can be easily incorporated into the ISO image through the following steps:

1. Modify the make-iso.sh script to download additional install scripts into the 'stage/smr-software' directory before the image is burned.

2. Add a new 'software.seed' file to the 'preseed' directory.

3. Modify the Legacy (boot/txt.cfg) and UEFI (boot/grub.cfg) files with a new boot option that leverages the new preseed file.

4. Submit a pull-request with the changes.