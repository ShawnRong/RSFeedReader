//
//  RSFeedCell.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSFeedCell.h"

@interface RSFeedCell ()

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UILabel *itemsCountLabel;
@property (nonatomic, strong) UIView *dot;

@end

@implementation RSFeedCell


-(void)setTitleText:(NSString *)titleText{
    self.topLabel.text = titleText;
    [self setNeedsLayout];
}

- (void)setSubTitleText:(NSString *)subTitleText{
    self.bottomLabel.text = subTitleText;
    [self setNeedsLayout];
}

- (void)setItemCountText:(NSString *)itemCountText{
    self.itemsCountLabel.text = itemCountText;
    [self setNeedsLayout];
}

- (void)setWasReadCell:(BOOL)wasReadCell{
    if (wasReadCell) {
        [self.dot removeFromSuperview];
    }else{
        [self.contentView addSubview:self.dot];
    }
}

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    _wasReadCell = NO;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
    }
    
    return self;
}

@end
