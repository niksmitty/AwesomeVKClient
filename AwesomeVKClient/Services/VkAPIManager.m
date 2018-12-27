//
//  VkAPIManager.m
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "VkAPIManager.h"

static NSString * const VKAPIBaseURLString = @"https://api.vk.com/";
static NSString * const VKAPIMethodSuffix = @"method/";

@implementation VkAPIManager {
    NSString* _accessToken;
}

#pragma mark - Singleton

+ (instancetype _Nonnull)sharedInstance {
    static dispatch_once_t onceToken;
    static id sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VkAPIManager alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self = [[VkAPIManager alloc] initWithBaseURL:[NSURL URLWithString:VKAPIBaseURLString]];
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    
    return self;
}

#pragma mark - Setters

- (void)setAccessToken:(NSString*)accessToken {
    _accessToken = accessToken;
}

#pragma mark - API Methods

- (void)getProfileInfoWithCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion {
    NSString *urlPart = [NSString stringWithFormat:@"%@account.getProfileInfo?", VKAPIMethodSuffix];
    NSString *fullUrlString = [NSString stringWithFormat:@"%@access_token=%@&v=%@", urlPart, _accessToken, apiVersion];
    NSString *escapedUrlString = [fullUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [self GET:escapedUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *newResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)responseObject];
        if (completion)
            completion(nil, newResponse);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion)
            completion(error, [NSDictionary dictionary]);
    }];
}

- (void)getWallUploadServerWithCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion {
    NSString *urlPart = [NSString stringWithFormat:@"%@docs.getWallUploadServer?", VKAPIMethodSuffix];
    NSString *fullUrlString = [NSString stringWithFormat:@"%@access_token=%@&v=%@", urlPart, _accessToken, apiVersion];
    NSString *escapedUrlString = [fullUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [self GET:escapedUrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *newResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)responseObject];
        if (completion)
            completion(nil, newResponse);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion)
            completion(error, [NSDictionary dictionary]);
    }];
}

- (void)postUploadFileWithUrl:(NSString*)uploadUrl
                  andFilePath:(NSString*)filePath
 andProgressCompletionHandler:(void (^)(double fractionCompleted))progressCompletion
        withCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion {
    [self POST:uploadUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError* error;
        if (![formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath]
                                   name:@"file"
                               fileName:[filePath lastPathComponent]
                               mimeType:@"application/zip"
                                       error:&error]) {
            NSLog(@"%@", error);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressCompletion) progressCompletion(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *newResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)responseObject];
        if (completion) completion(nil, newResponse);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) completion(error, [NSDictionary dictionary]);
    }];
}

- (void)getDocsSaveForFile:(NSString*)file withCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion {
    NSString *urlPart = [NSString stringWithFormat:@"%@docs.save?", VKAPIMethodSuffix];
    NSString *fullUrlString = [NSString stringWithFormat:@"%@access_token=%@&v=%@", urlPart, _accessToken, apiVersion];
    NSString *escapedUrlString = [fullUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [self GET:escapedUrlString parameters:@{@"file": file} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *newResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)responseObject];
        if (completion)
            completion(nil, newResponse);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion)
            completion(error, [NSDictionary dictionary]);
    }];
}

- (void)getWallPostWithAttachments:(NSString*)attachments withCompletionHandler:(void (^)(NSError *error, NSDictionary *result))completion {
    NSString *urlPart = [NSString stringWithFormat:@"%@wall.post?", VKAPIMethodSuffix];
    NSString *fullUrlString = [NSString stringWithFormat:@"%@access_token=%@&v=%@", urlPart, _accessToken, apiVersion];
    NSString *escapedUrlString = [fullUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [self GET:escapedUrlString parameters:@{@"message": @"", @"attachments": attachments} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *newResponse = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)responseObject];
        if (completion)
            completion(nil, newResponse);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion)
            completion(error, [NSDictionary dictionary]);
    }];
}

@end
