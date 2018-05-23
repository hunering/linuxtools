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
    echo "run gdb only for the first round" 
    gdb_firstrun
  elif [ $1 == '2' ]; then 
    echo "run gdb only for the second round" 
    gdb_attach
  elif [ $1 == '3' ]; then 
    echo "run gdb then stop qemu at 0x1000000" 
    gdb_stop_at_entry
  else 
    echo "run gdb only for the second round"
    gdb_secondrun
  fi
  
fi


