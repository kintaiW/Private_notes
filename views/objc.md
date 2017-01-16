##Objective-C Intro
---

###基本概述 

Objective-C 是C语言的扩展集. Objective-C为C语言添加了面向对象等特性.  
基本用法与C语言类似:    

    #import <Foundation/Foundation>

    int main(int argc, const char * argv[] ) {
        NSLog(@"This is a Objective C program");
    }   

Tips:   

* Objective-C不使用__#include__导入依赖, 使用__#import__ . 这个语法是有GCC Style.  
* Foundation类库是objctive-c的基本类库,提供了基本方法.  
* @"", 表示NSString, Objective-C中不直接使用C语言中的字符串
* 所有Objectivce-C的类都具有__NS__前缀, 这跟MFC中所有类都具有__C__前缀一样  
* Objective-C中有个很特殊的类型: __id__, 他可以是任何类型. 它使得Objective-C具有弱类型的特性.

__Important:__

* BOOL 型使用 YES/NO 表示, 不是平时使用的 true/false; 
* 所有类都集成自NSObject;

###C语言的语法基础  

如何定义枚举    
    
    typedef enum {
        kColor,
        kRectange,
        kOblateSpheroid
    } ShapeType;
    
    typedef enum {
        kRedColor,
        kBlueColor,
        kGreenColor,
    } ShapeColor;   

定义结构体

    typedef struct {
        int x, y, width, height;
    } ShapeRect;

    typedef struct {
        ShapeType type;
        ShapeColor fillColor;
        ShapeRect bounds;
    } Shape;    


###Objective C中的OOP   

####接口定义数据类型和方法说明  

    @interface Circle : NSObject	
    {
        ShapeColor fillColor;
        ShapeRect bounds;
    }

    - (void) setFillColor: (ShapeColor) fillColor;

    - (void) setBounds: (ShapeRect) bounds;

    - (void) draw; 

    + (void) staticDraw: (Circle) circle;
    @end    

* 一般情况下@interface写在 *.h 文件中;
* 使用@interface ... @end标示接口申明
* -号, 标示对象方法
* +号, 标示类方法, 对应Java中的static方法
* 方法参数使用 ":" 标示开始;    


####接口实现    

    @implementation Circle

    - (void) setFillColor:(ShapeColor)c {
        self->fillColor = c;
    }

    - (void) setBounds:(ShapeRect)b {
        self->bounds = b;
    }

    - (void) draw {
        NSLog(@"Draw Circle at %d %d,", 
                bounds.x, bounds.y);
    }

    + (void) staticDraw: (Circle *) circle {
        NSLog(@"This is method invoke type class");
    }

    @end    

Tips:   

* 一般情况下@implemenet写在*.m / *.mm 文件中

####如何使用    
   
    #import <Foundation/Foundation>

    //... ...
    int main(int argc, const char * arvs[]) {
        ShapeRect rect = {10, 20, 100, 200};
        id c = [Circle new];
        [c setFillColor:bBlueColor];
        [c setBounds:rect];
        [c draw];
    }   

__Important:__

* Objective-C中没有"."操作, 对对象方法的调用,称之为发消息
* [] , 用于发消息, 格式: [对象名称 方法:参数列表]


