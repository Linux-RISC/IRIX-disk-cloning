# IRIX-disk-cloning
IRIX script to clone an IRIX XFS disk

Main reference (it's currently offline): http://www.futuretech.blinkenlights.nl/disksfiles.html#CLONE

We assume that the first disk is connected to controller 0 with ID 1 and the second disk to the same controller but with ID 2.

Boot on single user mode:

```
# init s
```


Create the mount point /disk2 on root directory:
```
# mkdir /disk2
```


Partition disk 2:
```
# fx -x                           # Run fx
<Enter>                           # Select dksc
<Enter>                           # Select controller 0
2                                 # Select drive 2
<Enter>                           # Select lun 0
  
l                                 # Label menu
c                                 # Create a new label
a                                 # All
sy                                # Write out the new label
..                                # Return to the main menu
  
r                                 # Select repartition option
ro                                # Select root drive option
<Enter>                           # Select XFS
yes                               # Yes, continue with the operation
/exit                             # Exit fx
```


Clone disk 1 to disk 2 using the script <a href="clone.sh">clone.sh</a>:
```
# http://www.futuretech.blinkenlights.nl/disksfiles.html#CLONE

# boot before using init s

mkfs -b size=4096 /dev/dsk/dks0d2s0

mount /dev/dsk/dks0d2s0 /disk2
cd /disk2

#xfsdump -l 0 -p 5 - / | xfsrestore - .
timex xfsdump -l 0 -p 5 - / | xfsrestore - .

cd /stand
dvhtool -v get sash sash /dev/rdsk/dks0d1vh
dvhtool -v get ide ide /dev/rdsk/dks0d1vh
dvhtool -v creat sash sash /dev/rdsk/dks0d2vh
dvhtool -v creat ide ide /dev/rdsk/dks0d2vh

cd /
umount /disk2
```


To boot from the second hard disk, run on Command Monitor:
```
setenv OSLoadPartition dksc(0,2,0)
setenv SystemPartition dksc(0,2,8)
```


Some statistics:
- clone 9.1 GB to 18.2 GB: 20 minutes
- clone 18.2 GB to 36.4 GB: 8.5 minutes (secondary disk is faaaaaast!)
<img src="clone to 36 GB disk.jpg">
