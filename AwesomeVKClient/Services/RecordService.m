//
//  RecordService.m
//  AwesomeVKClient
//
//  Created by Никита on 27/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "RecordService.h"
#import <AVFoundation/AVFoundation.h>

@implementation RecordService {
    AVAudioRecorder *recorder;
}

#pragma mark - Initialization

- (instancetype)initWithOutputFileName:(NSString*)fileName {
    self = [super init];
    
    if (self) {
        [self setCategoryForCurrentAudioSession];
        
        NSURL *outputFileUrl = [self fileUrlForFileWithName:fileName];
        NSMutableDictionary *recordSettings = [self recordSettings];
        
        recorder = [[AVAudioRecorder alloc] initWithURL:outputFileUrl
                                         settings:recordSettings
                                            error:NULL];
        recorder.meteringEnabled = YES;
    }
    
    return self;
}

- (NSURL*)fileUrlForFileWithName:(NSString*)fileName {
    fileName = [fileName stringByAppendingString:[NSString stringWithFormat:@".%@", audioFileExtension]];
    NSString *documentsDirectory = [Utils getDocumentsDirectory];
    NSArray *pathComponents = [NSArray arrayWithObjects:documentsDirectory, fileName, nil];
    _outputFilePath = [pathComponents componentsJoinedByString:@"/"];
    return [NSURL fileURLWithPathComponents:pathComponents];
}

- (NSMutableDictionary*)recordSettings {
    NSMutableDictionary *recordSettings = [NSMutableDictionary new];
    [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatFLAC] forKey:AVFormatIDKey];
    [recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    return recordSettings;
}

#pragma mark - Audio Session methods

- (void)setCategoryForCurrentAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (@available(iOS 10.0, *)) {
        [session setCategory:AVAudioSessionCategoryRecord
                        mode:AVAudioSessionModeDefault
                     options:AVAudioSessionCategoryOptionDefaultToSpeaker
                       error:nil];
    } else {
        [session setCategory:AVAudioSessionCategoryRecord
                 withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker
                       error:nil];
    }
}

- (void)setActiveForCurrentAudioSession:(BOOL)active {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:active error:nil];
}

#pragma mark - Public methods

- (BOOL)prepareToRecord {
    return [recorder prepareToRecord];
}

- (BOOL)record {
    if (!recorder.recording) {
        [self setActiveForCurrentAudioSession:YES];
        return [recorder record];
    }
    return NO;
}

- (void)stop {
    [recorder stop];
    [self setActiveForCurrentAudioSession:NO];
}

@end
