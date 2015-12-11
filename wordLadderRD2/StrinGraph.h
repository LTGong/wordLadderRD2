//
//  StrinGraph.h
//  wordLadderRD
//
//  Created by lgong on 12/11/15.
//  Copyright © 2015 Liam Thomas Gong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrinGraph : NSObject

-(id) initWithVertexArray:(NSArray*) vertArray;
-(id)initWithStringDict:(NSDictionary*) strDict;

-(void) addVertex:(NSString*) vertex;
-(void) connect:(NSString*) vert1 with:(NSString*) vert2;
-(NSArray*)getVerticesLinkedTo:(NSString*) vertex;
-(NSArray*) getAllVertices;
-(BOOL) contains: (NSString*) vertex;


@end
