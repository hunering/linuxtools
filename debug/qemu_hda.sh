#!/bin/bash 
source ./common.sh

#qemu-system-x86_64 -nographic -no-kvm -kernel ${kernel_image} -initrd ${initrd_image} -smp 2 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -smp 1 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -initrd ${rootfs_image} -smp 1 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -initrd ${rootfs_image} -append "root=/dev/ram rdinit=/bin/sh" -smp 1
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -hda ${hda_image}  -initrd ${rootfs_image}  -append "root=/dev/ram init=/bin/sh console=ttyS0,38400 debug" -smp 1 -serial file:serial.out
qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -boot c -hda ${hdb_image} -append "root=/dev/hda console=ttyS0,38400 debug" -smp 1 -serial file:serial.out
