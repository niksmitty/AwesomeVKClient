//
//  SoundRecordingViewController.h
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationService.h"

@interface SoundRecordingViewController : UIViewController<LocationServiceDelegate> {
    __weak IBOutlet UIButton *soundRecordButton;
    __weak IBOutlet UILabel *progressLabel;
    __weak IBOutlet UIProgressView *progressView;
}

@end
