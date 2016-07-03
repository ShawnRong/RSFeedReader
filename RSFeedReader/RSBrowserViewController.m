//
//  RSBrowserViewController.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/7/3.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSBrowserViewController.h"

@interface RSBrowserViewController ()

@end

@implementation RSBrowserViewController

- (id)initWithConfiguration:(WKWebViewConfiguration *)configuration{
    self = [super initWithConfiguration:configuration];
    if (self) {
        self.actionButtonHidden = false;
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)dealloc{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.tintColor = self.navigationController.navigationBar.barTintColor;
    self.progressView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.progressView.frame.size.width);
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
}

@end
