//
//  LocationService.h
//  AwesomeVKClient
//
//  Created by Никита on 27/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class LocationService;

@protocol LocationServiceDelegate <NSObject>

- (void)locationService:(LocationService*)locationService didUpdateLocation:(CLLocationCoordinate2D)coordinate;

@end

@interface LocationService : CLLocationManager<CLLocationManagerDelegate>

@property (nonatomic, weak) id<LocationServiceDelegate> locationServiceDelegate;

@end
