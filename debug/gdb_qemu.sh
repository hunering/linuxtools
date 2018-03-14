#/bin/bash
source ./common.sh

#cd ./${build_dir}
#gdb ${gdb_param} ./vmlinux

if [ $# -ne 1 ]
then
  echo "run gdb in the normal mode: connect to qemu, then disconnect, and connect again"
  gdb_firstrun
  gdb_secondrun
else
  if [ $1 == '1' ]; then 
    echo "run gdb only for the second round" 
    gdb_firstrun
  else 
    echo "run gdb only for the second round"
    gdb_secondrun
  fi
  
fi


