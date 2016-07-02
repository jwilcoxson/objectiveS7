//
//  S7ReadEntry.h
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/20/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S7ReadEntry : NSObject

@property NSString *readArea;
@property int dbNumber;
@property int byteNumber;

- (id)initDBReadEntry:(int)dbNumber byte:(int)byteNumber;
- (id)initIBReadEntryAtByte:(int)byteNumber;
- (id)initQBReadEntryAtByte:(int)byteNumber;
- (id)initMBReadEntryAtByte:(int)byteNumber;
- (NSComparisonResult)compare:(S7ReadEntry *)otherEntry;

@end
