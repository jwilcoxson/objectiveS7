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
            [s7 listBlockCountsWithError: &e];
            [s7 disconnect];
        }
        else {
            NSLog(@"Couldn't connect to server");
        }
        
    }
    return 0;
}
