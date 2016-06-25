//
//  Feed+CoreDataProperties.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Feed.h"

NS_ASSUME_NONNULL_BEGIN

@interface Feed (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *rssURL;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSSet *feedItems;

@end

NS_ASSUME_NONNULL_END
