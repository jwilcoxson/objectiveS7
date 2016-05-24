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
#import "S7ReadEntry.h"

@interface S7Handler : NSObject

//Administrative Functions
-(void) connectTo: (NSString*) ipAddress rack: (int) rack slot: (int) slot withError: (NSError **) error;
-(void) disconnectWithError: (NSError **) error;

//Directory Functions
-(NSArray*) listBlocksOfType: (byte) blockType withError: (NSError **) error;
-(NSDictionary*) listBlockCountsWithError: (NSError **) error;

//Data I/O Functions

//Inputs
-(NSData*) readInputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error;
-(void) writeInputsStartingAtByte: (int) start withData: (NSData*) data withError: (NSError **) error;

//Outputs
-(NSData*) readOutputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error;
-(void) writeOutputsStartingAtByte: (int) start withData: (NSData*) data withError: (NSError **) error;

//Markers
-(NSData*) readMarkersStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error;
-(void) writeMarkersStartingAtByte: (int) start withData: (NSData*) data withError: (NSError **) error;

//Data Blocks
-(NSData*) readDataBlock: (int) dataBlockNumber startingAtByte: (int) start withByteLength: (int) length withError: (NSError**) error;
-(void) writeDataBlock: (int) dataBlockNumber startingAtByte: (int) start withData: (NSData*) data withError: (NSError**) error;

//PLC Control Functions
-(NSString*) getPlcModeWithError: (NSError**) error;
-(void) hotStartPlcWithError: (NSError**) error;
-(void) stopPlcWithError: (NSError**) error;

//PLC Info Functions
-(NSDictionary*) getPlcInfoWithError: (NSError**) error;
-(NSDictionary*) getPlcOrderCodeWithError: (NSError**) error;

//Read Entries
-(void)addReadEntry:(S7ReadEntry*) readEntry;
-(void)calculateRead;
-(void)executeRead;

@end



#endif /* S7Handler_h */
