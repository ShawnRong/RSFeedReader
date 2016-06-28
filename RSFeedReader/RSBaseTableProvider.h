//
//  RSBaseTableProvider.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RSTableProviderProtocol <NSObject>

- (void)cellDidPress:(NSIndexPath *) atIndexPath;

@optional
- (void)cellNeedsDelete:(NSIndexPath *) atIndexPath;

@end

@interface RSBaseTableProvider : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) id<RSTableProviderProtocol> delegate;

@end
