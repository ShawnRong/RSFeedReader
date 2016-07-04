//
//  Feed.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Feed : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (NSArray *)sortedItem;
- (NSArray *)unreadItem;
@end

NS_ASSUME_NONNULL_END

#import "Feed+CoreDataProperties.h"
