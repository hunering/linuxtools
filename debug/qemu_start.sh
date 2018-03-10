#!/bin/bash
source ./common.sh

#qemu-system-x86_64 -nographic -no-kvm -kernel ${kernel_image} -initrd ${initrd_image} -smp 2 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -smp 1 -gdb tcp::1234  -S
#qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -initrd ${rootfs_image} -smp 1 -gdb tcp::1234  -S
qemu-system-x86_64 -no-kvm -kernel ${kernel_image} -initrd ${rootfs_image} -append "root=/dev/ram rdinit=/bin/sh" -smp 1
