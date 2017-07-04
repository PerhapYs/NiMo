//
//  CurrentBook.m
//  NiMo
//
//  Created by PerhapYs on 17/7/4.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "CurrentBook.h"

@implementation CurrentBook

+ (instancetype)shareCurrentBook{
    static dispatch_once_t onceToken;
    static id shareId = nil;
    @synchronized(self) {
        dispatch_once(&onceToken, ^{
            shareId = [[[self class] alloc] init];
        });
        return shareId;
    }
}
@end
