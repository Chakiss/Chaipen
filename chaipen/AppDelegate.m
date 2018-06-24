//
//  AppDelegate.m
//  chaipen
//
//  Created by Chakrit on 3/6/2561 BE.
//  Copyright © 2561 cjworkx. All rights reserved.
//

#import "AppDelegate.h"
#import "OnboardingViewController.h"
#import "CustomTabbarController.h"

@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FIRApp configure];
    
    //FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"KrungthaiFast-Bold" size:21.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    if ([FIRAuth auth].currentUser) {
        // User is signed in.
        // ...
        NSLog(@"User is signed in.");
    
        CustomTabbarController *customTabbarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabBarController"];
        self.window.rootViewController = customTabbarController;
        
    } else {
        // No user is signed in.
        // ...
        NSLog(@"No user is signed in.");
    
        [[FIRAuth auth] signInAnonymouslyAndRetrieveDataWithCompletion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            FIRUser *user = authResult.user;
            NSString *uid = user.uid;
            
            [[FIRFirestore firestore].settings setTimestampsInSnapshotsEnabled:YES];
            
            [[[[FIRFirestore firestore] collectionWithPath:USER] documentWithPath:uid] setData:@{
                                                                                                 FIRSTNAME : @"",
                                                                                                 LASTNAME : @"",
                                                                                                 GENDOR : @"",
                                                                                                 AGE : @"",
                                                                                                 CREATED : [NSDate date],
                                                                                                 UPDATED : [NSDate date]
                                                                                                 
                                                                                                 } completion:^(NSError * _Nullable error) {
                                                                                                     
                                                                                                 }];
            
        }];
        
        OnboardingViewController *onboardingViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OnboardingViewController"];
        self.window.rootViewController = onboardingViewController;
    }
    
    
   
   
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
