//
//  BooksCollectionViewCell.m
//  NiMo
//
//  Created by PerhapYs on 17/4/24.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "BooksCollectionViewCell.h"

@implementation BooksCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self intializeCell];
    }
    return self;
}

-(void)intializeCell{
    
    _bookImageView = [UIImageView new];
    [self.contentView addSubview:_bookImageView];
    [_bookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.left.equalTo(self.contentView);
        make.height.mas_equalTo(SET_HEIGHT_(120));
    }];
    
    _bookNameLabel = [UILabel new];
    _bookNameLabel.textColor = [UIColor blackColor];
    _bookNameLabel.font = [UIFont systemFontOfSize:14];
    _bookNameLabel.textAlignment = 1;
    [self.contentView addSubview:_bookNameLabel];
    [_bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bookImageView.mas_bottom).offset(SET_HEIGHT_(10));
        make.left.and.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

-(void)placeCellDataWithDic:(NSDictionary *)dic{
    
    [_bookImageView setImage:[UIImage imageNamed:@"bookImage.jpeg"]];
    _bookNameLabel.text = dic[@"novalTile"];
}
@end
