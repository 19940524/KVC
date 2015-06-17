//
//  MyPerson.h
//  KVC
//
//  Created by 广东省陆丰市湖东镇薛国宾 on 15/6/11.
//  Copyright (c) 2015年 深圳法爱工程技术有限公司. All rights reserved.
//

// KVC三实例

#import <Foundation/Foundation.h>

@interface MyPerson : NSObject
{
    NSString *_name;
    int      _age;
    int      _height;
    int      _weight;
}

- (void)test;

@end
