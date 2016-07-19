//
//  RSFeedItemsViewController.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/7/3.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSFeedItemsViewController.h"
#import "RSFeedItemsTableProvider.h"
#import "RSFeedItemsView.h"
#import "Feed.h"
#import "RSBrain.h"
#import "RSBrowserViewController.h"

@interface RSFeedItemsViewController ()<RSTableProviderProtocol, RSFeedItemsViewProtocol>

@property (nonatomic, strong)RSFeedItemsView *feedItemsView;
@property (nonatomic, strong)RSFeedItemsTableProvider *provider;
@property (nonatomic, strong)NSMutableArray <FeedItem *>*allItems;

@end

@implementation RSFeedItemsViewController

#pragma mark -- Initializers

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _feedItemsView = [[RSFeedItemsView alloc] init];
        _provider = [[RSFeedItemsTableProvider alloc] init];
        _provider.delegate = self;
        
    }
    return self;
}

- (void)dealloc{
    _provider.delegate = nil;
    _feedItemsView.feedListDelegate = nil;
}


#pragma mark -- LifeCycle

- (void)loadView{
    [super loadView];
    
    RSFeedItemsView *aView = [[RSFeedItemsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.feedItemsView = aView;
    self.view = aView;
    
    self.feedItemsView.tableView.delegate = self.provider;
    self.feedItemsView.tableView.dataSource = self.provider;
    self.feedItemsView.feedListDelegate = self;
    
    _allItems = [[[self.feed feedItems] allObjects] mutableCopy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //populate table view
    if (self.feed != nil && self.allItems.count > 0) {
        NSArray *items = [self.feed sortedItem];
        
        self.provider.dataSource = [items mutableCopy];
        [self.feedItemsView.tableView reloadData];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.feedItemsView.tableView reloadData];
    
    self.title = self.feed.title;
    
}
#pragma mark -- RSTableProviderProtocol

- (void)cellDidPress:(NSIndexPath *)atIndexPath{
    FeedItem *item = [self.feed sortedItem][atIndexPath.row];
    
    if (item.link != nil) {
        item.wasRead = [NSNumber numberWithBool:YES];
        
        [[[RSBrain sharedBrain] coreData] saveContext];
        
        RSBrowserViewController *webVC = [[RSBrowserViewController alloc] initWithConfiguration:nil];
        [webVC loadURLString:item.link];
        
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        [self showAlertMessage:@"Web link is missing"];
    }
}

#pragma mark -- RSFeedItemsViewProtocol

- (void)didPullToRefresh:(UIRefreshControl *)sender{
    NSAssert(![sender isEqual:nil], @"Sender is nil");
    
    NSString *URL = self.feed.rssURL;
    [self startParsingURL:URL];
}

#pragma mark -- RSXMLParserProtocol

- (void)didEndParsingFeed:(Feed *)feed{
    if (![feed isEqual:nil] && self.feed != nil) {
        
        NSMutableArray *refreshDatesArr = [NSMutableArray array];
        
        for (FeedItem *refreshItem in self.allItems) {
            [refreshDatesArr addObject:refreshItem.publishDate];
        }
        
        //incoming feed
        Feed *incomingFeed = feed;
        NSMutableArray *incomingItems = [[incomingFeed.feedItems allObjects] mutableCopy];
        
        [[[RSBrain sharedBrain] coreData] deleteObject:feed];
        
        for (FeedItem *item in incomingItems) {
            if (![refreshDatesArr containsObject:[item publishDate]]) {
                item.feed = self.feed;
            }else{
                [[[RSBrain sharedBrain] coreData] deleteObject:item];
            }
        }
        
        [[[RSBrain sharedBrain] coreData] saveContext];
        
        [incomingItems removeAllObjects];
        [refreshDatesArr removeAllObjects];
        [self.feedItemsView.refreshControl endRefreshing];
    }
    
    self.provider.dataSource = [[self.feed sortedItem] mutableCopy];
    [self.feedItemsView.tableView reloadData];
}


@end
