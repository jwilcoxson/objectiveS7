//
//  S7Handler.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/17/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "S7Handler.h"
#import "S7Errors.h"

@implementation S7Handler

S7Object client;

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

-(NSArray*) listBlocksOfType: (int) blockType withError: (NSError **) error {
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
        return a;
    }
    
}

-(void) disconnect {
    int result;
    result = Cli_Disconnect(client);
}

-(NSArray*) readInputsStartingAtByte: (int) start withLength: (int) length withError: (NSError **) error {
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
            NSNumber *n = [[NSNumber alloc] initWithUnsignedChar:bytes[i]];
            [a addObject:n];
        }
        return a;
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
        [d setValue:[[NSNumber alloc] initWithInt:blockList.OBCount] forUndefinedKey:@"OB"];
        [d setValue:[[NSNumber alloc] initWithInt:blockList.DBCount] forUndefinedKey:@"DB"];
        [d setValue:[[NSNumber alloc] initWithInt:blockList.FCCount] forUndefinedKey:@"FC"];
        [d setValue:[[NSNumber alloc] initWithInt:blockList.FBCount] forUndefinedKey:@"FB"];
        [d setValue:[[NSNumber alloc] initWithInt:blockList.SFCCount] forUndefinedKey:@"SFC"];
        [d setValue:[[NSNumber alloc] initWithInt:blockList.SFBCount] forUndefinedKey:@"SFB"];
        return d;
    }
    
}

@end
