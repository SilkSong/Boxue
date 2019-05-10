//
//  traditional_oc.m
//  InterOperateCWithSwift
//
//  Created by Song Zixin on 2019/5/10.
//  Copyright © 2019 SilkSong. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "traditional_oc.h"

//简单变量
const int global_ten = 10;

//自定义 Enum
TrafficLightColor const TrafficLightColorRed = @"Red";
TrafficLightColor const TrafficLightColorYellow = @"Yellow";
TrafficLightColor const TrafficLightColorGreen = @"Green";

//可拓展 Enum
Shape const ShapeCircle = 1;
Shape const ShapeTriangle = 2;
Shape const ShapeSquare = 3;

//固定参数个数的函数
int add(int m, int n) {
    return m + n;
}

//不固定参数个数的函数
//int sum(int count, ...) {
//    va_list ap;
//    int s = 0;
//
//    va_list(ap, count);
//    vsum(count, ap);
//    va_end(ap);
//
//    return s;
//}
//
//int vsum(int count, va_list numbers) {
//    int s = 0;
//    int i = 0;
//
//    for(; i < count, ++i) {
//        s += va_arg(numbers, int);
//    }
//
//    return s;
//}
