//
//  RSXMLParser.h
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
#import "FeedItem.h"

@protocol RSXMLParserProtocol <NSObject>

- (void)didEndParsingFeed:(Feed *)feed;
- (void)didFailParsingFeed;

@end

@interface RSXMLParser : NSObject

@property (nonatomic, weak) id<RSXMLParserProtocol> delegate;

- (void)beginParseURL:(NSURL *)rssURL;
@end
