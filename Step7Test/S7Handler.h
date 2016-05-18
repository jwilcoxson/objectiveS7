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

-(int) connectTo: (NSString*) ipAddress rack: (int) rack slot: (int) slot;
-(int) disconnect;
-(int) listBlocksOfType: (int) blockType;
-(int) listBlockCounts;
-(int) readInputsStartingAtByte: (int) start withLength: (int) length;

@end

#endif /* S7Handler_h */
