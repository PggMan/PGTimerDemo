# Cocoapods

```objc
$ pod search PGTimer
```


# PGTimerDemo
一个适用于多线程的GCD定时器

```objc

#import "ViewController.h"
#import "PGTimer.h"
@interface ViewController ()
@property (nonatomic ,copy) NSString *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // run timer
    self.task = [PGTimer execTask:self selector:@selector(linkTest) start:2.0 interval:1.0 repeate:YES async:YES];
}

- (void)linkTest{
    // working
    NSLog(@"%s - %@",__func__, [NSThread currentThread]);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // cancel
    [PGTimer cancelTask:self.task];
}
@end
```
