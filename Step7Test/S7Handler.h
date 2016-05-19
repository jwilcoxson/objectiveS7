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

@interface S7Handler : NSObject

-(void) connectTo: (NSString*) ipAddress rack: (int) rack slot: (int) slot withError: (NSError **) error;
-(void) disconnect;
-(NSArray*) listBlocksOfType: (int) blockType withError: (NSError **) error;
-(NSDictionary*) listBlockCountsWithError: (NSError **) error;
-(NSArray*) readInputsStartingAtByte: (int) start withLength: (int) length withError: (NSError **) error;

@end

#endif /* S7Handler_h */
