//
//  S7Byte.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/19/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "S7Types.h"

@implementation S7Byte
{
    NSMutableArray *bits;
}
-(id)initWithArray:(NSArray *)a {
    self = [super init];
    
    if(self) {
        bits = [[NSMutableArray alloc] initWithArray:a];
    
    }
    return self;
}

-(id)initWithByte:(UInt8) b {
    self = [super init];
    
    if(self) {
        bits = [[NSMutableArray alloc] initWithCapacity:8];
        for (int i; i < 8; i++) {
            [bits addObject:[[NSNumber alloc] initWithBool:((b >> i) & 0x01)]];
        }
    }
    return self;
}

-(id)init {
    self = [super init];
    
    if(self) {
        bits = [[NSMutableArray alloc] initWithArray: @[@0,@0,@0,@0,@0,@0,@0,@0]];

    }
    return self;
}

-(BOOL) getBit:(int)bitNumber {
    BOOL x = [bits[bitNumber % 8] boolValue];
    return x;
}

-(void) setBit:(int)bitNumber value:(BOOL)b {
    [bits setObject:[[NSNumber alloc] initWithBool:b] atIndexedSubscript:(bitNumber % 8)];
}

-(UInt8) getValue{
    UInt8 v = 0;
    for (int i = 0; i< 8; i++) {
        if ([self getBit:i] == YES) {
            v = v + pow(2, i);
        }
    }
    return v;
}

-(void) setValue:(UInt8) v {
    for (int i = 0; i < 8; i++) {
        [bits addObject:[[NSNumber alloc] initWithBool:(v >> i) & 0x01]];
    }
}

@end

@implementation S7Word

-(id)initWithS7Bytes:(S7Byte *)low and:(S7Byte *)high {
    self = [super init];
    if (self) {
        //TODO
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        //TODO
    }
    return self;
}

-(UInt16) getValue {
    UInt16 v = 0;
    //TODO
    return v;
}

-(void) setValue:(UInt16) v {
    //TODO
}

@end

@implementation S7DWord

-(id)initWithS7Words:(S7Word *)low and:(S7Word *)high {
    self = [super init];
    if (self) {
        //TODO
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        //TODO
    }
    return self;
}

-(UInt32) getValue {
    UInt32 v = 0;
    //TODO
    return v;
}

-(void) setValue:(UInt32) v {
    //TODO
}

@end

@implementation S7Real

-(id)initWithS7Words:(S7Word *)low and:(S7Word *)high {
    self = [super init];
    if (self) {
        //TODO
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
       //TODO
    }
    return self;
}

-(float) getValue {
    UInt16 v = 0;
    //TODO
    return v;
}

-(void) setValue:(float) v {
    //TODO
}

@end
