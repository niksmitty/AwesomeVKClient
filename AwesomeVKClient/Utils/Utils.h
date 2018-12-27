//
//  Utils.h
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)clearVkCookies;
+ (NSString*)getDocumentsDirectory;
+ (NSString*)replacePathExtensionInPath:(NSString*)path withNext:(NSString*)newPathExt;

@end
