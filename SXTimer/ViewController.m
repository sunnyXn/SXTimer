//
//  ViewController.m
//  SXTimer
//
//  Created by Sunny on 2020/11/18.
//

#import "ViewController.h"
#import "NSObject+GCDTimer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    static NSInteger interval = 0;
    
    __weak typeof(self) weakSelf = self;
    NSLog(@"startTime1:%@。",[NSDate date]);
    [self scheduledTimerWithTimeInterval:2 fireDate:[NSDate dateWithTimeIntervalSinceNow:3] block:^(dispatch_source_t timer) {

        if (interval >= 10) {
            [weakSelf stopTimer:timer];
        }
        
        NSLog(@"currentInterval:%ld, currentDate:%@。",(long)interval, [NSDate date]);
        interval++;
        
    }];
    NSLog(@"startTime2:%@。",[NSDate date]);
}


@end
