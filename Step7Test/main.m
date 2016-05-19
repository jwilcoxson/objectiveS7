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
        
        [s7 connectTo:@"10.0.0.16" rack:0 slot:2 withError: &e];

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
                    
                    a = [s7 listBlocksOfType:Block_OB withError:&e];
                    
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
                
                    a = [s7 listBlocksOfType:Block_DB withError:&e];
                    
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
                    
                    a = [s7 listBlocksOfType:Block_FC withError:&e];
                    
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
                    
                    a = [s7 listBlocksOfType:Block_FB withError:&e];
                    
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
                    
                    a = [s7 listBlocksOfType:Block_SFC withError:&e];
                    
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
                    
                    a = [s7 listBlocksOfType:Block_SFB withError:&e];
                    
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
            
            NSArray *inputs = [s7 readInputsStartingAtByte:0 withByteLength:2 withError:&e];
            
            if (inputs != nil) {
                NSLog(@"Read inputs successful");
                for (int i = 0; i < [inputs count]; i++) {
                    NSLog(@"IB%d: %d", i, [(S7Byte*)inputs[i] getValue]);
                    for (int j = 0; j < 8; j++) {
                        NSLog(@"I%d.%d: %d", i, j, [(S7Byte*)inputs[i] getBit:j]);
                    }
                }
                
            }
            else {
                NSLog(@"Error reading inputs");
            }
            
            NSArray *outputs = [s7 readOutputsStartingAtByte:0 withByteLength:2 withError:&e];
            
            if (outputs != nil) {
                NSLog(@"Read outputs successful");
                for (int i = 0; i < [outputs count]; i++) {
                    NSLog(@"QB%d: %d", i, [(S7Byte*)outputs[i] getValue]);
                    for (int j = 0; j < 8; j++) {
                        NSLog(@"Q%d.%d: %d", i, j, [(S7Byte*)outputs[i] getBit:j]);
                    }
                }

            }
            else {
                NSLog(@"Error reading outputs");
            }
            
            
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
