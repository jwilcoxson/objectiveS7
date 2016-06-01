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
- (void)connectTo:(NSString *)ipAddress
             rack:(int)rack
             slot:(int)slot
        withError:(NSError * __autoreleasing *)error;

-(void)disconnectWithError:(NSError * __autoreleasing *)error;

//Directory Functions
- (NSArray *)listBlocksOfType:(byte)blockType withError:(NSError * __autoreleasing *)error;
- (NSDictionary *)listBlockCountsWithError:(NSError * __autoreleasing *) error;

//Data I/O Functions

//Inputs
- (NSData *)readInputsStartingAtByte:(int)start
                      withByteLength:(int)length
                           withError:(NSError * __autoreleasing *)error;

- (void)writeInputsStartingAtByte:(int)start
                         withData:(NSData *)data
                        withError:(NSError * __autoreleasing *)error;

//Outputs
- (NSData *)readOutputsStartingAtByte:(int)start
                       withByteLength:(int)length
                            withError:(NSError * __autoreleasing *)error;

- (void)writeOutputsStartingAtByte:(int)start
                          withData:(NSData *)data
                         withError:(NSError * __autoreleasing *)error;

//Markers
- (NSData *)readMarkersStartingAtByte:(int)start
                       withByteLength:(int)length
                            withError:(NSError * __autoreleasing *)error;

- (void)writeMarkersStartingAtByte:(int)start
                          withData:(NSData *)data
                         withError:(NSError * __autoreleasing *)error;

//Data Blocks
- (NSData *)readDataBlock:(int)dataBlockNumber
           startingAtByte:(int)start
           withByteLength:(int)length
                withError:(NSError * __autoreleasing *)error;

- (void)writeDataBlock:(int)dataBlockNumber
        startingAtByte:(int)start
              withData:(NSData *)data
             withError:(NSError * __autoreleasing *)error;

//PLC Control Functions
- (NSString *)getPlcModeWithError:(NSError * __autoreleasing *)error;
- (void)hotStartPlcWithError:(NSError * __autoreleasing *)error;
- (void)stopPlcWithError:(NSError * __autoreleasing *)error;

//PLC Info Functions
- (NSDictionary *)getPlcInfoWithError:(NSError * __autoreleasing *)error;
- (NSDictionary *)getPlcOrderCodeWithError:(NSError * __autoreleasing *)error;

//Read Entries
- (void)addReadEntry:(S7ReadEntry *)readEntry;
- (void)calculateRead;
- (void)executeRead;

@end



#endif /* S7Handler_h */
