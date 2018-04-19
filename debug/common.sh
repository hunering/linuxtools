#/bin/bash
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
dir_name=$(dirname $ABSOLUTE_PATH)
echo "The scripth installer running at $dir_name"

src_dir=../../../linux/src/linux
#src_dir=../../../linux/src/linux-2.6.39
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

qemu_start()
{
  QEMU_START_COMMAND='qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -hda ${hda_image} -hdb ${hdb_image}  -initrd ${rootfs_image}  -append "root=/dev/ram rdinit=/etc/init.d/rcS debug " -smp 1 -serial file:serial.out -display sdl -vga std -gdb tcp::1234'

  if [ $# -ne 1 ]
  then
    echo "run qemu in the normal mode: start qemu with -S and wait for the debugger"
    echo "start qemu using command: ${QEMU_START_COMMAND} -S"
    eval ${QEMU_START_COMMAND}' -S &'
  else
    if [ $1 == '1' ]; then 
      echo "start qemu, then break at start_kernel"
      eval ${QEMU_START_COMMAND}' -S &'
      sleep 2s
      gdb_firstrun
    else 
      echo "start qemu and boot"
      eval ${QEMU_START_COMMAND}' &'
    fi
  
  fi
}
