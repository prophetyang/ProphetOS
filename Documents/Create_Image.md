dd if=/dev/zero of=dummy.img bs=1M count=32
32+0 records in
32+0 records out
33554432 bytes (34 MB, 32 MiB) copied, 0.0474219 s, 708 MB/s


fdisk dummy.img

Welcome to fdisk (util-linux 2.27.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xcd7543c2.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-65535, default 2048):
Last sector, +sectors or +size{K,M,G,T,P} (2048-65535, default 65535):

Created a new partition 1 of type 'Linux' and of size 31 MiB.

Command (m for help): a
Selected partition 1
The bootable flag on partition 1 is enabled now.

Command (m for help): p
Disk dummy.img: 32 MiB, 33554432 bytes, 65536 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xcd7543c2

Device     Boot Start   End Sectors Size Id Type
dummy.img1 *     2048 65535   63488  31M 83 Linux

Command (m for help): w
The partition table has been altered.
Syncing disks.



mkfs.ext4 -E offset=$((2048 * 512)) dummy.img
mke2fs 1.42.13 (17-May-2015)
Found a dos partition table in dummy.img
Proceed anyway? (y,n) y
Discarding device blocks: done
Creating filesystem with 32768 1k blocks and 8192 inodes
Filesystem UUID: 4fb1c942-f0a5-49bb-8398-9931d8cc4fd1
Superblock backups stored on blocks:
        8193, 24577

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done


mount -o loop,offset=$((2048 * 512)) dummy.img img


