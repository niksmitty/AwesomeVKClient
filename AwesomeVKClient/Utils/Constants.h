//
//  Constants.h
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PermissionsType: NSUInteger {
    WallType = 8192,
    DocsType = 131072
} PermissionsType;

extern NSString* const VkAPIOAuthBaseUrlPatternString;
extern NSString* const appId;
extern NSString* const groupIds;
extern NSString* const displayType;
extern NSString* const redirectUri;
extern NSString* const responseType;
extern NSString* const apiVersion;

extern NSString* const audioFileExtension;
extern NSString* const zipFileExtension;

@interface Constants : NSObject

@end
