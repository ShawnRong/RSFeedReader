//
//  RSFeedListTableProvider.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSFeedListTableProvider.h"
#import "RSFeedCell.h"
#import "Feed.h"

NSString * const kFeedCell = @"FeedCell";

@implementation RSFeedListTableProvider


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSFeedCell *cell = (RSFeedCell *)[tableView dequeueReusableCellWithIdentifier:kFeedCell];
    
    if(cell == nil){
        cell = [[RSFeedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kFeedCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Feed *feed = (Feed *)self.dataSource[indexPath.row];
    
    if (feed != nil) {
        cell.titleText = feed.title;
        cell.subTitleText = feed.summary;
        NSInteger unreadCount = [feed unreadItem].count;
        cell.itemCountText = [NSString stringWithFormat:@"%ld",(long)unreadCount];
    }
    
    
    return cell;
}

@end
