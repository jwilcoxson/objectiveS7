//
//  S7Byte.h
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/19/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S7Data : NSObject

+(BOOL) getBit: (UInt8) bitNumber fromByte: (UInt16) byteNumber inData: (NSData*) data;
+(NSData*) setBit: (UInt8) bitNumber fromByte: (UInt16) byteNumber inData: (NSData*) data value: (BOOL) value;
+(UInt8) getByte: (UInt16) byteNumber inData: (NSData*) data;
+(NSData*) setByte: (UInt16) byteNumber inData: (NSData*) data value: (UInt8) value;

@end