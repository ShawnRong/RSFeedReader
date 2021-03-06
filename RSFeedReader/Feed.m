//
//  Feed.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "Feed.h"

@implementation Feed

// Insert code here to add functionality to your managed object subclass

- (NSArray *)sortedItem{
    NSArray *unsortedItem = [[self.feedItems allObjects] mutableCopy];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"publishDate" ascending:NO];
    NSArray *sortedArray = [unsortedItem sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return sortedArray;
}

- (NSArray *)unreadItem{
    NSArray *unsortedItem = [[self.feedItems allObjects] mutableCopy];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wasRead != %@",[NSNumber numberWithBool:YES]];
    unsortedItem = [unsortedItem filteredArrayUsingPredicate:predicate];
    
    return unsortedItem;
}

@end
