//
//  RSCoreDataManager.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/25.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "RSCoreDataManager.h"

@interface RSCoreDataManager()

@property(nonatomic, strong) NSURL *applicationDocumentDirectory;
@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation RSCoreDataManager

#pragma mark -- Set Method

- (NSURL *)applicationDocumentDirectory{
    if(_applicationDocumentDirectory == nil){
        NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        _applicationDocumentDirectory = urls[urls.count - 1];
    }
    
    return _applicationDocumentDirectory;
}

- (NSManagedObjectModel *)managedObjectModel{
    if(_managedObjectModel == nil){
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"RSFeed" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if(_persistentStoreCoordinator == nil){
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSURL *url = [self.applicationDocumentDirectory URLByAppendingPathComponent:@"iFeed.sqlite"];
        
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
        
        if(error){
            _persistentStoreCoordinator = nil;
            
            NSDictionary *dict = [[NSDictionary alloc]init];
            [dict setValue:@"Failed to initialize the application's saved data" forKey:@"NSLocalizedDescriptionKey"];
            [dict setValue:failureReason forKey:@"NSLocalizedFailureReasonErrorKey"];
            [dict setValue:error forKey:@"NSUnderlyingErrorKey"];
            
            error = [[NSError alloc] initWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
            abort();
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext{
    if(_managedObjectContext == nil){
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    
    return _managedObjectContext;
}

#pragma mark -- Core Data Saving Support

- (void)saveContext{
    if([self.managedObjectContext hasChanges]){
        NSError *error = nil;
        [self.managedObjectContext save:&error];
        if(error){
            
            NSLog(@"Unresolved error %@,%@",error,error.userInfo);
            
#if __DEBUG__
            abort();
#endif
        }
    }
}

#pragma mark -- Public Method
- (NSManagedObject *)createEntityWithName:(NSString *)name{
    NSManagedObject *foo = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
    
    return foo;
}

- (NSArray *)allFeeds{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:kFeed inManagedObjectContext:self.managedObjectContext];
    
    if (description != nil) {
        request.entity = description;
    }
    
    NSError *error;
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if(error){
        
        NSLog(@"Unresolved error %@,%@",error,error.userInfo);
        
#if __DEBUG__
        abort();
#endif
    }
    

    return result;
}

- (void)deleteObject:(NSManagedObject *)entityObject{
    [self.managedObjectContext deleteObject:entityObject];
}

@end
