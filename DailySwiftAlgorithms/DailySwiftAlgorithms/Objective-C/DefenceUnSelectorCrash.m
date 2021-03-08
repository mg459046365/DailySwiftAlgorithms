//
//  DefenceUnSelectorCrash.m
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/1.
//  Copyright © 2021 Beryter. All rights reserved.
//

#import "DefenceUnSelectorCrash.h"

/// unrecognized selector crash 防护方案
//1. resolveInstanceMethod
// 需要在类的本身上动态添加它本身不存在的方法，这些方法对于该类本身来说冗余的
//2.forwardInvocation 可以通过NSInvocation的形式将消息转发给多个对象，但是其开销较大，需要创建新的NSInvocation对象，并且forwardInvocation的函数经常被使用者调用，来做多层消息转发选择机制，不适合多次重写
// 3.forwardingTargetForSelector   可以将消息转发给一个对象，开销较小，并且被重写的概率较低，适合重写

//解决方法：
//第一步：创建消息接受类，处理消息。
//第二步：为NSObject添加分类，拦截NSObject的forwardingTargetForSelector:方法。并在分类中的自定义xz_forwardingTargetForSelector:方法中，将消息转发给该消息接受类。

#import <objc/runtime.h>
@interface DefenceUnSelectorCrash ()

@end

@implementation DefenceUnSelectorCrash

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    // 如果没有动态添加方法的话，还会调用forwardingTargetForSelector:方法，从而造成死循环
    class_addMethod([self class], sel, (IMP)addMethod, "v@:@");
    return YES;
}

id addMethod(id self, SEL _cmd)
{
    NSLog(@"unrecorgnized sellecor: %@", NSStringFromSelector(_cmd));
    return 0;
}

@end

/// 为NSObject添加分类，拦截NSObject的forwardingTargetForSelector:方法。

@interface NSObject (SelectorCarsh)
//+ (void)by_enableSelectorProtector;
@end

@implementation NSObject (SelectorCarsh)

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [[DefenceUnSelectorCrash alloc] init];
}

@end
