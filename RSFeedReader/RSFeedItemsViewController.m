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
@property (nonatomic, strong)Feed *feed;

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
    
    //populate table view
    if (self.feed != nil && [self.feed.feedItems allObjects].count > 0) {
        NSArray *items = [self.feed sortedItem];
        
        self.provider.dataSource = [items mutableCopy];
        [self.feedItemsView.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
//        NSArray *existFeedItems = [self.feed.feedItems allObjects];
        
        //array from of all feed items 'publish date'

        //incoming feed
        Feed *incomingFeed = [[Feed alloc] init];
        NSMutableArray *incomingItems = [[incomingFeed.feedItems allObjects] mutableCopy];
        
        [[[RSBrain sharedBrain] coreData] deleteObject:feed];
        
//        for (FeedItem *item in incomingItems) {
//
//        }
        
        [[[RSBrain sharedBrain] coreData] saveContext];
        
        [incomingItems removeAllObjects];
        [self.feedItemsView.refreshControl endRefreshing];
    }
    
    self.provider.dataSource = [[self.feed sortedItem] mutableCopy];
    [self.feedItemsView.tableView reloadData];
}
@end
