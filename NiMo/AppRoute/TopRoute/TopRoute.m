//
//  TopRoute.m
//  PerhapysProductOne
//
//  Created by PerhapYs on 17/4/18.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "TopRoute.h"



@implementation TopRoute

+ (instancetype)shareRoute{
    static dispatch_once_t onceToken;
    static id shareId = nil;
    @synchronized(self) {
        dispatch_once(&onceToken, ^{
            shareId = [[[self class] alloc] init];
        });
        return shareId;
    }
}
- (void)setRooteViewControllerWithApplication:(UIApplication *)application Options:(NSDictionary *)launchOptions window:(UIWindow *)window{
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    
    CenterViewController *centerVC = [[CenterViewController alloc] init];
    
    RightViewController *rightVC = [[RightViewController alloc] init];

    MMDrawerController *mmVc = [[MMDrawerController alloc] initWithCenterViewController:centerVC leftDrawerViewController:leftVC rightDrawerViewController:rightVC];
    mmVc.maximumLeftDrawerWidth = 100;
    
    _MMDrawerC = mmVc;

    [window makeKeyAndVisible];
    
    window.rootViewController = mmVc;
}

@end
