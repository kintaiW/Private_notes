##C语言拾遗
---
###1. C中如何调用C++函数
>vlc项目中,由于源码架构是C语言实现的,编译构建是autotools   
>故在做二次开发时会遇到很多问题,这就是其中一个

* __普通函数__: c 与 cpp 之间再写一个test_interface.cpp文件及其头文件test_interface.h
  * 注意编译器,不然还是会引起函数无引用的编译错误

  <div class="sourceCode"><pre class="prettyprint">
    //test_interface.cpp
    #ifdef __cplusplus
    extern "C" {
    #endif
    #include "test_interface.h"
    #ifdef __cplusplus
    }
    #endif
    void test_int(vout_thread_t *vout){
     msg_Dbg(vout,"To do...");
    }
    //test_interface.h
    #ifndef TEST_INTERFACE_H
    #define TEST_INTERFACE_H
    void test_int(vout_thread_t *vout);
    #endif
  </pre></div>

  * 现在即可在C文件中直接调用 *test_int* 函数

* __[成员函数](http://cppblog.com/franksunny/archive/2007/11/29/37510.html)__

####1.1 函数重载

> 在C中调用C++函数往往就会出现无引用的编译错误

* 假设有一函数,test_int(int i)   
  * __C__: 编译后得到 *test_int* 函数符号  
  * __C++__: 编译后得到 *test_int_int* 函数符号  
* 因此C++支持函数重载,而C不支持

###2. 结构体
####2.1 ->与.
> 在写的代码时,常常有各种a->b->c, a->b.c, a.b->c等等,其实区分很简单

* 假设结构体 *vout* ,有如下两种声明

  <div class="sourceCode"><pre class="prettyprint">
    struct vout{
     int age;
    };
  </pre></div>

* __sturct vout * v__: 第一种情况,使用 *v->age*
  * 结构指针->结构成员

* __sturct vout v__: 第二种情况,使用 *v.age*
  * 结构变量.结构成员
