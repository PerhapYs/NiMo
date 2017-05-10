//
//  MuluTableViewCell.h
//  NiMo
//
//  Created by PerhapYs on 17/5/10.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookChapter.h"
@interface MuluTableViewCell : UITableViewCell

@property (nonatomic , strong) UILabel *chapterTitleLabel;

-(void)placeSuviewWithDataSource:(BookChapter *)chapter;

@end
