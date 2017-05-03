//
//  NSArray+PerhapYs.m
//  NiMo
//
//  Created by PerhapYs on 17/4/25.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "NSArray+PerhapYs.h"


@implementation NSArray (PerhapYs)

+(NSArray *)SearchLocalNovalPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSArray *arr = [NSBundle pathsForResourcesOfType:@"txt" inDirectory:documentsPath];

    return arr;
}

+(NSArray *)getLocalTextTitle{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *arr1 =  [fileManager contentsOfDirectoryAtPath:documentsPath error:&error];
    if (!error) {
        return arr1;
    }
    return arr1;
}

+(NSArray *)getNovalInformation{
    NSMutableArray *novalData = [[NSMutableArray alloc] init];
    NSArray *pathArr = [NSArray SearchLocalNovalPath];
    NSArray *titleArr = [NSArray getLocalTextTitle];
    
    for (int i = 0; i < titleArr.count; i ++) {
        if (i >= pathArr.count) {
            break;
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:titleArr[i] forKey:@"novalTile"];
        [dic setObject:pathArr[i] forKey:@"novalPath"];
        
        [novalData addObject:dic];
    }
    
    return novalData;
}
@end
