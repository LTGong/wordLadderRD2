//
//  StrinGraph.m
//  wordLadderRD
//
//  Created by lgong on 12/11/15.
//  Copyright © 2015 Liam Thomas Gong. All rights reserved.
//

#import "StrinGraph.h"

@interface StrinGraph()

@property NSMutableDictionary* strDict;

@end

@implementation StrinGraph

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id)initWithVertexArray:(NSArray*) vertexArray{
    self = [[StrinGraph alloc] init];
    for (NSString* vert in vertexArray){
        [self addVertex:vert];
    }
    return self;
}

-(id)initWithStringDict:(NSDictionary*) strDict{
    self = [[StrinGraph alloc] init];
    self.strDict = [strDict mutableCopy];
    return self;
}

/*
*/

-(void) addVertex:(NSString*) vertex{
    if (![self.strDict.allKeys containsObject:vertex]) {
        self.strDict[vertex] = [[NSMutableSet alloc] init];
    }
}

-(void) connect:(NSString*) vert1 with:(NSString*) vert2{
    self.strDict[vert1] = [self.strDict[vert1] setByAddingObject:vert2];
    self.strDict[vert2] = [self.strDict[vert2] setByAddingObject:vert1];
}

-(NSArray*)getVerticesLinkedTo:(NSString*) vertex{
    if ([self contains:vertex]) {
        return [self.strDict[vertex] allObjects];
    }else{
        return nil;
    }
}

-(NSArray*) getAllVertices{
    return self.strDict.allKeys;
}

-(BOOL) contains: (NSString*) vertex{
    return [self.strDict.allKeys containsObject:vertex];
}

@end
