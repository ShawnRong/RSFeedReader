//
//  RSBaseViewController.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSBaseViewController.h"
#import "RSBrain.h"

@interface RSBaseViewController ()

@end

@implementation RSBaseViewController

#pragma mark -- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RSSFeedsReader";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark -- Alert

- (void)showEnterFeedAlertView:(NSString *)feedURL{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Add Feed" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.view endEditing:YES];
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = [alertController.textFields firstObject];
        if ([textField.text length] != 0) {
            [self addFeedPressed:textField.text];
        }else{
            [self showInvalidRSSAlert];
        }
    }];
    [alertController addAction:nextAction];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"http://www.something.com/rss";
        if ([feedURL length] != 0) {
            textField.text = feedURL;
        }
    }];
    
    
    UIViewController *rootViewController = [[[[UIApplication sharedApplication]delegate] window] rootViewController];
    [rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showInvalidRSSAlert{
    [self showAlertMessage:@"RSS feed can't be parsed"];
}

- (void)showDuplicateRSSAlert{
    [self showAlertMessage:@"RSS feed already exists,\n try another one"];
}

#pragma mark -- Add Feeds

- (void)addFeedPressed:(NSString *)URL{
    
}

- (void)startParsingURL:(NSString *)URL{
    RSXMLParser *parser = [[RSBrain sharedBrain] parser];
    parser.delegate = self;
    
    NSURL *url = [NSURL URLWithString:URL];
    
    if (url != nil) {
        [parser beginParseURL:url];
    }else{
        [self showInvalidRSSAlert];
    }
}

#pragma mark -- RSXMLParserProtocol Method

- (void)didEndParsingFeed:(Feed *)feed{
    
}

- (void)didFailParsingFeed{
    [self showInvalidRSSAlert];
}

#pragma mark -- Common Alert

- (void)showAlertMessage:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops..." message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view endEditing:YES];
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}




@end
