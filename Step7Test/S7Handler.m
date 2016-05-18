//
//  S7Handler.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/17/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "S7Handler.h"

@implementation S7Handler

S7Object client;

-(int) connectTo: (NSString*) ipAddress rack: (int) rack slot: (int) slot {
    
    client = Cli_Create();
    const char *cIpAddress = [ipAddress cStringUsingEncoding:NSASCIIStringEncoding];
    int result = Cli_ConnectTo(client, cIpAddress, rack, slot);
    if (result == 0)
    {
        NSLog(@"Successfully connected to %@", ipAddress);
    }
    else {
        NSLog(@"Error when connecting. %i", result);
    }
    return result;
}

-(int) listBlocksOfType: (int) blockType {
    int result;
    
    TS7BlocksOfType blocksOfType;
    int count = 0x2000; //Max block count
    result = Cli_ListBlocksOfType(client, blockType, &blocksOfType, &count);
    
    if (result == 0) {
        for (int i = 0; i < count; i++) {
            NSLog(@"%i", blocksOfType[i]);
        }
    }
    else {
        NSLog(@"Failed to get blocks, error: %i", result);
    }
    
    return result;
}

-(int) disconnect {
    int result;
    result = Cli_Disconnect(client);
    return result;
}

-(int) readInputsStartingAtByte: (int) start withLength: (int) length {
    int result;
    //result = Cli_EBRead(client, start, length, void)
    return result;
}

-(int) listBlockCounts {
    
    TS7BlocksList blockList;
    int result = Cli_ListBlocks(client, &blockList);
    
    if (result == 0) {
        NSLog(@"OB Count: %i", blockList.OBCount);
        NSLog(@"DB Count: %i", blockList.DBCount);
        NSLog(@"FC Count: %i", blockList.FCCount);
        NSLog(@"FB Count: %i", blockList.FBCount);
        NSLog(@"SFC Count: %i", blockList.SFCCount);
        NSLog(@"SFB Count: %i", blockList.SFBCount);
        NSLog(@"SDB Count: %i", blockList.SDBCount);
    }
    else {
        NSLog(@"Failed to list blocks, error: %i", result);
    }
    if (blockList.OBCount > 0)  {
        NSLog(@"OB");
        [self listBlocksOfType: Block_OB];
    }
    if (blockList.DBCount > 0) {
        NSLog(@"DB");
        [self listBlocksOfType: Block_DB];
    }
    if (blockList.FCCount > 0) {
        NSLog(@"FC");
        [self listBlocksOfType: Block_FC];
    }
    if (blockList.FBCount > 0) {
        NSLog(@"FB");
        [self listBlocksOfType: Block_FB];
    }
    
    return result;
}

@end
