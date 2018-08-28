#/bin/bash
source ./common.sh

#cd ./${build_dir}
#gdb ${gdb_param} ./vmlinux
gdb_load_kernel
