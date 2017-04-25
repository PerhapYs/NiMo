//
//  NSArray+PerhapYs.m
//  NiMo
//
//  Created by PerhapYs on 17/4/25.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "NSArray+PerhapYs.h"
#define CUT_LENTCH 1000
@implementation NSArray (PerhapYs)

+(NSArray *)paragraphWithNovel:(NSString *)novel{

    NSMutableArray *novelArr = [[NSMutableArray alloc] init];
    
    if (novel.length > CUT_LENTCH) {
        
        NSString *restStr = novel;
        
        while (restStr.length > 0) {
            
            restStr = [restStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            if (restStr.length <= CUT_LENTCH) {
                
                [novelArr addObject:restStr];
                
                break;
            }
            NSString *str = [restStr substringWithRange:NSMakeRange(0, CUT_LENTCH)];
            
            restStr = [restStr substringFromIndex:CUT_LENTCH];
        
            [novelArr addObject:str];
        }
    }
    else{
        
        [novelArr addObject:novel];
    }
    
    return novelArr;
}

@end
