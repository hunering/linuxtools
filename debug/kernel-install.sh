#/bin/bash
source ./common.sh

cd ./${src_dir}
sudo make modules_install
sudo make install
#cd ..
