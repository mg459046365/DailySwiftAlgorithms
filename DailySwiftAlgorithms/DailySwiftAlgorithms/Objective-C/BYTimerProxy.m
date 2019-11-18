//
//  BYTimerProxy.m
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/11/18.
//  Copyright © 2019 Beryter. All rights reserved.
//

#import "BYTimerProxy.h"

@interface BYTimerProxy ()
@property (nonatomic, weak) id target;
@end

@implementation BYTimerProxy

+ (instancetype)proxyWithTarget: (id)target {
    BYTimerProxy *proxy = [self alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end

@interface BYTimerProxyTest: NSObject
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation BYTimerProxyTest

- (void)test {
    BYTimerProxy *proxy = [BYTimerProxy proxyWithTarget:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:proxy selector:@selector(timerFunc) userInfo:nil repeats:YES];
}

- (void)timerFunc {
    
}

- (void)createTimerWithGCD {
    int start = 10;
    int interval = 10;
    dispatch_queue_t queue = dispatch_queue_create("timer_queue", NULL);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置时间（start是几秒后开始执行，interval是时间间隔）
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start*NSEC_PER_SEC), interval*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        //回调
    });
    dispatch_resume(timer);
}

@end
