//
//  BookBasicViewController.h
//  NiMo
//
//  Created by PerhapYs on 17/4/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "TopViewController.h"
#import "BookModel.h"
#import "BookDefault.h"
#import "BookChapter.h"
@protocol CenterDelegate

-(void)updateLeftViewControllerTableViewWithChapter:(BookChapter *)chapter;

@end

@interface BookBasicViewController : TopViewController

@property (nonatomic , assign) id<CenterDelegate> leftDelegate;

@property (nonatomic , strong) BookModel *readBook;

@end
