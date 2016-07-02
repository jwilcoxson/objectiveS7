//
//  S7ReadEntry.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/20/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "S7ReadEntry.h"

@implementation S7ReadEntry

@synthesize readArea, dbNumber, byteNumber;

- (id)initIBReadEntryAtByte:(int)byte {
    self = [super init];
    if(self) {
        readArea = @"IB";
        self.byteNumber = byte;
        return self;
    }
    else {
        return nil;
    }
}

- (id)initQBReadEntryAtByte:(int)byte {
    self = [super init];
    if(self) {
        readArea = @"QB";
        self.byteNumber = byte;
        return self;
    }
    else {
        return nil;
    }
}

- (id)initMBReadEntryAtByte:(int)byte {
    self = [super init];
    if(self) {
        readArea = @"MB";
        self.byteNumber = byte;
        return self;
    }
    else {
        return nil;
    }
}

- (id)initDBReadEntry:(int)dataBlock byte:(int)byte {
    self = [super init];
    if(self) {
        readArea = @"DB";
        self.dbNumber = dataBlock;
        self.byteNumber = byte;
        return self;
    }
    else {
        return nil;
    }
}

- (NSComparisonResult)compare:(S7ReadEntry *)otherEntry {
    if(self.readArea < otherEntry.readArea) {
        return NSOrderedAscending;
    }
    
    if(self.readArea > otherEntry.readArea) {
        return NSOrderedDescending;
    }
    
    if(self.readArea == otherEntry.readArea) {
        
        if(self.dbNumber < otherEntry.dbNumber) {
            return NSOrderedAscending;
        }
        
        if(self.dbNumber > otherEntry.dbNumber) {
            return NSOrderedDescending;
        }
        
        if(self.dbNumber == otherEntry.dbNumber) {
            if(self.byteNumber < otherEntry.byteNumber) {
                return NSOrderedAscending;
            }
            
            if(self.byteNumber > otherEntry.byteNumber) {
                return NSOrderedDescending;
            }
        }
    }
    
    return NSOrderedSame;
    
}

@end
