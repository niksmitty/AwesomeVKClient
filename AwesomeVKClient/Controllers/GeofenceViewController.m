//
//  GeofenceViewController.m
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "GeofenceViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface GeofenceViewController ()

@end

@implementation GeofenceViewController {
    LocationService *locationService;
    CLLocationManager *locationManager;
    
    int geofencesCount;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Geofence";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                           target:self
                                                                                           action:@selector(insertCurrentCoordinate)];
    
    geofencesCount = 0;
    geofencesCountLabel.text = [NSString stringWithFormat:@"Geofences count: %d", geofencesCount];
    
    locationService = [[LocationService alloc] init];
    locationService.locationServiceDelegate = self;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
}

#pragma mark - Actions

- (void)insertCurrentCoordinate {
    [locationService startUpdatingLocation];
}

- (IBAction)subscribeButtonTapped:(UIButton *)sender {
    CLLocationCoordinate2D geofenceRegionCenter = CLLocationCoordinate2DMake([latitudeTextField.text doubleValue], [longitudeTextField.text doubleValue]);
    CLCircularRegion *geofenceRegion = [[CLCircularRegion alloc] initWithCenter:geofenceRegionCenter
                                                                         radius:[radiusTextField.text doubleValue]
                                                                     identifier:[NSString stringWithFormat:@"id_%d", geofencesCount]];
    geofenceRegion.notifyOnEntry = YES;
    geofenceRegion.notifyOnExit = YES;
    [locationManager startMonitoringForRegion:geofenceRegion];
    geofencesCount++;
    geofencesCountLabel.text = [NSString stringWithFormat:@"Geofences count: %d", geofencesCount];
}

- (IBAction)unsubscribeButtonTapped:(UIButton *)sender {
    for (CLRegion *region in locationManager.monitoredRegions) {
        if ([region isKindOfClass:[CLCircularRegion class]]) {
            [locationManager stopMonitoringForRegion:region];
        }
    }
    geofencesCount = 0;
    geofencesCountLabel.text = [NSString stringWithFormat:@"Geofences count: %d", geofencesCount];
}

#pragma mark - LocationServiceDelegate

- (void)locationService:(LocationService *)locationService didUpdateLocation:(CLLocationCoordinate2D)coordinate {
    latitudeTextField.text = [NSString stringWithFormat:@"%f", coordinate.latitude];
    longitudeTextField.text = [NSString stringWithFormat:@"%f", coordinate.longitude];
    radiusTextField.text = @"20";
}

@end
