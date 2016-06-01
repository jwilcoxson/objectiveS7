//
//  NSString+IPValidation.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 6/1/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "NSString+IPValidation.h"

@implementation NSString (IPValidation)

- (BOOL)isValidIPAddress
{
    const char *utf8 = [self UTF8String];
    int success;
    
    struct in_addr dst;
    success = inet_pton(AF_INET, utf8, &dst);
    if (success != 1) {
        struct in6_addr dst6;
        success = inet_pton(AF_INET6, utf8, &dst6);
    }
    
    return success == 1;
}

@end
