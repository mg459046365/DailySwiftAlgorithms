//
//  BYTimerProxy.h
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/11/18.
//  Copyright © 2019 Beryter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// NSProxy虚基类，主要用于消息转发，可以用来解决循环引用，
@interface BYTimerProxy : NSProxy

@end

NS_ASSUME_NONNULL_END
