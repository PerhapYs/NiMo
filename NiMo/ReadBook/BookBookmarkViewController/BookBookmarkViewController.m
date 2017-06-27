//
//  BookBookmarkViewController.m
//  NiMo
//
//  Created by PerhapYs on 17/6/26.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookBookmarkViewController.h"

@interface BookBookmarkViewController ()

@end

@implementation BookBookmarkViewController

+ (instancetype)shareBookmark{
    static dispatch_once_t onceToken;
    static id shareId = nil;
    @synchronized(self) {
        dispatch_once(&onceToken, ^{
            shareId = [[[self class] alloc] init];
        });
        return shareId;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"书签";
}


@end
