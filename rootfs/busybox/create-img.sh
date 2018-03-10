cd _install
find . | cpio -o --format=newc > ../rootfs.img
