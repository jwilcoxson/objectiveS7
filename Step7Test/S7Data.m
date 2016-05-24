//
//  S7Byte.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/19/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "S7Data.h"

@implementation S7Data

+(BOOL) getBit:(UInt8)bitNumber fromByte:(UInt16)byteNumber inData:(NSData *)data {
    UInt8 t;
    [data getBytes:&t range:NSMakeRange(byteNumber, 1)];
    return (t >> (bitNumber % 8)) & 0x01;
}

+(NSData*) setBit:(UInt8)bitNumber fromByte:(UInt16)byteNumber inData:(NSData *)data value:(BOOL)value {
    if (byteNumber < [data length]) {
        NSMutableData *d = [[NSMutableData alloc] initWithData:data];
        UInt8 b;
        [d getBytes:&b range:NSMakeRange(byteNumber, 1)];
        if (value) {
            b = b ^ (0x01 << (bitNumber % 8));
        }
        else {
            b = (0xFE << (bitNumber % 8)) ^ (UInt8)(pow(2, (bitNumber % 8)) -1);
        }
        [d replaceBytesInRange:NSMakeRange(byteNumber, 1) withBytes:&b];
        return d;
    }
    else {
        return data;
    }
}

+(UInt8) getByte:(UInt16)byteNumber inData:(NSData *)data {
    UInt8 b;
    [data getBytes:&b range:NSMakeRange((byteNumber % [data length]), 1)];
    return b;
}

+(NSData*) setByte:(UInt16)byteNumber inData:(NSData *)data value:(UInt8)value {

    if (byteNumber < [data length]) {
        NSMutableData *d = [[NSMutableData alloc] initWithData:data];
        [d replaceBytesInRange:NSMakeRange(byteNumber, 1) withBytes:&value];
        return d;
    }
    else {
        return data;
    }
}

@end