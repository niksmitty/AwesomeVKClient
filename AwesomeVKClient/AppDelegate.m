//
//  AppDelegate.m
//  AwesomeVKClient
//
//  Created by Никита on 24/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "AppDelegate.h"
#import "VkAPIManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
    CLLocationManager *locationManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    
    //FOR DEBUG ONLY!!!
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@", documentsDirectory);
    
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

- (void)handleEventForRegion:(CLRegion*)region withMessage:(NSString*)message {
    CLCircularRegion *reg = (CLCircularRegion*)region;
    double latitude = reg.center.latitude;
    double longitude = reg.center.longitude;
    double radius = reg.radius;
    
    NSString *fullMessage = [NSString stringWithFormat:@"%@ %f, %f, %f", message, latitude, longitude, radius];
    
    [[VkAPIManager sharedInstance] getWallPostWithMessage:fullMessage
                                           andAttachments:@""
                                              andLatitude:@(latitude)
                                             andLongitude:@(longitude)
                                    withCompletionHandler:^(NSError *error, NSDictionary *result) {}];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLCircularRegion class]]) {
        [self handleEventForRegion:region withMessage:@"Вход в"];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLCircularRegion class]]) {
        [self handleEventForRegion:region withMessage:@"Выход из"];
    }
}

@end
