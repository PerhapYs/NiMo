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
#import "BookMuLuViewController.h"
#import "PerhapYsProtocol.h"
//@protocol CenterDelegate
//
//-(void)updateLeftViewControllerTableViewWithChapter:(BookChapter *)chapter;
//
//@end

@interface BookBasicViewController : TopViewController<LeftProtocol>

@property (nonatomic , assign) id<CenterProtocol> leftDelegate;

@property (nonatomic , strong) BookModel *readBook;

@end
