//
//  BookmarkTableViewCell.h
//  NiMo
//
//  Created by PerhapYs on 17/6/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookMark.h"
@interface BookmarkTableViewCell : UITableViewCell

-(void)placeSubViewWithData:(BookMark *)data;

@end
