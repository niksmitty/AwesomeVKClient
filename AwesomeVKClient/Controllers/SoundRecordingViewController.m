//
//  SoundRecordingViewController.m
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "SoundRecordingViewController.h"

@interface SoundRecordingViewController ()

@end

@implementation SoundRecordingViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Запись звука с микрофона";
    
    [self setupUI];
}

- (void)setupUI {
    soundRecordButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    soundRecordButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    soundRecordButton.layer.masksToBounds = YES;
    soundRecordButton.layer.cornerRadius = MIN(soundRecordButton.frame.size.width, soundRecordButton.frame.size.height) / 2;
    soundRecordButton.layer.borderColor = [UIColor blackColor].CGColor;
    soundRecordButton.layer.borderWidth = 2.0;
}

#pragma mark - Actions

- (IBAction)soundRecordButtonTouchUpInside:(UIButton *)sender {
    [sender.layer removeAllAnimations];
}

- (IBAction)soundRecordButtonTouchDown:(UIButton *)sender {
    sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         sender.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished){}];
}

@end
