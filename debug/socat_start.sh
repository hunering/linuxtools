#/bin/bash
source ./common.sh

socat -d -d ${dbg_serial} PTY
