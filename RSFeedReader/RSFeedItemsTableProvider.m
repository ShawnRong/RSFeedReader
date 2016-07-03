//
//  RSFeedItemsTableProvider.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/7/3.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSFeedItemsTableProvider.h"
#import "RSFeedCell.h"
#import "FeedItem.h"


NSString * const kItemsCell = @"ItemsCell";

@implementation RSFeedItemsTableProvider

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSFeedCell *cell = (RSFeedCell *)[tableView dequeueReusableCellWithIdentifier:kItemsCell];
    
    if (cell == nil) {
        cell = [[RSFeedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kItemsCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    FeedItem *item = [[FeedItem alloc] init];
    
    if (self.dataSource.count > 0 && indexPath.row < self.dataSource.count) {
        item = (FeedItem *)self.dataSource[indexPath.row];
    }
    
    if (item != nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd-MM-yyyy hh:mm";
        
        NSString *dateString = [dateFormatter stringFromDate:item.publishDate];
        
        cell.wasReadCell = item.wasRead.boolValue;
        cell.titleText = item.title;
        cell.subTitleText = dateString;
    }

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return false;
}

@end
