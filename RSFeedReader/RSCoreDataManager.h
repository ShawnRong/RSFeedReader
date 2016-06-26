//
//  RSCoreDataManager.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Feed.h"

static NSString *const kFeed =@"Feed";
static NSString *const kFeedItem = @"FeedItem";

@interface RSCoreDataManager : NSObject

- (NSManagedObject *)createEntityWithName:(NSString *)name;
- (NSArray *)allFeeds;
- (void)deleteObject:(NSManagedObject *)entityObject;
- (void)saveContext;

@end
