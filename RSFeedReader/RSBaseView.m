//
//  RSBaseView.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSBaseView.h"

@interface RSBaseView()

@property (nonatomic, strong)UILabel *bottomLabel;

@end

@implementation RSBaseView

#pragma mark -- Initiallizer

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.bottomLabel = [[UILabel alloc]init];
        self.bottomLabel.backgroundColor = [UIColor whiteColor];
        self.bottomLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.numberOfLines = 0;
        self.bottomLabel.text = @"NO any RSS Feed";
        self.bottomLabel.textColor = [UIColor colorWithRed:0.99 green:0.7 blue:0.23 alpha:1];
        
        self.tableView = [[UITableView alloc]init];
        self.tableView.backgroundColor = [UIColor whiteColor];
        
        //Check iOS version
        
        
        [self addSubview:self.tableView];
    }
  
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
// 
//    return self;
//}

#pragma mark -- UIView override

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat yPoint = 0.0;
    
    self.tableView.frame  = CGRectMake(0.0, yPoint, self.bounds.size.width, self.bounds.size.height - yPoint);
    
    [self.bottomLabel sizeToFit];
    self.bottomLabel.frame = CGRectMake(self.bounds.size.width / 2 - CGRectGetWidth(self.bottomLabel.frame) / 2, self.bounds.size.height / 2 - CGRectGetHeight(self.bottomLabel.frame) / 2, CGRectGetWidth(self.bottomLabel.frame), self.bottomLabel.frame.size.height);
    self.bottomLabel.frame = CGRectIntegral(self.bottomLabel.frame);
}

@end
