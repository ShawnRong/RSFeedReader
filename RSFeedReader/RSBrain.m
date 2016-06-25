//
//  RSBrain.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSBrain.h"
#import "RSXMLParser.h"
#import "RSCoreDataManager.h"

@interface RSBrain()

@property (nonatomic, strong) RSXMLParser *parser;
@property (nonatomic, strong) RSCoreDataManager *coreData;

@end

@implementation RSBrain

#pragma mark - Singleton

+ (id)sharedBrain{
    static RSBrain *brain = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        brain = [[self alloc] init];
    });
    
    return brain;
}


#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _parser = [[RSXMLParser alloc] init];
        _coreData = [[RSCoreDataManager alloc] init];
    }
    return self;
}

#pragma mark - Public Method

- (NSManagedObject *)createEntity:(NSString *)name{
    return [self.coreData createEntityWithName:name];
}

- (Feed *)feedForIndexPath:(NSIndexPath *)indexPath{
    
    NSAssert([indexPath isEqual:nil],@"Index path param is nil");

    Feed *feed = [[Feed alloc] init];

    NSInteger feedsCount = [self.coreData allFeeds].count;
    if (feedsCount > 0 && indexPath.row < feedsCount) {
        feed = [self.coreData allFeeds][indexPath.row];
    }
    
    NSAssert(feed != nil, @"Feed for index path is nil");
    
    return feed;
}

- (BOOL)isDuplicateURL:(NSString *)rssURL{
    BOOL returnValue = NO;
    
    NSArray *allItems = [[RSBrain sharedBrain] coreData].allFeeds;
    
    for (Feed *item in allItems) {
        if (rssURL == item.rssURL) {
            returnValue = YES;
        }
    }
    
    return returnValue;
}


@end
