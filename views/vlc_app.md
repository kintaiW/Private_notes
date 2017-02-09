##Vlc项目点滴
---
###1. 简介
*Vlc for Android* 是一个开源播放器.

###2. 项目文档
####2.1 __源码获取__: [官方网址](https://code.videolan.org/videolan/vlc-android/branches)

  * 建议选2.0.x版本的VLC-Android(已亲测)
  * 根据编译脚本 *compile.sh*,源码编译步骤如下
    * *gradle*构建,默认下载目录为*$HOME/.gradle/wrapper/dists/...*(...是具体版本,例如2.10\2.14.1)
    * vlc源码,__$__:git clone git://git.videolan.org/vlc.git vlc
    * so编译,文件 *compile-libvlc.sh*
    * apk生成
  * 注意:
    * gradle的 *-bin.zip, *-all.zip下载耗时久且不稳定,可自行下载放置gradle配置目录(即默认下载目录),及修改 *compile.sh* 注释wget与checkfail行
    * vlc源码download之后不要忘记回退,例如__$__:git reset --hard 6689dcb(查看 *compile.sh* 里面的 TESTED_HASH值)

####2.2 __编译__: __$__:./compile.sh

  * 操作系统: ubuntu14.04.5 LTS 64位   
    * __$__:cat /etc/issue 
  * 内核版本:3.16.0-40-generic   
    * __$__:uname -r
  * 基础依赖: *Android-Studio* 下载SDK(9,21)及NDK(13)   
    * 默认下载后在 *$HOME/Android* , *ndk-bundle* 为NDK目录
  * JDK: 7/8都可以,以下是项目环境配置例子   
    * __$__:vim ~/.bashrc

    <div class="sourceCode"><pre class="prettyprint">
      #java environment setting
      export JAVA_HOME =(*JDK的绝对路径*)/java-7-oracle
      export JRE_HOME  =${JAVA_HOME}/JRE
      export CLASSPATH =.:${JAVA_HOME}/lib:${JRE_HOME}/lib
      export PATH      =${JAVA_HOME}/bin:$PATH
      #Android SDK NDK environment setting
      export ANDROID_ABI=armeabi-v7a
      SDK = (*SDK的绝对路径*)/Sdk
      NDK = (*NDK的绝对路径*)/Sdk/ndk-bundle
      export ANDROID_SDK=$SDK
      export ANDROID_NDK=$NDK
    </pre></div>


####2.3 __快捷方式__: 

#####2.3.1 第三方库
  * 你的项目所在位置,以下省略 ${your_project_path} <==> ${u_path}
  * 第三方库XXX函数没定义或无引用
    * 一定要确保 *vlc* 源码版本一致性(TESTED_HASH值)
    * 第三方库下载后存放在${u_path}/vlc/contrib/tarballs, *vlc* 版本不同第三方库版本亦不一致
    * 二次编译可能会出现,inflateReset2函数无引用,在Android.mk LDLIBS中加入$(VLC_BUILD_DIR)/../contrib/arm-linux-androideabi/lib/libz.a \
  * opencv函数无定义或无引用
    * 治本的解决方案是修改相关编译脚本 *${u_path}/libvlc/jni/Android.mk* 
    * 如果尝试失败,这里提供治标的方案,在 *compile-libvlc.sh* 文件中注释掉自动写入${u_path}/libvlc/jni/libvlcjni-modules.c与libvlcjni-symbols.c行(行首printf),然后在该两文件中注释掉包含opencv字眼的行

#####2.3.2 bootstrap
  * 很多子目录下,bootstrap文件是用来检测环境配置,依赖相关的问题,报错需留意,例如GCC,Autotools系列工具版本不对 

#####2.3.3 底层算法
  * 如何截取底层传输的YUV数据
    * 在${u_path}/vlc/src/video_output/video_output.c中 *vout_PutPicture* 函数中作处理, *vout_GetPicture* 是播放后的数据,马上刷新
  * 如何修改在底层嵌入算法,例如移图
    * 在${u_path}/vlc/src/Makefile.am中 Building libvlc下加入,再独立添加一个模块,加入 *.c/cpp与 *.h等等
