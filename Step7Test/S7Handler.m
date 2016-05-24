//
//  S7Handler.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/17/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "S7Handler.h"

@implementation S7Handler
{
    S7Object client;
    NSMutableArray *readEntries;
    NSMutableArray *readPlanSelectors;
    NSMutableArray *readPlanObjects;
}

-(id)init {
    self = [super init];
    if(self) {
        readEntries = [[NSMutableArray alloc] init];
        return self;
    }
    else {
        return nil;
    }
}

-(void) connectTo: (NSString*) ipAddress rack: (int) rack slot: (int) slot withError: (NSError **) error {
    *error = nil;
    client = Cli_Create();
    const char *cIpAddress = [ipAddress cStringUsingEncoding:NSASCIIStringEncoding];
    int result = Cli_ConnectTo(client, cIpAddress, rack, slot);
    
    if (result != 0)
    {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSArray*) listBlocksOfType: (byte) blockType withError: (NSError **) error {
    *error = nil;
    int result;
    TS7BlocksOfType blocksOfType;
    int count = 0x2000; //Max block count
    result = Cli_ListBlocksOfType(client, blockType, &blocksOfType, &count);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {
        NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:count];
        for (int i = 0; i < count; i++) {
            NSNumber *n = @(blocksOfType[i]);
            [a addObject:n];
        }
        [a sortUsingComparator:
              ^NSComparisonResult(id obj1, id obj2){
                  
                  NSNumber *n1 = (NSNumber*)obj1;
                  NSNumber *n2 = (NSNumber*)obj2;
                  if (n1 > n2) {
                      return (NSComparisonResult)NSOrderedDescending;
                  }
                  
                  if (n1 < n2) {
                      return (NSComparisonResult)NSOrderedAscending;
                  }
                  return (NSComparisonResult)NSOrderedSame;
              }
          ];
        return a;
    }
    
}

-(void) disconnectWithError: (NSError **) error {
    *error = nil;
    int result;
    result = Cli_Disconnect(client);
    
    if (result != 0)
    {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSData*) readInputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error {
    *error = nil;
    int result;
    byte bytes[0x2000];
    result = Cli_EBRead(client, start, length, &bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {

        NSData *d = [[NSData alloc] initWithBytes:&bytes length:length];

        return d;
    }

}

-(void) writeInputsStartingAtByte:(int)start withData:(NSData *)data withError:(NSError **)error {
    *error = nil;
    int result;
    byte bytes[[data length]];
    [data getBytes:&bytes length:[data length]];
    
    result = Cli_EBWrite(client, start, (UInt)[data length], bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSData*) readOutputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error {
    *error = nil;
    int result;
    byte bytes[0x2000];
    result = Cli_ABRead(client, start, length, &bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {
        NSData *d = [[NSData alloc] initWithBytes:&bytes length:length];
        
        return d;
    }
    
}

-(void) writeOutputsStartingAtByte:(int)start withData:(NSData *)data withError:(NSError **)error {
    *error = nil;
    int result;
    byte bytes[[data length]];
    [data getBytes:&bytes length:[data length]];
    
    result = Cli_ABWrite(client, start, (UInt)[data length], bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSData*) readMarkersStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error {
    *error = nil;
    int result;
    byte bytes[0x2000];
    result = Cli_MBRead(client, start, length, &bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {
        NSData *d = [[NSData alloc] initWithBytes:&bytes length:length];
        
        return d;
    }
    
}

-(void) writeMarkersStartingAtByte:(int)start withData:(NSData *)data withError:(NSError **)error {
    *error = nil;
    int result;
    byte bytes[[data length]];
    [data getBytes:&bytes length:[data length]];
    
    result = Cli_MBWrite(client, start, (UInt)[data length], bytes);
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSData*) readDataBlock:(int)dataBlockNumber startingAtByte:(int)start withByteLength:(int)length withError:(NSError **)error {
    *error = nil;
    int result;
    byte bytes[0x2000];
    result = Cli_DBRead(client, dataBlockNumber, start, length, &bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {
        NSData *d = [[NSData alloc] initWithBytes:&bytes length:length];
        
        return d;
    }
}

-(void) writeDataBlock:(int)dataBlockNumber startingAtByte:(int)start withData:(NSData *)data withError:(NSError **)error {
    *error = nil;
    int result;
    byte bytes[[data length]];
    [data getBytes:&bytes length:[data length]];
    
    result = Cli_DBWrite(client, dataBlockNumber, start, (UInt)[data length], bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSDictionary*) listBlockCountsWithError: (NSError **) error {
    *error = nil;
    TS7BlocksList blockList;
    int result = Cli_ListBlocks(client, &blockList);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {
        NSMutableDictionary *d = [[NSMutableDictionary alloc] initWithCapacity:6];
        [d setObject:@(blockList.OBCount)   forKey:@"OB"];
        [d setObject:@(blockList.DBCount)   forKey:@"DB"];
        [d setObject:@(blockList.FCCount)   forKey:@"FC"];
        [d setObject:@(blockList.FBCount)   forKey:@"FB"];
        [d setObject:@(blockList.SFCCount)  forKey:@"SFC"];
        [d setObject:@(blockList.SFBCount)  forKey:@"SFB"];
        return d;
    }
    
}

-(NSString*) getPlcModeWithError:(NSError **)error {
    *error = nil;
    int status;
    int result = Cli_GetPlcStatus(client, &status);
    
    if(result != 0 || ((status != S7CpuStatusRun) & (status != S7CpuStatusStop))) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return @"Unknown";
    }
    else {
        if(status == S7CpuStatusRun) {
            return @"Run";
        }
        else {
            return @"Stop";
        }
    }
}

-(void) hotStartPlcWithError:(NSError **)error {
    int result = Cli_PlcHotStart(client);
    if(result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(void) stopPlcWithError:(NSError **)error {
    int result = Cli_PlcStop(client);
    if(result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSDictionary*) getPlcInfoWithError:(NSError **)error {
    *error = nil;
    TS7CpuInfo cpuInfo;
    int result = Cli_GetCpuInfo(client, &cpuInfo);
    
    if(result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {
        NSMutableDictionary *d = [[NSMutableDictionary alloc] initWithCapacity:5];
        [d setObject:@(cpuInfo.ModuleTypeName)  forKey:@"Module Type Name"];
        [d setObject:@(cpuInfo.SerialNumber)    forKey:@"Serial Number"];
        [d setObject:@(cpuInfo.ASName)          forKey:@"AS Name"];
        [d setObject:@(cpuInfo.Copyright)       forKey:@"Copyright"];
        [d setObject:@(cpuInfo.ModuleName)      forKey:@"Module Name"];
        return d;
    }
}

-(NSDictionary*) getPlcOrderCodeWithError:(NSError **)error {
    *error = nil;
    TS7OrderCode orderCode;
    int result = Cli_GetOrderCode(client, &orderCode);
    
    if(result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
        return nil;
    }
    else {
        NSMutableDictionary *d = [[NSMutableDictionary alloc] initWithCapacity:5];
        NSString *v = [[NSString alloc] initWithFormat:@"%d.%d.%d", orderCode.V1, orderCode.V2, orderCode.V3];
        
        [d setObject:@(orderCode.Code)      forKey:@"Order Code"];
        [d setObject:v                      forKey:@"Version"];
        return d;
    }
}

-(void)addReadEntry:(S7ReadEntry *)readEntry {
    [readEntries addObject:readEntry];
}

-(void)calculateRead {
    [readEntries sortUsingSelector:@selector(compare:)];
    
    const int MAX_CHUNK = 256;
    
    readPlanSelectors = [[NSMutableArray alloc] init];
    readPlanObjects = [[NSMutableArray alloc] init];
    
    //Current Operation Plan (byte number, length)
    NSMutableArray *currentIB;
    NSMutableArray *currentQB;
    NSMutableArray *currentMB;
    
    //Current Operation Plan (byte number, length, DB Number)
    NSMutableArray *currentDBB;
    
    for (int i = 0; i < [readEntries count]; i++) {
        S7ReadEntry *r = [readEntries objectAtIndex:i];
        if([r.readArea isEqualTo: @"IB"]) {
            if(currentIB == nil) {
                currentIB = [[NSMutableArray alloc] initWithArray:@[@(r.byteNumber), @1]];
            }
            if ((r.byteNumber - (int)currentIB[0]) < MAX_CHUNK) {
                [currentIB replaceObjectAtIndex:1 withObject:@(r.byteNumber - [currentIB[0] integerValue] + 1)];
            }
            else {
                [readPlanObjects addObject:@[@"IB", currentIB[0], currentIB[1]]];
                currentIB = nil;
            }
        }
        if([r.readArea isEqualTo:@"QB"]) {
            if(currentQB == nil) {
                currentQB = [[NSMutableArray alloc] initWithArray:@[@(r.byteNumber), @1]];
            }
            if ((r.byteNumber - (int)currentQB[0]) < MAX_CHUNK) {
                [currentQB replaceObjectAtIndex:1 withObject:@(r.byteNumber - [currentQB[0] integerValue] + 1)];
            }
            else {
                [readPlanObjects addObject:@[@"QB", currentQB[0], currentQB[1]]];
                currentQB = nil;
            }
        }
        if([r.readArea isEqualTo:@"MB"]) {
            if(currentMB == nil) {
                currentMB = [[NSMutableArray alloc] initWithArray:@[@(r.byteNumber), @1]];
            }
            if ((r.byteNumber - (int)currentMB[0]) < MAX_CHUNK) {
                [currentMB replaceObjectAtIndex:1 withObject:@(r.byteNumber - [currentMB[0] integerValue] + 1)];
            }
            else {
                [readPlanObjects addObject:@[@"MB", currentMB[0], currentMB[1]]];
                currentMB = nil;
            }
        }
        if([r.readArea isEqualTo:@"DB"]) {
            if(currentDBB == nil) {
                currentDBB  = [[NSMutableArray alloc] initWithArray:@[@(r.byteNumber), @(r.dbNumber), @1]];
            }
            if (r.dbNumber == [currentDBB[2] integerValue]) {
                if ((r.byteNumber - (int)currentDBB[0]) < MAX_CHUNK) {
                    [currentDBB replaceObjectAtIndex:1 withObject:@(r.byteNumber - [currentDBB[0] integerValue] + 1)];
                }
                else {
                    [readPlanObjects addObject:@[@"DBX", currentDBB[0], currentDBB[1], currentDBB[2]]];
                    currentDBB = nil;
                }
            }
            else {
                [readPlanObjects addObject:@[@"DBX", currentDBB[0], currentDBB[1], currentDBB[2]]];
                currentDBB = nil;
            }
        }
    }
    if(currentIB != nil)
        [readPlanObjects addObject:@[@"IB", currentIB[0], currentIB[1]]];
    if(currentQB != nil)
        [readPlanObjects addObject:@[@"QB", currentQB[0], currentQB[1]]];
    if(currentMB != nil)
        [readPlanObjects addObject:@[@"MB", currentMB[0], currentMB[1]]];
    if(currentDBB != nil)
        [readPlanObjects addObject:@[@"DBX", currentDBB[0], currentDBB[1], currentDBB[2]]];
}

-(void)executeRead {
    NSError *e;
    for (int i = 0; i < [readPlanObjects count]; i++) {
        if([readPlanObjects[i][0] isEqual:@"IB"]) {
            [self readInputsStartingAtByte:(int)[readPlanObjects[i][1] integerValue] withByteLength:(int)[readPlanObjects[i][2] integerValue] withError:&e];
        }
        if([readPlanObjects[i][0] isEqual:@"QB"]) {
            [self readOutputsStartingAtByte:(int)[readPlanObjects[i][1] integerValue] withByteLength:(int)[readPlanObjects[i][2] integerValue] withError:&e];
        }
        if([readPlanObjects[i][0] isEqual:@"MB"]) {
            [self readMarkersStartingAtByte:(int)[readPlanObjects[i][1] integerValue] withByteLength:(int)[readPlanObjects[i][2] integerValue] withError:&e];
        }
        if([readPlanObjects[i][0] isEqual:@"DBX"]) {
            [self readDataBlock:(int)[readPlanObjects[i][3] integerValue] startingAtByte:(int)[readPlanObjects[i][1] integerValue] withByteLength:(int)[readPlanObjects[i][2] integerValue] withError:&e];
        }
    }
}

@end
