//
//  PathQueue.m
//  wordLadderRD
//
//  Created by lgong on 12/11/15.
//  Copyright © 2015 Liam Thomas Gong. All rights reserved.
//

#import "PathQueue.h"

@interface PathQueue()

@property NSMutableArray* list;

@end

@implementation PathQueue

#pragma mark: Initializer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.list = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark: accessors

-(void) enqueue: (NSArray*) path{
    [self.list addObject:path];
}

-(NSArray*) dequeue{
    NSArray* result = [self.list lastObject];
    [self.list removeLastObject];
    return result;
}

#pragma mark: properties

-(BOOL)isEmpty{
    return self.size == 0;
}

-(int) size{
    return (int) self.list.count;
}

@end
