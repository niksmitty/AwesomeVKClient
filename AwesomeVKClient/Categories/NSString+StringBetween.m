//
//  NSString+StringBetween.m
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import "NSString+StringBetween.h"

@implementation NSString (StringBetween)

- (NSString*)getStringBetweenString:(NSString*)firstString andString:(NSString*)secondString {
    NSRange firstRange = [self rangeOfString:firstString];
    NSRange secondRange = [self rangeOfString:secondString];
    
    if (firstRange.length == 0 || secondRange.length == 0) {
        return nil;
    }
    
    return [[self substringFromIndex:firstRange.location + firstRange.length] substringToIndex:[[self substringFromIndex:firstRange.location + firstRange.length] rangeOfString:secondString].location];
}

@end
