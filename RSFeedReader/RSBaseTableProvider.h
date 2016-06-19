//
//  RSBaseTableProvider.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RSBaseTableProviderProtocol <NSObject>

- (void)cellDidPress:(NSIndexPath *) atIndexPath;

@optional
- (void)cellNeedsDelete:(NSIndexPath *) atIndexPath;

@end

@interface RSBaseTableProvider : NSObject

@property (nonatomic, strong) id dataSource;
@property (nonatomic, weak) id<RSBaseTableProviderProtocol> delegate;

@end
