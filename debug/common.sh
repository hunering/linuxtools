#/bin/bash
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
dir_name=$(dirname $ABSOLUTE_PATH)
echo "The scripth installer running at $dir_name"

src_dir=../../../linux/src/linux-4.15.7
build_dir=${src_dir}/build
kernel_image=${build_dir}/arch/x86_64/boot/bzImage
initrd_image=./initrd.img-4.13.0-36-generic

gdb_param=
dbg_serial=/tmp/dbgserial
