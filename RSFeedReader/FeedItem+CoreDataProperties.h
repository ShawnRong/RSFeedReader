//
//  FeedItem+CoreDataProperties.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/7/10.
//  Copyright © 2016年 Shawn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FeedItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSDate *publishDate;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *wasRead;
@property (nullable, nonatomic, retain) Feed *feed;

@end

NS_ASSUME_NONNULL_END
