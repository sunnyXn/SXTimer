//
//  NSObject+GCDTimer.m
//  SXTimer
//
//  Created by Sunny on 2020/11/18.
//

#import "NSObject+GCDTimer.h"

@implementation NSObject (GCDTimer)


- (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval fireDate:(NSDate *)date block:(void (^)(dispatch_source_t timer))block {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_queue_create("com.dispatchqueue.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(queue, dispatch_get_main_queue());
    dispatch_source_t sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(sourceTimer, [self.class wallTimeWithDate:date], interval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(sourceTimer, ^{
        @synchronized (self) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block(sourceTimer);
                }
            });
        }
    });
    
    dispatch_resume(sourceTimer);
}

- (void)stopTimer:(dispatch_source_t)timer {
    if (timer) {
        dispatch_source_cancel(timer);
        timer = NULL;
    }
}

#pragma mark Date Conversions

+ (dispatch_time_t)wallTimeWithDate:(NSDate *)date {
    NSCParameterAssert(date != nil);

    double seconds = 0;
    double frac = modf(date.timeIntervalSince1970, &seconds);

    struct timespec walltime = {
        .tv_sec = (time_t)fmin(fmax(seconds, LONG_MIN), LONG_MAX),
        .tv_nsec = (long)fmin(fmax(frac * NSEC_PER_SEC, LONG_MIN), LONG_MAX)
    };

    return dispatch_walltime(&walltime, 0);
}


@end
