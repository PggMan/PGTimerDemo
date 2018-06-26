//
//  PGTimer.h
//  Autopool
//
//  Created by 印度阿三 on 2017/6/25.
//  Copyright © 2017年 印度阿三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGTimer : NSObject
+ (NSString *) execTask:(void(^)(void))task
                    start:(NSTimeInterval) start
                 interval:(NSTimeInterval)interval
                  repeate:(BOOL)repeate
                    async:(BOOL) async;

+ (NSString *) execTask:(id)target
               selector:(SEL)selector
                  start:(NSTimeInterval) start
               interval:(NSTimeInterval)interval
                repeate:(BOOL)repeate
                  async:(BOOL) async;


+ (void)cancelTask:(NSString *)name;

@end
