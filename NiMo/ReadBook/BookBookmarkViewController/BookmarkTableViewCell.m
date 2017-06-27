//
//  BookmarkTableViewCell.m
//  NiMo
//
//  Created by PerhapYs on 17/6/27.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BookmarkTableViewCell.h"

@interface BookmarkTableViewCell ()

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *contentLabel;

@end

@implementation BookmarkTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self placeSubView];
    }
    return self;
}
-(void)placeSubView{
    
}
-(void)placeSubViewWithData:(NSDictionary *)data{
    
    
}
@end
