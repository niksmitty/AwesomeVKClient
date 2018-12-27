//
//  RecordService.h
//  AwesomeVKClient
//
//  Created by Никита on 27/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

@interface RecordService : NSObject

@property (nonatomic, strong) NSString* outputFilePath;

- (instancetype)initWithOutputFileName:(NSString*)fileName;

- (BOOL)prepareToRecord;
- (BOOL)record;
- (void)stop;

@end
