#!/bin/bash
source ./common.sh

#qemu-system-x86_64 -nographic -no-kvm -kernel ${kernel_image} -initrd ${initrd_image} -smp 2 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -smp 1 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -initrd ${rootfs_image} -smp 1 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -initrd ${rootfs_image} -append "root=/dev/ram rdinit=/bin/sh" -smp 1
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -hda ${hda_image}  -initrd ${rootfs_image}  -append "root=/dev/ram init=/bin/sh console=ttyS0,38400 debug" -smp 1 -serial file:serial.out

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
#sleep 100s
