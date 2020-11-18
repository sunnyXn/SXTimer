//
//  NSObject+GCDTimer.h
//  SXTimer
//
//  Created by Sunny on 2020/11/18.
//

#import <Foundation/Foundation.h>



@interface NSObject (GCDTimer)

///  GCD计时器
/// @param interval 间隔
/// @param date 起始时间
/// @param block 每个间隔的回调
- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval fireDate:(NSDate *)date block:(void (^)(dispatch_source_t timer))block;


/// 销毁计时器
/// @param timer 传入的timer
- (void)stopTimer:(dispatch_source_t)timer;



@end


