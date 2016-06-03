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

@property BOOL connected;

NS_ASSUME_NONNULL_BEGIN

//Administrative Functions
- (void)connectTo:(NSString *)ipAddress
             rack:(int)rack
             slot:(int)slot
            error:(NSError * __autoreleasing *)error;

- (void)disconnectWithError:(NSError * __autoreleasing *)error;

//Directory Functions
- (NSArray * __nullable)listBlocksOfType:(byte)blockType error:(NSError * __autoreleasing *)error;
- (NSDictionary * __nullable)listBlockCountsWithError:(NSError * __autoreleasing *)error;
- (NSDictionary * __nullable)listBlockInformation:(byte)blockType
                                           number:(int)blockNumber
                                            error:(NSError * __autoreleasing *)error;
- (NSData * __nullable)uploadBlock:(byte)blockType
                            number:(int)blockNumber
                             error:(NSError * __autoreleasing *)error;

//Data I/O Functions

//Inputs
- (NSData * __nullable)readInputsStartingAtByte:(int)start
                                     byteLength:(int)length
                                          error:(NSError * __autoreleasing *)error;

- (void)writeInputsStartingAtByte:(int)start
                             data:(NSData *)data
                            error:(NSError * __autoreleasing *)error;

//Outputs
- (NSData * __nullable)readOutputsStartingAtByte:(int)start
                                      byteLength:(int)length
                                           error:(NSError * __autoreleasing *)error;

- (void)writeOutputsStartingAtByte:(int)start
                              data:(NSData *)data
                             error:(NSError * __autoreleasing *)error;

//Markers
- (NSData * __nullable)readMarkersStartingAtByte:(int)start
                                      byteLength:(int)length
                                           error:(NSError * __autoreleasing *)error;

- (void)writeMarkersStartingAtByte:(int)start
                              data:(NSData *)data
                             error:(NSError * __autoreleasing *)error;

//Data Blocks
- (NSData * __nullable)readDataBlock:(int)dataBlockNumber
                        startingByte:(int)start
                          byteLength:(int)length
                               error:(NSError * __autoreleasing *)error;

- (void)writeDataBlock:(int)dataBlockNumber
          startingByte:(int)start
                  data:(NSData *)data
                 error:(NSError * __autoreleasing *)error;

//PLC Control Functions
- (NSString *)getPlcModeWithError:(NSError * __autoreleasing *)error;
- (void)hotStartPlcWithError:(NSError * __autoreleasing *)error;
- (void)stopPlcWithError:(NSError * __autoreleasing *)error;

//PLC Info Functions
- (NSDictionary * __nullable)getPlcInfoWithError:(NSError * __autoreleasing *)error;
- (NSDictionary * __nullable)getPlcOrderCodeWithError:(NSError * __autoreleasing *)error;

//Read Entries
- (void)addReadEntry:(S7ReadEntry *)readEntry;
- (void)calculateRead;
- (void)executeRead;

NS_ASSUME_NONNULL_END

@end

#endif /* S7Handler_h */
