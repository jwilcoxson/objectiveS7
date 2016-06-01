//
//  main.m
//  Step7Test
//
//  Created by Joe Wilcoxson on 5/17/16.
//  Copyright © 2016 Joe Wilcoxson. All rights reserved.
//

#import "main.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        S7Handler *s7 = [[S7Handler alloc] init];
        NSError *e;
        
        NSString *ipAddress = @"10.0.0.16";
        
        if (![ipAddress isValidIPAddress]) {
            NSLog(@"Invalid IP address");
            return 1;
        }
        
        [s7 connectTo:ipAddress rack:0 slot:2 error: &e];

        if (e == nil) {
            NSDictionary *d = [s7 listBlockCountsWithError: &e];
            if (d != nil) {
                NSLog(@"OB Count: %@", [d objectForKey:@"OB"]);
                NSLog(@"DB Count: %@", [d objectForKey:@"DB"]);
                NSLog(@"FC Count: %@", [d objectForKey:@"FC"]);
                NSLog(@"FB Count: %@", [d objectForKey:@"FB"]);
                NSLog(@"SFC Count: %@", [d objectForKey:@"SFC"]);
                NSLog(@"SFB Count: %@", [d objectForKey:@"SFB"]);
                
                NSArray *a;
                
                if ([[d objectForKey:@"OB"] integerValue] > 0) {
                    
                    a = [s7 listBlocksOfType:Block_OB error:&e];
                    
                    if (a != nil) {
                        for (int i = 0; i < [a count]; i++) {
                            NSLog(@"OB%@", [a objectAtIndex:i]);
                        }
                    }
                    else {
                        NSLog(@"Couldn't list OBs %ld", (long)e.code);
                    }
                    
                }
                
                if ([[d objectForKey:@"DB"] integerValue] > 0) {
                
                    a = [s7 listBlocksOfType:Block_DB error:&e];
                    
                    if (a != nil) {
                        for (int i = 0; i < [a count]; i++) {
                            NSLog(@"DB%@", [a objectAtIndex:i]);
                        }
                    }
                    else {
                        NSLog(@"Couldn't list DBs %ld", (long)e.code);
                    }
                }
                
                if ([[d objectForKey:@"FC"] integerValue] > 0) {
                    
                    a = [s7 listBlocksOfType:Block_FC error:&e];
                    
                    if (a != nil) {
                        for (int i = 0; i < [a count]; i++) {
                            NSLog(@"FC%@", [a objectAtIndex:i]);
                        }
                    }
                    else {
                        NSLog(@"Couldn't list FCs %ld", (long)e.code);
                    }
                }
                
                if ([[d objectForKey:@"FB"] integerValue] > 0) {
                    
                    a = [s7 listBlocksOfType:Block_FB error:&e];
                    
                    if (a != nil) {
                        for (int i = 0; i < [a count]; i++) {
                            NSLog(@"FB%@", [a objectAtIndex:i]);
                        }
                    }
                    else {
                        NSLog(@"Couldn't list FBs %ld", (long)e.code);
                    }
                }
                
                if ([[d objectForKey:@"SFC"] integerValue] > 0) {
                    
                    a = [s7 listBlocksOfType:Block_SFC error:&e];
                    
                    if (a != nil) {
                        for (int i = 0; i < [a count]; i++) {
                            NSLog(@"SFC%@", [a objectAtIndex:i]);
                        }
                    }
                    else {
                        NSLog(@"Couldn't list SFCs %ld", (long)e.code);
                    }
                }
                
                if ([[d objectForKey:@"SFB"] integerValue] > 0) {
                    
                    a = [s7 listBlocksOfType:Block_SFB error:&e];
                    
                    if (a != nil) {
                        for (int i = 0; i < [a count]; i++) {
                            NSLog(@"SFB%@", [a objectAtIndex:i]);
                        }
                    }
                    else {
                        NSLog(@"Couldn't list SFBs %ld", (long)e.code);
                    }
                }
                
            }
            else {
                NSLog(@"Error listing block counts");
            }
            
            NSData *inputs = [s7 readInputsStartingAtByte:0 byteLength:10 error:&e];
            
            if (inputs != nil) {
                NSLog(@"Read inputs successful");
                NSLog(@"%@", inputs);
                for (int i = 0; i < [inputs length]; i++) {
                    NSLog(@"IB%d = %d", i, [S7Data getByte:i inData:inputs]);
                    for (int j = 0; j < 8; j++) {
                        NSLog(@"I%d.%d = %d", i, j, [S7Data getBit:j fromByte:i inData:inputs]);
                    }
                }
            }
            else {
                NSLog(@"Error reading inputs");
            }
            
            NSData *outputs = [s7 readOutputsStartingAtByte:0 byteLength:10 error:&e];
            
            if (outputs != nil) {
                NSLog(@"Read outputs successful");
                NSLog(@"%@", outputs);
            }
            else {
                NSLog(@"Error reading outputs");
            }
            
            NSString *rs = [s7 getPlcModeWithError:&e];
            
            if (e == nil)
            {
                NSLog(@"PLC Mode: %@", rs);
            }
            else {
                NSLog(@"Error getting PLC status");
            }
            
            NSDictionary *dc = [s7 getPlcInfoWithError:&e];
            
            if (e == nil) {
                NSLog(@"%@", dc);
            }
            else {
                NSLog(@"Error getting PLC Info");
            }
            
            NSDictionary *oc = [s7 getPlcOrderCodeWithError:&e];
            
            if (e == nil) {
                NSLog(@"%@", oc);
            }
            else {
                NSLog(@"Error getting PLC Order Code");
            }

            [s7 addReadEntry:[[S7ReadEntry alloc] initIBReadEntryAtByte: 0]];
            [s7 addReadEntry:[[S7ReadEntry alloc] initIBReadEntryAtByte: 3]];
            [s7 addReadEntry:[[S7ReadEntry alloc] initIBReadEntryAtByte: 7]];
            
            [s7 calculateRead];
            [s7 executeRead];
            
            [s7 disconnectWithError: &e];
            
            if(e != nil) {
                NSLog(@"Error disconnecting");
            }
        }
        else {
            NSLog(@"Couldn't connect to server");
        }
        
    }
    return 0;
}
