//
//  LocationService.m
//  AwesomeVKClient
//
//  Created by Никита on 27/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "LocationService.h"

@implementation LocationService {
    int _locationFetchCounter;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.delegate = self;
        self.distanceFilter = kCLDistanceFilterNone;
        self.desiredAccuracy = kCLLocationAccuracyBest;
        [self requestWhenInUseAuthorization];
        _locationFetchCounter = 0;
    }
    
    return self;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (_locationFetchCounter > 0) return;
    _locationFetchCounter++;
    [self stopUpdatingLocation];
    CLLocation *newLocation = [locations lastObject];
    if ([self.locationServiceDelegate conformsToProtocol:@protocol(LocationServiceDelegate)] && [self.locationServiceDelegate respondsToSelector:@selector(locationService:didUpdateLocation:)]) {
        [self.locationServiceDelegate locationService:self didUpdateLocation:newLocation.coordinate];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Failed to fetch current location : %@", error.localizedDescription);
}

@end
