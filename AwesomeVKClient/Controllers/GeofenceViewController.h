//
//  GeofenceViewController.h
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationService.h"

@interface GeofenceViewController : UIViewController<LocationServiceDelegate> {
    __weak IBOutlet UITextField *latitudeTextField;
    __weak IBOutlet UITextField *longitudeTextField;
    __weak IBOutlet UITextField *radiusTextField;
    __weak IBOutlet UILabel *geofencesCountLabel;
}

@end
