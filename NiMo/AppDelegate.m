//
//  AppDelegate.m
//  NiMo
//
//  Created by PerhapYs on 17/4/21.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_BOUNDS];
    
    [[TopRoute shareRoute] setRooteViewControllerWithApplication:application Options:launchOptions window:self.window];
    
    return YES;
}


@end
