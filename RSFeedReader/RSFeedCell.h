//
//  RSFeedCell.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSFeedCell : UITableViewCell

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *subTitleText;
@property (nonatomic, strong) NSString *itemCountText;
@property (nonatomic, assign) BOOL wasReadCell;

@end
