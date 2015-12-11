//
//  LadderBuilder.h
//  wordLadderRD
//
//  Created by lgong on 12/11/15.
//  Copyright © 2015 Liam Thomas Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PathQueue.h"
#import "StrinGraph.h"

@interface LadderBuilder : NSObject

@property StrinGraph* graph;

-(id)initWithArray:(NSArray*) wordArray;

-(id)initWithFileName:(NSString*) fileName;
-(id)initWithGraphDict:(NSDictionary*) dict;

-(NSArray*) ladderFrom:(NSString*) word1 toWord: (NSString*) word1;

@end
