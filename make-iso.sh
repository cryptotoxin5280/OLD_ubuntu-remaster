#!/bin/bash

RELEASE=$1
TAG=SMR-UBUNTU-$RELEASE
STAGE_DIR=stage
ISO_FILE=iso/smr-ubuntu-$RELEASE.iso

# 1. Download ISO
wget -O /tmp/ubuntu.iso https://cdimage.ubuntu.com/releases/18.04.5/release/ubuntu-18.04.5-server-amd64.iso

# 2. Mount ISO
mkdir -p /mnt/iso
mount -o loop /tmp/ubuntu.iso /mnt/iso

# 2. Copy the image content to a staging directory
mkdir -p stage
cp -rT /mnt/iso stage

# 4. Unmount the ISO
sudo umount /mnt/iso

# 5. Overwrite the UEFI boot loader file in the ISO staging directory
cp boot/grub.cfg $STAGE_DIR/boot/grub/.

# 6. Overwrite the legacy boot loader file in the ISO staging directory
cp boot/txt.cfg $STAGE_DIR/isolinux/.

# 7. Copy the preseed files into the ISO staging directory
cp -rf smr-preseed $STAGE_DIR/.

# 8. Copy software packages into the ISO staging directory
cp -rf smr-software $STAGE_DIR/.

# 9. Create the new ISO
mkdir iso
mkisofs -r -V $TAG \
  -cache-inodes \
  -J -l -b isolinux/isolinux.bin \
  -c isolinux/boot.cat -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  -o $ISO_FILE \
  $STAGE_DIR
