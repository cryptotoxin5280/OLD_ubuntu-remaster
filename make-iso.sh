#!/bin/bash

SMR_RELEASE=$1
TAG=SMR-UBUNTU-$SMR_RELEASE
BUILD_DIR=~/iso
IMAGE_FILE=smr-ubuntu-$RELEASE.iso

# 1. Download ISO
wget -O ~/Downloads/ubuntu.iso https://cdimage.ubuntu.com/releases/18.04.5/release/ubuntu-18.04.5-server-amd64.iso

# 2. Mount ISO
sudo mkdir -p /mnt/iso
sudo mount -o loop ~/Downloads/ubuntu.iso /mnt/iso

# 2. Copy the image content to a staging directory
mkdir iso
cp -rT /mnt/iso iso

# 4. Unmount the ISO
sudo umount /mnt/iso

# 5. Overwrite the UEFI boot loader file in the ISO staging directory
sudo cp boot/grub2.cfg iso/boot/grub/.

# 6. Overwrite the legacy boot loader file in the ISO staging directory
sudo cp boot/txt.cfg iso/isolinux/.

# 7. Copy the preseed files into the ISO staging directory
sudo cp -rf smr-preseed iso/.

# 8. Copy software packages into the ISO staging directory
sudo cp -rf smr-software iso/.

# 9. Create the new ISO
mkisofs -r -V $TAG \
  -cache-inodes \
  -J -l -b isolinux/isolinux.bin \
  -c isolinux/boot.cat -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  -o $IMAGE_FILE \
  $BUILD_DIR
