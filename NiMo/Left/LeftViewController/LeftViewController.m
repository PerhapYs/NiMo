//
//  LeftViewController.m
//  PerhapysProductOne
//
//  Created by PerhapYs on 17/4/21.
//  Copyright © 2017年 PerhapYs. All rights reserved.
//

#import "LeftViewController.h"
#import "NSArray+PerhapYs.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor greenColor];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//    
//    NSLog(@"🌹 %@",documentsPath);
//    
//     NSString *filePath = [documentsPath stringByAppendingPathComponent:@"componentState.txt"];
//    
//    NSString *str = @"fdsfdsfds";
//    NSError *error = nil;
//    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    
////    [dic writeToFile:filePath atomically:YES];
    
}

@end
