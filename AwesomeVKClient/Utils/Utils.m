//
//  Utils.m
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)clearVkCookies {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        if (NSNotFound != [cookie.domain rangeOfString:@"vk.com"].location) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage]
             deleteCookie:cookie];
        }
    }
}

@end
