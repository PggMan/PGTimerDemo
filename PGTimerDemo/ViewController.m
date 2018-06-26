//
//  ViewController.m
//  PGTimerDemo
//
//  Created by 印度阿三 on 2018/6/26.
//  Copyright © 2018年 印度阿三. All rights reserved.
//

#import "ViewController.h"
#import "PGTimer.h"
@interface ViewController ()
@property (nonatomic ,copy) NSString *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.task = [PGTimer execTask:self selector:@selector(linkTest) start:2.0 interval:1.0 repeate:YES async:YES];
}

- (void)linkTest{
    
    NSLog(@"%s - %@",__func__, [NSThread currentThread]);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [PGTimer cancelTask:self.task];
}
@end
