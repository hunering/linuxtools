#!/bin/bash
source ./common.sh

qemu-system-x86_64 -nographic -no-kvm -kernel ${kernel_image} -initrd ${initrd_image} -smp 2 -gdb tcp::1234  -S