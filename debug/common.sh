#/bin/bash
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
dir_name=$(dirname $ABSOLUTE_PATH)
echo "The scripth installer running at $dir_name"

src_dir=../../../linux/src/linux-4.15.7
build_dir=${src_dir}/build
kernel_image=${build_dir}/arch/x86_64/boot/bzImage
initrd_image=./initrd.img-4.13.0-36-generic
rootfs_image=../rootfs/busybox/rootfs.img
hda_image=../rootfs/qemu/linux-0.2.img
hdb_image=../rootfs/qemu/debian_wheezy_amd64_standard.qcow2

gdb_param=
dbg_serial=/tmp/dbgserial

#the reason that we split the gdb to two-round is because gdb has bug when processor architecture changed:
#https://stackoverflow.com/questions/8662468/remote-g-packet-reply-is-too-long/34304137#34304137" 
gdb_firstrun()
{
  gdb \
    -ex "add-auto-load-safe-path $(pwd)" \
    -ex "file ${build_dir}/vmlinux" \
    -ex 'set arch i386:x86-64:intel' \
    -ex 'target remote localhost:1234' \
    -ex 'break start_kernel' \
    -ex 'continue' \
    -ex 'disconnect' \
    -ex 'quit'
}

gdb_secondrun()
{
  gdb \
    -ex "add-auto-load-safe-path $(pwd)" \
    -ex "file ${build_dir}/vmlinux" \
    -ex 'set arch i386:x86-64' \
    -ex 'target remote localhost:1234'
}
