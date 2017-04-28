//
//  BookManager.m
//  NiMo
//
//  Created by PerhapYs on 17/4/26.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookManager.h"


@implementation BookManager
+ (instancetype)shareBook{
    static dispatch_once_t onceToken;
    static id shareId = nil;
    @synchronized(self) {
        dispatch_once(&onceToken, ^{
            shareId = [[[self class] alloc] init];
        });
        return shareId;
    }
}


+(NSInteger)BookTransitionStyle{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *bookStyel =  [userDefault objectForKey:@"bookTransitionStyle"];
    if (!bookStyel) {
        return 0;
    }
    return [bookStyel integerValue];
}




@end
