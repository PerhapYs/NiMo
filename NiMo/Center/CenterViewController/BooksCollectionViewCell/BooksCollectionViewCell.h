//
//  BooksCollectionViewCell.h
//  NiMo
//
//  Created by PerhapYs on 17/4/24.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *bookImageView;

@property (nonatomic , strong) UILabel *bookNameLabel;

-(void)placeCellDataWithDic:(NSDictionary *)dic;

@end
