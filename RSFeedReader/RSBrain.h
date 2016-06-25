//
//  RSBrain.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "Feed.h"

@interface RSBrain : NSObject

- (NSManagedObject *)createEntity:(NSString *)name;
- (Feed *)feedForIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isDuplicateURL:(NSString *)rssURL;

+ (id)sharedBrain;

@end
