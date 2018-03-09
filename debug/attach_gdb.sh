#/bin/bash
source ./common.sh

cd ./${src_dir}
gdb ${gdb_param} ./vmlinux 
