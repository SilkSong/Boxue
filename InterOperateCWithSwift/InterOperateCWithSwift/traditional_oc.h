//
//  traditional_oc.h
//  InterOperateCWithSwift
//
//  Created by Song Zixin on 2019/5/10.
//  Copyright © 2019 SilkSong. All rights reserved.
//

#ifndef traditional_oc_h
#define traditional_oc_h
#import <Foundation/Foundation.h>
//简单变量
const int global_ten;

//自定义 Enum
typedef NSString * TrafficLightColor NS_STRING_ENUM;

TrafficLightColor const TrafficLightColorRed;
TrafficLightColor const TrafficLightColorYellow;
TrafficLightColor const TrafficLightColorGreen;

//可拓展 Enum
typedef int Shape NS_EXTENSIBLE_STRING_ENUM;

Shape const ShapeCircle;
Shape const ShapeTriangle;
Shape const ShapeSquare;

//固定参数个数的函数
int add(int m, int n);

//不固定参数个数的函数
//int sum(int count, ...);
//int vsum(int count, va_list numbers);

//Struct
struct Location {
    double x;
    double y;
};

typedef struct Location Location;


#endif /* traditional_oc_h */
