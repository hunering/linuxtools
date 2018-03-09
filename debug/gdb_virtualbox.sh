#/bin/bash
source ./common.sh

echo "src dir is ${src_dir}"
cd ./${src_dir}
gdb ${gdb_param} ./vmlinux 
