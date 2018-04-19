#!/bin/bash
source ./common.sh
make -C ${src_dir} -j `getconf _NPROCESSORS_ONLN` O=./build
