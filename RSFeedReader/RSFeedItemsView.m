//
//  RSFeedItemsView.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/7/3.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSFeedItemsView.h"

@interface RSFeedItemsView()


@end

@implementation RSFeedItemsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.tintColor = [UIColor colorWithRed:0.99 green:0.7 blue:0.23 alpha:1];
        [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:_refreshControl];
    }
    return self;
}

- (void) refresh:(UIRefreshControl *)sender{
    [self.feedListDelegate didPullToRefresh:sender];
}

@end
