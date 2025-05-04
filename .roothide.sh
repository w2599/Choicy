#!/bin/bash
# export LC_ALL=C
export THEOS=/Users/zqbb/theos_roothide
export THEOS_DEVICE_IP=192.168.31.158
export THEOS_DEVICE_PORT=2222
export ARCHS=arm64e

#取绝对路径
tweakPath=$(cd "$(dirname "$0")";pwd)
buildPath="$(dirname "$tweakPath")/__build_roothide/$(basename "$tweakPath")"
echo "tweakPath: $tweakPath"
echo "buildPath: $buildPath"
cd $tweakPath
# make clean


versionFile=$(ls _version_* | head -n 1)
versionSee=$(echo $versionFile | sed 's/_version_//g')

# 备份原文件
rm -rf $buildPath && mkdir -p $buildPath && cp -a ./ $buildPath && cd $buildPath

##替换版本号
sed -i '' "s/^\(Version:\s*\).*/\1 ${versionSee}/" control
echo "编译版本号为${versionSee}"



if [ $1 -eq "0" ]
then
    export package FINALPACKAGE=1
	export THEOS_PACKAGE_SCHEME=roothide

	make do -j$(sysctl -n hw.physicalcpu)
	cp -f ./packages/*.deb /Users/zqbb/Documents/GitHub/myTweaks/roothide/
	exit
fi


if [ $1 -eq "1" ]
then
	export THEOS_PACKAGE_SCHEME=roothide
	make do 
	exit
fi
