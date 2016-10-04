#!/bin/sh

image_name=$1
image_size=$2

# create a new image file 
dd if=/dev/zero of=$image_name bs=1M count=$image_size

# format the first partition
mkfs.ext2 -F -E offset=$((2048*512)) $image_name

# setup MBR
fdisk $image_name << 'EOF'

p
n
p
1


a
w
p
EOF

echo "fdisk -l $image_name"
fdisk -l $image_name

