//
//  S7Handler.h
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/17/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#ifndef S7Handler_h
#define S7Handler_h

#import "snap7.h"
#import <Foundation/Foundation.h>
#import "S7Errors.h"
#import "S7Types.h"

@interface S7Handler : NSObject

//Administrative Functions
-(void) connectTo: (NSString*) ipAddress rack: (int) rack slot: (int) slot withError: (NSError **) error;
-(void) disconnectWithError: (NSError **) error;

//Directory Functions
-(NSArray*) listBlocksOfType: (byte) blockType withError: (NSError **) error;
-(NSDictionary*) listBlockCountsWithError: (NSError **) error;

//Data I/O Functions

//Inputs
-(NSArray*) readInputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error;
-(void) writeInputsStartingAtByte: (int) start withData: (NSArray*) data withError: (NSError **) error;

//Outputs
-(NSArray*) readOutputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error;
-(void) writeOutputsStartingAtByte: (int) start withData: (NSArray*) data withError: (NSError **) error;

//Outputs
-(NSArray*) readMarkersStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error;
-(void) writeMarkersStartingAtByte: (int) start withData: (NSArray*) data withError: (NSError **) error;

@end

#endif /* S7Handler_h */
