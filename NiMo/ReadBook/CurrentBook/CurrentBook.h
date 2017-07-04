//
//  CurrentBook.h
//  NiMo
//
//  Created by PerhapYs on 17/7/4.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentBook : NSObject

@property (nonatomic , assign) NSInteger bookId;

@property (nonatomic , copy) NSString *bookPath;

+ (instancetype)shareCurrentBook;

@end
