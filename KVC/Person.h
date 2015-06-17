//
//  Person.h
//  KVC
//
//  Created by 广东省陆丰市湖东镇薛国宾 on 15/6/11.
//  Copyright (c) 2015年 深圳法爱工程技术有限公司. All rights reserved.
//

// KVC二实例

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *age;

- (void)changeNamed;

@end
