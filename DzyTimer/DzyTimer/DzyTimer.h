//
//  DzyTimer.h
//  DzyTimer
//
//  Created by Dzy on 07/11/2017.
//  Copyright © 2017 Dzy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DzyTimerDelegate <NSObject>

- (void)startingCountDown;//协议方法

@end

@interface DzyTimer : NSObject
{
    dispatch_source_t _timer;
}
@property (nonatomic ) id<DzyTimerDelegate>delegate;
//@property (nonatomic ) dispatch_source_t timer;
/**
 开始计时
 */
- (void)startCountDown;
/**
 暂停计时
 */
- (void)pauseTimer;
/**
 恢复计时
 */
- (void)resumeTimer;
/**
 停止计时
 */
- (void)stopTimer;
/**
 重新计时
 */
- (void)restarTimer;

+ (DzyTimer *)sharedDzyTimer;

@end
