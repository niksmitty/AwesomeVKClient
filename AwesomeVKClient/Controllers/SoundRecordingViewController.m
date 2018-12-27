//
//  SoundRecordingViewController.m
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "SoundRecordingViewController.h"

#import <SSZipArchive/SSZipArchive.h>
#import "VkAPIManager.h"
#import "RecordService.h"

@interface SoundRecordingViewController ()

@end

@implementation SoundRecordingViewController {
    RecordService *recordService;
    LocationService *locationService;
    
    CLLocationCoordinate2D _currentCoordinate;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Запись звука с микрофона";
    
    [self setupUI];
    
    recordService = [[RecordService alloc] initWithOutputFileName:@"audioFile"];
    [recordService prepareToRecord];
    
    locationService = [[LocationService alloc] init];
    locationService.locationServiceDelegate = self;
    [locationService startUpdatingLocation];
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
    
    [recordService stop];
    
    NSString *outputFilePath = [recordService outputFilePath];
    NSString *zipFilePath = [Utils replacePathExtensionInPath:outputFilePath withNext:zipFileExtension];
    
    [SSZipArchive createZipFileAtPath:zipFilePath
                     withFilesAtPaths:@[outputFilePath]];
    
    [[VkAPIManager sharedInstance] getWallUploadServerWithCompletionHandler:^(NSError *error, NSDictionary *result) {
        [[VkAPIManager sharedInstance] postUploadFileWithUrl:result[@"response"][@"upload_url"]
                                                 andFilePath:zipFilePath
                                andProgressCompletionHandler:^(double fractionCompleted) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        self->progressLabel.text = [NSString stringWithFormat:@"%d%%", (int)(fractionCompleted * 100)];
                                        self->progressView.progress = fractionCompleted;
                                    });
                                }
                                       withCompletionHandler:^(NSError *error, NSDictionary *result) {
                                           [[VkAPIManager sharedInstance] getDocsSaveForFile:result[@"file"]
                                                                       withCompletionHandler:^(NSError *error, NSDictionary *result) {
                                               NSDictionary *response = result[@"response"];
                                               NSDictionary *doc = response[@"doc"];
                                               NSString *type = response[@"type"];
                                               NSString *owner_id = doc[@"owner_id"];
                                               NSString *doc_id = doc[@"id"];
                                               NSString *attachmentsString = [NSString stringWithFormat:@"%@%@_%@", type, owner_id, doc_id];
                                               [[VkAPIManager sharedInstance] getWallPostWithAttachments:attachmentsString
                                                                                             andLatitude:[NSNumber numberWithDouble:self->_currentCoordinate.latitude]
                                                                                            andLongitude:[NSNumber numberWithDouble:self->_currentCoordinate.longitude]
                                                                                   withCompletionHandler:^(NSError *error, NSDictionary *result) {
                                                   
                                               }];
                                           }];
                                       }];
    }];
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
    
    [recordService record];
}

#pragma mark - LocationServiceDelegate

- (void)locationService:(LocationService *)locationService didUpdateLocation:(CLLocationCoordinate2D)coordinate {
    _currentCoordinate = coordinate;
}

@end
