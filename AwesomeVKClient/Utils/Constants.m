//
//  Constants.m
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "Constants.h"

NSString* const VkAPIOAuthBaseUrlPatternString = @"https://oauth.vk.com/authorize?client_id=%@"
                                                                                    "&group_ids=%@"
                                                                                    "&display=%@"
                                                                                    "&redirect_uri=%@"
                                                                                    "&scope=%@"
                                                                                    "&response_type=%@"
                                                                                    "&v=%@";
NSString* const appId = @"6796380";
NSString* const groupIds = @"";
NSString* const displayType = @"mobile";
NSString* const redirectUri = @"";
NSString* const responseType = @"token";
NSString* const apiVersion = @"5.92";

@implementation Constants

@end
