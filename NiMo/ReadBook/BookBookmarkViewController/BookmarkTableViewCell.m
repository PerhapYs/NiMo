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
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}
-(void)placeSubViewWithData:(BookMark *)data{
    
    _titleLabel.text = data.content;
}
@end
