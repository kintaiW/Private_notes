##Ubuntu相关
---

###1. 操作方便
* __[右键终端]__: 可随处右键打开终端
	* __$__: sudo apt-get install nautilus-open-terminal

###2. wine
* 安装这个在Ubuntu之后就可以用windows上的软件了,例如Source Insight
  * __注意__: 安装期间选项是按 *Tab* 键切换

###3. 依赖库
* __ia32-libs__: Ubuntu14.04已经移除了该源,有个替换的库,但很多工程不兼容,这里提供强制安装的方法
  * __$__:sudo su
  * __$__:cd /etc/apt/sources.list.d
  * __$__:echo "deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse" > ia32-libs-raring.list
  * __$__:apt-get update
  * __$__:apt-get install ia32-libs
  * __$__:rm ia32-libs-raring.list
  * __$__:apt-get update
* 切换到root权限,进入apt源列表,添加ubuntu13.04的源(13.10后续本版无ia32-libs),更新源并安装,最后恢复源

