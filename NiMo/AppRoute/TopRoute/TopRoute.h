//
//  TopRoute.h
//  PerhapysProductOne
//
//  Created by PerhapYs on 17/4/18.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LeftViewController.h"

#import "CenterViewController.h"

#import "RightViewController.h"

#import <MMDrawerController.h>

@interface TopRoute : NSObject


@property (nonatomic , strong) TopViewController *TopRooteVC;


@property (nonatomic , strong) MMDrawerController *MMDrawerC;

// 获取 单列
+ (instancetype)shareRoute;

- (void)setRooteViewControllerWithApplication:(UIApplication *)application Options:(NSDictionary *)launchOptions window:(UIWindow *)window;

@end
