//
//  BookMuLuViewController.h
//  NiMo
//
//  Created by PerhapYs on 17/5/9.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "TopViewController.h"
#import "BookBasicViewController.h"

@protocol LeftDelegate

-(void)updateBookChapterWithChapterIndex:(NSInteger)chapterIndex;

@end
@interface BookMuLuViewController : TopViewController<CenterDelegate>

@property (nonatomic , strong) NSArray *DataSource;

@property (nonatomic , assign) id<LeftDelegate> centerDelegate;


@end
