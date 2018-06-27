//
//  PGTimer.m
//  Autopool
//
//  Created by 印度阿三 on 2017/6/25.
//  Copyright © 2017年 印度阿三. All rights reserved.
//

#import "PGTimer.h"
@interface PGTimer ()

@end

@implementation PGTimer

static NSMutableDictionary *timers_;
static dispatch_semaphore_t semaphore_;
+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionaryWithCapacity:0];
        semaphore_ = dispatch_semaphore_create(1);
    });
    
    
}

+ (NSString *) execTask:(void(^)(void))task
                    start:(NSTimeInterval) start
                 interval:(NSTimeInterval)interval
                  repeate:(BOOL)repeate
                    async:(BOOL) async{
    
  
    
    if (!task || start <0 || (interval <= 0 && repeate == YES) || (interval < 0 && repeate == NO) ) return nil;

    dispatch_queue_t queue = async? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();

    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start  * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC,
                              0.0 * NSEC_PER_SEC);
    
     dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
     NSString *name = [NSString stringWithFormat:@"%zd",(unsigned long)timers_.count];
     timers_[name] = timer;
    
     dispatch_semaphore_signal(semaphore_);

     dispatch_source_set_event_handler(timer, ^{
        
        task();

        if (!repeate) {
            [self cancelTask:name];
        }
        
        
     });

     dispatch_resume(timer);
   
    
     return name;
}

+ (NSString *) execTask:(id)target
               selector:(SEL)selector
                  start:(NSTimeInterval) start
               interval:(NSTimeInterval)interval
                repeate:(BOOL)repeate
                  async:(BOOL) async{
    
    
    if (!target ||!selector || start <0 || (interval <= 0 && repeate == YES) || (interval < 0 && repeate == NO) ) return nil;
    
    dispatch_queue_t queue = async? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start  * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC,
                              0.0 * NSEC_PER_SEC);
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *name = [NSString stringWithFormat:@"%zd",(unsigned long)timers_.count];
    timers_[name] = timer;
    dispatch_semaphore_signal(semaphore_);
    

    dispatch_source_set_event_handler(timer, ^{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        [target performSelector:selector];
        
#pragma clang diagnostic pop
        

        if (!repeate) {
            [self cancelTask:name];
        }
        
        
    });
    
    dispatch_resume(timer);
    
    
    return name;
}



+ (void)cancelTask:(NSString *)name{
    if (name.length<= 0) return;
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = timers_[name];
    if (!timer) return;
    dispatch_source_cancel(timers_[name]);
    [timers_ removeObjectForKey:name];

    dispatch_semaphore_signal(semaphore_);
}
@end
