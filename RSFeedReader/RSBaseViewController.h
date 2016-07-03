//
//  RSBaseViewController.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSXMLParser.h"

@interface RSBaseViewController : UIViewController <RSXMLParserProtocol>

- (void)showEnterFeedAlertView:(NSString *)feedURL;
- (void)showInvalidRSSAlert;
- (void)showDuplicateRSSAlert;

- (void)addFeedPressed:(NSString *)URL;
- (void)startParsingURL:(NSString *)URL;

- (void)showAlertMessage:(NSString *)message;
@end
