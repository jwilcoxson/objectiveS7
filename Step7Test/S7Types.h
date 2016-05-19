//
//  S7Byte.h
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/19/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S7Byte : NSObject

-(id)initWithArray:(NSArray*) a;
-(id)initWithByte:(UInt8) b;
-(id)init;

-(BOOL) getBit:(int) bitNumber;
-(void) setBit:(int) bitNumber value:(BOOL) b;
-(UInt8) getValue;
-(void) setValue:(UInt8) v;

@end

@interface S7Word : NSObject

-(id)initWithS7Bytes:(S7Byte*) low and:(S7Byte*) high;
-(id)init;
-(UInt16) getValue;
-(void) setValue:(UInt16) v;

@end

@interface S7DWord : NSObject

-(id)initWithS7Words:(S7Word*) low and:(S7Word*) high;
-(id)init;
-(UInt32) getValue;
-(void) setValue:(UInt32) v;

@end

@interface S7Real : NSObject

-(id)initWithS7Words:(S7Word*) low and:(S7Word*) high;
-(id)init;
-(float) getValue;
-(void) setValue:(float) v;

@end