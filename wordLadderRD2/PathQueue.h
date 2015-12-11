//
//  PathQueue.h
//  wordLadderRD
//
//  Created by lgong on 12/11/15.
//  Copyright © 2015 Liam Thomas Gong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathQueue : NSObject

-(void) enqueue: (NSArray*) path;
-(NSArray*) dequeue;
-(BOOL)isEmpty;
-(int) size;


@end
