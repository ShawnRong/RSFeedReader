//
//  RSFeedItemsView.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/7/3.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSBaseView.h"

@protocol RSFeedItemsViewProtocol <NSObject>

- (void)didPullToRefresh:(UIRefreshControl *)sender;

@end

@interface RSFeedItemsView : RSBaseView

@property (nonatomic,weak) id<RSFeedItemsViewProtocol> feedListDelegate;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
