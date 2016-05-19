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
}
-(void) connectTo: (NSString*) ipAddress rack: (int) rack slot: (int) slot withError: (NSError **) error {
    
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
            NSNumber *n = [[NSNumber alloc] initWithUnsignedInt:blocksOfType[i]];
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
    int result;
    result = Cli_Disconnect(client);
    
    if (result != 0)
    {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSArray*) readInputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error {
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
        NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:length];
        for (int i = 0; i < length; i++) {
            S7Byte *b = [[S7Byte alloc] initWithByte:bytes[i]];
            [a addObject:b];
        }
        return a;
    }

}

-(void) writeInputsStartingAtByte:(int)start withData:(NSArray *)data withError:(NSError **)error {
    int result;
    byte bytes[[data count]];
    for (int i = 0; i < [data count]; i++) {
        bytes[i] = [(S7Byte*)data[i] getValue];
    }
    result = Cli_EBWrite(client, start, (UInt)[data count], bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSArray*) readOutputsStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error {
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
        NSMutableArray *a = [[NSMutableArray alloc] init];
        for (int i = 0; i < length; i++) {
            S7Byte *b = [[S7Byte alloc] initWithByte:bytes[i]];
            [a addObject:b];
        }
        return a;
    }
    
}

-(void) writeOutputsStartingAtByte:(int)start withData:(NSArray *)data withError:(NSError **)error {
    int result;
    byte bytes[[data count]];
    for (int i = 0; i < [data count]; i++) {
        bytes[i] = [(S7Byte*)data[i] getValue];
    }
    result = Cli_ABWrite(client, start, (UInt)[data count], bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSArray*) readMarkersStartingAtByte: (int) start withByteLength: (int) length withError: (NSError **) error {
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
        NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:length];
        for (int i = 0; i < length; i++) {
            S7Byte *b = [[S7Byte alloc] initWithByte:bytes[i]];
            [a addObject:b];
        }
        return a;
    }
    
}

-(void) writeMarkersStartingAtByte:(int)start withData:(NSArray *)data withError:(NSError **)error {
    int result;
    byte bytes[[data count]];
    for (int i = 0; i < [data count]; i++) {
        bytes[i] = [(S7Byte*)data[i] getValue];
    }
    result = Cli_MBWrite(client, start, (UInt)[data count], bytes);
    
    if (result != 0) {
        *error = [[NSError alloc] initWithDomain:Step7TestErrorDomain
                                            code:result
                                        userInfo:NULL];
    }
}

-(NSDictionary*) listBlockCountsWithError: (NSError **) error {
    
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
        [d setObject:[[NSNumber alloc] initWithInt:blockList.OBCount] forKey:@"OB"];
        [d setObject:[[NSNumber alloc] initWithInt:blockList.DBCount] forKey:@"DB"];
        [d setObject:[[NSNumber alloc] initWithInt:blockList.FCCount] forKey:@"FC"];
        [d setObject:[[NSNumber alloc] initWithInt:blockList.FBCount] forKey:@"FB"];
        [d setObject:[[NSNumber alloc] initWithInt:blockList.SFCCount] forKey:@"SFC"];
        [d setObject:[[NSNumber alloc] initWithInt:blockList.SFBCount] forKey:@"SFB"];
        return d;
    }
    
}

@end
