//
//  BookMuLuViewController.h
//  NiMo
//
//  Created by PerhapYs on 17/5/9.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "TopViewController.h"
#import "BookBasicViewController.h"
#import "BookBasicViewController.h"
#import "PerhapYsProtocol.h"

@interface BookMuLuViewController : TopViewController<CenterProtocol>

@property (nonatomic , assign) id<LeftProtocol> centerDelegate;


@end
