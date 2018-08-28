To debug the kernel:
1. you will first need to a rootfs:
	a. go the busybox src folder:
		1) make defconfig
		2) make menuconfig (optional, to select what you want to build)
		3) make
		4) make install, this will create _install folder under the src, which contains the build result
	b. copy the busybox/_install folder to rootfs/busybox/_install. rootfs/busybox/_install folder already contains
	   other files that need for an rootfs
	c. navigate to rootfs/busybox/, then run create-img.sh, this will create the rootfs image

2. the debug folder contains the scripts to help the debug process. to debug the kernel using code:
	a. 
