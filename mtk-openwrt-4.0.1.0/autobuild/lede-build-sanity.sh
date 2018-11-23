#!/bin/sh
#
# There are 2 env-variables set for you, you can use it in your script.
# ${BUILD_DIR} , working dir of this script, eg: openwrt/lede/
# ${INSTALL_DIR}, where to install your build result, including: image, build log.
#

#Global variable
BUILD_TIME=`date +%Y%m%d%H%M%S`
build_flag=0
recover_list=

if [ -z ${BUILD_DIR} ]; then
	LOCAL=1
	BUILD_DIR=`pwd`
fi


if [ -z ${INSTALL_DIR} ]; then
	INSTALL_DIR=autobuild_release
	mkdir -p ${INSTALL_DIR}
	if [ ! -d target/linux ]; then
		echo "You should call this scripts from lede's root directory."
	fi
fi

clean() {
	
	echo "clean start!"
	echo "It will take some time ......"
	make distclean
	rm -rf ${INSTALL_DIR}
	echo "clean done!"
}

copy_main_Config(){

	echo cp -rfa autobuild/$1/.config ./.config
	cp -rfa autobuild/$1/.config ./.config

}


copy_additional_Config(){

        if [ -f autobuild/$1/config-4.4 ]; then
		
		echo cp -rfa autobuild/$1/config-4.4 ./target/linux/mediatek/mt${2:0:4}/config-4.4
        	cp -rfa autobuild/$1/config-4.4 ./target/linux/mediatek/mt${2:0:4}/config-4.4
		
		recover_list+=./target/linux/mediatek/mt${2:0:4}/config-4.4
	fi

}

install_output_Image() {
	
	mkdir -p ${INSTALL_DIR}/$1

	bin_files=`find bin/targets/mediatek/*${2:0:4}* -name "*.bin"`
	file_count=0

	for file in $bin_files
	do
		tmp=${file%.*}
		cp -rf $file ${INSTALL_DIR}/$1/${tmp##*/}-${BUILD_TIME}.bin
		((file_count++))
        done

	if [ ${file_count} = 0 ]; then
		if [ ${build_flag} -eq 0 ]; then
			let  build_flag+=1
			echo " Restart to debug-build with "make V=s -j1", starting......"
			build $1 -j1 || [ "$LOCAL" != "1" ]
        	else
			echo " **********Failed to build $1, bin missing.**********"
		fi	
	else
		echo "Install image OK!!!"
		echo "Build $1 successfully!"
	fi

}

install_output_Config() {

	echo cp -rfa autobuild/$1/.config ${INSTALL_DIR}/$1/lede.config
	cp -rfa autobuild/$1/.config ${INSTALL_DIR}/$1/lede.config
	
	[ -f tmp/kernel.config ] && cp tmp/kernel.config ${INSTALL_DIR}/$1/kernel.config

}

install_output_KernelDebugFile() {

	KernelDebugFile=bin/targets/mediatek/mt${2:0:4}*/kernel-debug.tar.bz2
	if [ -f ${KernelDebugFile} ]; then
		echo cp -rfa ${KernelDebugFile} ${INSTALL_DIR}/$1/kernel-debug.tar.bz2
		cp -rfa ${KernelDebugFile} ${INSTALL_DIR}/$1/kernel-debug.tar.bz2
	fi

}

recover_Files() {

        git checkout $1
}


build() {
	echo "###############################################################################"
	echo "# $1"
	echo "###############################################################################"
	echo "build $1"

        echo ln -s ../dl dl
	ln -s ../dl dl
         
	[ -f autobuild/$1/.config ] || {
		echo "unable to locate autobuild-scripts/$1/.config !"
		return
	}

	temp=${1#*mt}

   	#copy main test config(.config)
	copy_main_Config $1

	#copy additional test config "if exit", and add it to "recover_list"
	copy_additional_Config $1 ${temp}

	echo make defconfig
	make defconfig

    	#make
	echo make V=s $2
	make V=s $2
        
	#install output image
	install_output_Image $1 ${temp}

	#install output config
	install_output_Config $1

	#install output Kernel-Debug-File
	install_output_KernelDebugFile $1 ${temp}

	#recover files
	if [ -n "${recover_list}" ]; then
		recover_Files ${recover_list}
	fi
}
