
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
        
        [self placeSubView];
    }
    return self;
}
-(void)placeSubView{
    
    _chapterTitleLabel = [UILabel new];
    _chapterTitleLabel.textColor = [UIColor blackColor];
    _chapterTitleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_chapterTitleLabel];
    [_chapterTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)placeSuviewWithDataSource:(BookChapter *)chapter{
    
        _chapterTitleLabel.text = chapter.chapterTitle;
}

@end
