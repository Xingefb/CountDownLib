//
//  DzyTimer.m
//  DzyTimer
//
//  Created by Dzy on 07/11/2017.
//  Copyright © 2017 Dzy. All rights reserved.
//

#import "DzyTimer.h"

@implementation DzyTimer

+ (DzyTimer *)sharedDzyTimer {
    static dispatch_once_t predicate;
    static DzyTimer * sharedManager;
    dispatch_once(&predicate, ^{
        sharedManager =[[DzyTimer alloc] init];
    });
    return sharedManager;
}

- (void)startCountDown {

    NSTimeInterval period = 1.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    if (!_timer) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (_delegate && [_delegate respondsToSelector:@selector(startingCountDown)]) {
            [_delegate startingCountDown];
        }
    });
    if (_timer) {
        dispatch_resume(_timer);
    }
}

- (void)pauseTimer {
    if(_timer){
        dispatch_suspend(_timer);
    }
}

- (void)resumeTimer {
    if(_timer){
        dispatch_resume(_timer);
    }
}

- (void)stopTimer {
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
- (void)restarTimer {
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
        [self startCountDown];
    }else {
        [self startCountDown];
    }
}

@end
