//
//  Feed+CoreDataProperties.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/7/10.
//  Copyright © 2016年 Shawn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Feed.h"
#import "FeedItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface Feed (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *rssURL;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSSet<FeedItem *> *feedItems;

@end

@interface Feed (CoreDataGeneratedAccessors)

- (void)addFeedItemsObject:(FeedItem *)value;
- (void)removeFeedItemsObject:(FeedItem *)value;
- (void)addFeedItems:(NSSet<FeedItem *> *)values;
- (void)removeFeedItems:(NSSet<FeedItem *> *)values;

@end

NS_ASSUME_NONNULL_END
