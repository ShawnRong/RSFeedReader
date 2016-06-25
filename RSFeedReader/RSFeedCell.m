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
        self.topLabel = [[UILabel alloc] init];
        self.topLabel.backgroundColor = [UIColor whiteColor];
        self.topLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:[self topFontForDevice]];
        self.topLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.topLabel];
        
        self.bottomLabel = [[UILabel alloc] init];
        self.bottomLabel.backgroundColor = self.topLabel.backgroundColor;
        self.bottomLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:[self bottomFontForDevice]];
        self.bottomLabel.textAlignment = NSTextAlignmentLeft;
        [self. contentView addSubview:self.bottomLabel];
        
        self.itemsCountLabel = [[UILabel alloc] init];
        self.itemsCountLabel.backgroundColor = self.topLabel.backgroundColor;
        self.itemsCountLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10.0];
        self.itemsCountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.itemsCountLabel];
        
        self.dot = [[UIView alloc] init];
        self.dot.backgroundColor = [UIColor colorWithRed:0.99 green:0.7 blue:0.23 alpha:1];
        
    }
    
    return self;
}

#pragma mark - UIView override

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    [self.topLabel sizeToFit];
    self.topLabel.frame = CGRectIntegral(CGRectMake(15.0, self.bounds.size.height / 2 - self.topLabel.frame.size.height + 1.0, screenW - 70.0, self.topLabel.frame.size.height));
    
    
    [self.bottomLabel sizeToFit];
    self.bottomLabel.frame = CGRectIntegral(CGRectMake(CGRectGetMinX(self.topLabel.frame), CGRectGetMaxY(self.topLabel.frame) +1.0, self.topLabel.frame.size.width, self.bottomLabel.frame.size.width));
    
    [self.itemsCountLabel sizeToFit];
    self.itemsCountLabel.frame = CGRectIntegral(CGRectMake(screenW - self.itemsCountLabel.frame.size.width - 40.0, self.bounds.size.height / 2 - self.itemsCountLabel.frame.size.height / 2, self.itemsCountLabel.frame.size.width, self.itemsCountLabel.frame.size.height));
    
    CGFloat dotSide = 4.0;
    
    self.dot.frame = CGRectMake(screenW - 40.0, self.bounds.size.height / 2 - dotSide / 2, dotSide, dotSide);
    self.dot.layer.cornerRadius = dotSide / 2;
    self.dot.layer.masksToBounds = YES;
    
}

#pragma mark - Helper

- (CGFloat)topFontForDevice{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat returnValue;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        returnValue = 20.0;
    }else{
        returnValue = (width > 320) ? 16.0:14.0;
    }
    
    return returnValue;
}

- (CGFloat)bottomFontForDevice{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat returnValue;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        returnValue = 16.0;
    }else{
        returnValue = (width > 320) ? 12.0:10.0;
    }
    
    return returnValue;
    
}


@end



