##构建系统
---

###1. 一个比较通用的Makefile
这个Makefile是刚工作那会调试OpenCV库,通用的模板.   
基本用法就是替换OBJS里面的文件:
<div class="sourceCode"><pre class="prettyprint">
    TARGET = test
    
    OBJS = main.o Laser_segmentation.o Utils.o test.o Point_cloud_generation.o
    
    CXX ?= g++
    
    CXXFLAGS += -c -Wall $(shell pkg-config --cflags opencv) -I/usr/include/opencv2/ -Iinclude/
    LDFLAGS += $(shell pkg-config --libs --static opencv)
    
    all: $(TARGET)
    
    $(TARGET):$(OBJS)
    	$(CXX) $(OBJS) -o $@ $(LDFLAGS)
    
    %.o: %.cpp
    	$(CXX) $< -o $@ $(CXXFLAGS)
    
    
    clean: ; rm -f $(TARGET)  $(OBJS) *~
</pre></div>

[Tips](http://goodcandle.cnblogs.com/archive/2006/03/30/278702.html/)


###2. autotools
* 这段时间编译了 **VLC** 源码,做 **Android** 平台的播放器, *vlc* 是用 *autotools* 管理 *Makefile* 的.
* [coming soon](https://segmentfault.com/a/1190000006997516)
