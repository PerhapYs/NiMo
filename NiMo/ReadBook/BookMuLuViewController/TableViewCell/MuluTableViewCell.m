
//
//  MuluTableViewCell.m
//  NiMo
//
//  Created by PerhapYs on 17/5/10.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "MuluTableViewCell.h"

@implementation MuluTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self placeSubView];
    }
    return self;
}
-(void)placeSubView{
    
    _chapterTitleLabel = [UILabel new];
    _chapterTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    _chapterTitleLabel.textColor = [UIColor blackColor];
    _chapterTitleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_chapterTitleLabel];
    [_chapterTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.and.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-SET_WIDTH_(20));
    }];
    
    UIView *seprateLine = [UIView new];
    seprateLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:seprateLine];
    [seprateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SET_WIDTH_(20));
        make.right.equalTo(self.contentView.mas_right).offset(-SET_WIDTH_(20));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(SET_HEIGHT_(1));
    }];
}


-(void)placeSuviewWithDataSource:(BookChapter *)chapter{
    
        _chapterTitleLabel.text = chapter.chapterTitle;
}

-(void)prepareForReuse{
    
    [super prepareForReuse];
    
    _chapterTitleLabel.textColor = [UIColor blackColor];
}
@end
