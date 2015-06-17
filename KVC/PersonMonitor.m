//
//  PersonMonitor.m
//  KVC
//
//  Created by 广东省陆丰市湖东镇薛国宾 on 15/6/11.
//  Copyright (c) 2015年 深圳法爱工程技术有限公司. All rights reserved.
//

// KVC二实例

#import "PersonMonitor.h"

@implementation PersonMonitor

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
 {
     if ([keyPath isEqual:@"name"]) {
         NSLog(@"change happen, old:%@   new:%@",[change objectForKey:NSKeyValueChangeOldKey],[change objectForKey:NSKeyValueChangeNewKey]);
     }
}

@end
