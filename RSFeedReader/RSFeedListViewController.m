//
//  RSFeedListViewController.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSFeedListViewController.h"
#import "RSFeedListView.h"
#import "RSFeedListTableProvider.h"
#import "RSFeedListView.h"

@interface RSFeedListViewController()<RSTableProviderProtocol>

@property (nonatomic, strong) RSFeedListView *feedListView;
@property (nonatomic, strong) RSFeedListTableProvider *provider;

@end

@implementation RSFeedListViewController


#pragma mark -- Initializers


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    RSFeedListView *feedListView = [[RSFeedListView alloc] init];
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    RSFeedListTableProvider *provider = [[RSFeedListTableProvider alloc] init];
    provider.delegate = self;
    
    return self;
}


- (void)dealloc
{
    _provider.delegate = nil;
}

#pragma mark -- Life Cycle

- (void)loadView{
    RSFeedListView *aView = [[RSFeedListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.feedListView = aView;
    self.view = aView;
    
    self.feedListView.tableView.delegate = self.provider;
    self.feedListView.tableView.dataSource = self.provider;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed:)];
    
    [self.navigationItem setRightBarButtonItems:@[addItem] animated:YES];
}


#pragma mark -- Actions

- (void)addPressed:(UIButton *)sender{
    
}

- (void)trashPressed:(UIButton *)sender{
    
}


#pragma mark -- RSTableProviderProtocol

- (void)cellDidPress:(NSIndexPath *)atIndexPath{
    
}

- (void)cellNeedsDelete:(NSIndexPath *)atIndexPath{
    
}

@end
