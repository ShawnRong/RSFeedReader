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
#import "RSBrain.h"
#import "RSFeedItemsViewController.h"

@interface RSFeedListViewController()<RSTableProviderProtocol>

@property (nonatomic, strong) RSFeedListView *feedListView;
@property (nonatomic, strong) RSFeedListTableProvider *provider;
@property (nonatomic, strong) NSArray *allFeeds;

@end

@implementation RSFeedListViewController


#pragma mark -- Initializers


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    _feedListView = [[RSFeedListView alloc] init];
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    _provider = [[RSFeedListTableProvider alloc] init];
    _provider.delegate = self;

    _allFeeds = [[RSBrain sharedBrain] coreData].allFeeds;
    
    return self;
}


//- (void)dealloc
//{
//    _provider.delegate = nil;
//}

#pragma mark -- Life Cycle

- (void)loadView{
    RSFeedListView *aView = [[RSFeedListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.feedListView = aView;
    self.view = aView;
    
    self.feedListView.tableView.delegate = _provider;
    self.feedListView.tableView.dataSource = _provider;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed:)];
    
    [self.navigationItem setRightBarButtonItems:@[addItem] animated:YES];
    
    
    if (self.allFeeds.count > 0) {
        [self addTrashBUtton:YES];
    }else{
        self.feedListView.tableView.alpha = 0.0;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //Convert NSArray to NSmutableArray
    self.provider.dataSource = [NSMutableArray arrayWithArray:self.allFeeds];
    [self.feedListView.tableView reloadData];
}


#pragma mark -- Actions

- (void)addPressed:(UIButton *)sender{
    [self showEnterFeedAlertView:@""];
}

- (void)trashPressed:(UIButton *)sender{
    BOOL needsEdit = !self.feedListView.tableView.editing;
    
    [self.feedListView.tableView setEditing:needsEdit animated:YES];
}

#pragma mark -- Inherited From Base
- (void)addFeedPressed:(NSString *)URL{
    if ([[RSBrain sharedBrain] isDuplicateURL:URL]) {
        [self showDuplicateRSSAlert];
    }else{
        [self startParsingURL:URL];
    }
}

#pragma mark -- RSXMLParserProtocol Method

- (void)didEndParsingFeed:(Feed *)feed{
    if (feed) {
        [self.provider.dataSource addObject:feed];
        [[[RSBrain sharedBrain] coreData] saveContext];
        
        NSMutableArray *array = [self.allFeeds mutableCopy];
        [array addObject:feed];
        self.allFeeds = array;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.allFeeds indexOfObject:feed] inSection:0];
        [self.feedListView.tableView beginUpdates];
        [self.feedListView.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.feedListView.tableView endUpdates];
        
        if (self.navigationItem.leftBarButtonItem == nil) {
            [self addTrashBUtton:YES];
            self.feedListView.tableView.alpha = 1.0;
        }
    }
}


#pragma mark -- RSTableProviderProtocol

- (void)cellDidPress:(NSIndexPath *)atIndexPath{
    if (atIndexPath.row < self.allFeeds.count) {
        RSFeedItemsViewController *itemsVC = [[RSFeedItemsViewController alloc] init];

        itemsVC.feed = self.allFeeds[atIndexPath.row];
        
       
        [self.navigationController pushViewController:itemsVC animated:YES];
        
    }
}

- (void)cellNeedsDelete:(NSIndexPath *)atIndexPath{
    if (atIndexPath.row < [[RSBrain sharedBrain] coreData].allFeeds.count) {
//        Feed *feedToDelete = [[RSBrain sharedBrain] feedForIndexPath:atIndexPath];
        Feed *feedToDelete = [self.allFeeds objectAtIndex:atIndexPath.row];
        
        
        [[[RSBrain sharedBrain] coreData] deleteObject:feedToDelete];
        [[[RSBrain sharedBrain] coreData] saveContext];
        
        NSMutableArray *array = [self.allFeeds mutableCopy];
        [array removeObject:feedToDelete];
        self.allFeeds = array;
        //Convert NSArray to NSmutableArray
        self.provider.dataSource = [NSMutableArray arrayWithArray:self.allFeeds];

        [self.feedListView.tableView beginUpdates];
        [self.feedListView.tableView deleteRowsAtIndexPaths:@[ atIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.feedListView.tableView endUpdates];
        
        //hide trash button if there is no item
        if(self.provider.dataSource.count == 0){
            [self addTrashBUtton:NO];
            
            [self.feedListView.tableView setEditing:false animated:false];
            self.feedListView.tableView.alpha = 0.0;
        }
    }
}

#pragma mark -- Helpers Method

- (void)addTrashBUtton:(BOOL)add{
    if (add) {
        UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashPressed:)];
        
        [self.navigationItem setLeftBarButtonItems:@[trashButton] animated:YES];
    }else{
        [self.navigationItem setLeftBarButtonItems:nil animated:YES];
    }
}

@end
