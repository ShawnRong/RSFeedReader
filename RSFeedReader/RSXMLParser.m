//
//  RSXMLParser.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSXMLParser.h"
#import "MWFeedParser.h"
#import "RSBrain.h"
#import "RSCoreDataManager.h"

@interface RSXMLParser()<MWFeedParserDelegate>

@property (nonatomic, strong) Feed *feed;

@end

@implementation RSXMLParser


#pragma mark -- Public Method

- (void)beginParseURL:(NSURL *)rssURL{
    NSAssert(![rssURL isEqual:nil], @"URL is nil");
    
    MWFeedParser *parser = [[MWFeedParser alloc] initWithFeedURL:rssURL];
    parser.delegate = self;
    parser.feedParseType = ParseTypeFull;
    parser.connectionType = ConnectionTypeAsynchronously;
    [parser parse];
    
}

#pragma mark -- MWFeedParseDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser{
    self.feed = (Feed *)[[RSBrain sharedBrain] createEntity:kFeed];
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info{
    self.feed.title = info.title;
    self.feed.rssURL = [info.url absoluteString];
    
    if (info.summary != nil) {
        self.feed.summary = info.summary;
    }else{
        self.feed.summary = self.feed.rssURL;
    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    FeedItem *feedItem = (FeedItem *)[[RSBrain sharedBrain] createEntity:kFeedItem];
    
    if (item.title != nil) {
        feedItem.title = item.title;
    }
    
    if (item.link != nil) {
        feedItem.link = item.link;
    }
    
    if (item.date != nil) {
        feedItem.publishDate = item.date;
    }
    
    feedItem.feed = self.feed;
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error{
    [self.delegate  didFailParsingFeed];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser{
    [self.delegate didEndParsingFeed:self.feed];
}

@end
