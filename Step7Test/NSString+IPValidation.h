//
//  NSString+IPValidation.h
//  Step7Test
//
//  Created by Joe Wilcoxson on 6/1/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <arpa/inet.h>

@interface NSString (IPValidation)

- (BOOL)isValidIPAddress;

@end
