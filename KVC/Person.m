//
//  Person.m
//  KVC
//
//  Created by 广东省陆丰市湖东镇薛国宾 on 15/6/11.
//  Copyright (c) 2015年 深圳法爱工程技术有限公司. All rights reserved.
//

// KVC二实例

#import "Person.h"

@implementation Person
@synthesize name,age;

- (id)init {
    self = [super init];
    if (self) {
        name = @"初始化";
    }
    return self;
}

- (void)changeNamed {
    name = @"通过person自己的函数来更改name";
}
@end
