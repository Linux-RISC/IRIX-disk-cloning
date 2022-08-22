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
