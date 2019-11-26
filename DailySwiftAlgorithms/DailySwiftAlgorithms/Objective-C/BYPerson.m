//
//  BYPerson.m
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/11/20.
//  Copyright © 2019 Beryter. All rights reserved.
//

#import "BYPerson.h"

@implementation BYPerson

@end

@implementation BYStudent

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"[self class]=%@", [self class]);
        NSLog(@"[super class]=%@", [super class]);
        NSLog(@"[self superclass]=%@", [self superclass]);
        NSLog(@"[super class]=%@", [super superclass]);
    }
    return self;
}

+ (void)testIntrospectiveFunc {
    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]]; //YES
    BOOL res2 = [[NSObject class] isMemberOfClass:[NSObject class]]; //NO
    BOOL res3 = [[BYPerson class] isKindOfClass:[BYPerson class]]; //NO
    BOOL res4 = [[BYPerson class] isMemberOfClass:[BYPerson class]]; //NO
    BYPerson *per = [[BYPerson alloc] init];
    BOOL res5 = [per isKindOfClass:[NSObject class]]; //YES
    BOOL res6 = [per isKindOfClass:[BYPerson class]]; //YES
    BOOL res7 = [per isMemberOfClass:[NSObject class]]; //YES
    BOOL res8 = [per isMemberOfClass:[BYPerson class]]; //YES
    NSLog(@"res1 = %@,res2 = %@,res3 = %@,res4 = %@,res5 = %@,res6 = %@,res7 = %@,res8 = %@", @(res1), @(res2), @(res3), @(res4), @(res5), @(res6), @(res7), @(res8));
}

@end
