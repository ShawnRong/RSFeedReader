//
//  AppDelegate.m
//  RSFeedReader
//
//  Created by 戎晟 on 16/6/19.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "AppDelegate.h"
#import "RSFeedListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    RSFeedListViewController *feedListViewCOntroller = [[RSFeedListViewController alloc] init];
    
    self.navigationController = [[UINavigationController alloc] init];
    self.navigationController.viewControllers = @[feedListViewCOntroller];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.7 blue:0.23 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = _navigationController;
    [self.window makeKeyAndVisible];
    
//   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    //configure cache to minimize its capacity
    NSURLCache *appCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:appCache];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if (![url.resourceSpecifier isEqual:nil]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        UIViewController *topViewController = self.navigationController.topViewController;
        
        RSFeedListViewController *vc = (RSFeedListViewController *)topViewController;
        if (vc) {
            [vc showEnterFeedAlertView:url.absoluteString];
        }
    }
    
    return YES;
}

@end
