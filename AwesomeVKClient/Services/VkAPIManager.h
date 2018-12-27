//
//  VkAPIManager.h
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface VkAPIManager : AFHTTPSessionManager

+ (instancetype _Nonnull)sharedInstance;

- (void)setAccessToken:(NSString*)accessToken;

- (void)getProfileInfoWithCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion;
- (void)getWallUploadServerWithCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion;
- (void)postUploadFileWithUrl:(NSString*)uploadUrl
                  andFilePath:(NSString*)filePath
 andProgressCompletionHandler:(void (^)(double fractionCompleted))progressCompletion
        withCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion;
- (void)getDocsSaveForFile:(NSString*)file withCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion;
- (void)getWallPostWithAttachments:(NSString*)attachments andLatitude:(NSNumber*)lat andLongitude:(NSNumber*)lon withCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion;

@end
