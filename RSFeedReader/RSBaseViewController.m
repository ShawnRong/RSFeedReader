//
//  RSBaseViewController.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSBaseViewController.h"

@interface RSBaseViewController ()

@end

@implementation RSBaseViewController

#pragma mark -- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RSSFeedsReader";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark -- Alert




@end
