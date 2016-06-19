//
//  RSFeedListViewController.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSFeedListViewController.h"
#import "RSFeedListView.h"

@interface RSFeedListViewController ()

@property (nonatomic, strong) RSFeedListView *feedListView;

@end

@implementation RSFeedListViewController


#pragma mark -- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed:)];
    
    [self.navigationItem setRightBarButtonItems:@[addItem] animated:YES];
}


#pragma mark -- Actions

- (void)addPressed:(UIButton *)sender{
    
}

@end
