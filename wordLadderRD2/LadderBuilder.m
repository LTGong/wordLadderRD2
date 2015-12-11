//
//  LadderBuilder.m
//  wordLadderRD
//
//  Created by lgong on 12/11/15.
//  Copyright © 2015 Liam Thomas Gong. All rights reserved.
//

#import "LadderBuilder.h"

@interface LadderBuilder()



@end

@implementation LadderBuilder

-(id)initWithArray:(NSArray*) wordArray{
    self = [super init];
    if (self) {
        StrinGraph* graph = [[StrinGraph alloc] initWithVertexArray: wordArray];
        [self populateGraph:graph from:[self binDictFrom:wordArray]];
        self.graph = graph;
    }
    return self;
}

-(id)initWithFileName:(NSString*) fileName{
    
    NSString *pathstr = [[NSBundle mainBundle] pathForResource: fileName ofType: @"txt"];
    NSString *contStr = [NSString stringWithContentsOfFile:pathstr encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [contStr componentsSeparatedByString:@"\r\n"];
    
    NSArray* fourLetterLines = [lines filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSString* line, NSDictionary *bindings) {
        return line.length == 4;
    }]];
    
    
    NSDate *methodStart = [NSDate date];
    
    self = [[LadderBuilder alloc] initWithArray:fourLetterLines];
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime);
    
    return self;
}

-(id)initWithGraphDict:(NSDictionary*) dict{
    self = [super init];
    if (self) {
        self.graph = [[StrinGraph alloc] initWithStringDict:dict];
    }
    return self;
}

-(NSDictionary*)binDictFrom:(NSArray*)wordArr{
    NSMutableDictionary* binDict = [[NSMutableDictionary alloc] init];
    for(NSString * str in wordArr){
        //if([str length] == len){
            //Add to buckets
        for(int i = 0; i < 4; i++){
            NSString * bucketName = [[[str substringToIndex:i]stringByAppendingString:@"_"] stringByAppendingString:[str substringFromIndex:i + 1]];
            NSMutableArray<NSString *> * arr = [binDict objectForKey:bucketName];
            if(arr != nil){
                [arr addObject:str];
            }
            else{
                arr = [[NSMutableArray alloc] init];
                [arr addObject:str];
                [binDict setObject:arr forKey:bucketName];
            }
            //}
        }
    }
    return binDict;
}

/*

-(NSDictionary*)binDictFrom:(NSArray*)wordArr{
    NSMutableDictionary* binDict = [[NSMutableDictionary alloc] init];
    for (NSString* word in wordArr){
        [self add: word to:binDict];
    }
    return binDict;
}


-(void)add: (NSString*)word to: (NSMutableDictionary*) binDict{
    for (NSString* binKey in [self binArrayForWord:word]){
        if(![binDict.allKeys containsObject:binKey]){
            binDict[binKey] = @[word];
        }else{
            binDict[binKey] = [binDict[binKey] arrayByAddingObject:word];
        }
    }
}

-(NSArray*)binArrayForWord: (NSString*) word{
    //NSMutableArray* charArray = [[NSMutableArray alloc]init];
    NSMutableArray* binArray = [[NSMutableArray alloc]init];
    NSArray* charArray = [self characterArrayFromString:word];
    for (int underlineIndex = 0; underlineIndex < charArray.count; underlineIndex++) {
        NSString* binStr = @"";
        for (int characterIndex = 0; characterIndex<charArray.count; characterIndex ++) {
            NSString* currentCharacter = charArray[characterIndex];
            if (characterIndex == underlineIndex) {
                currentCharacter = @"_";
            }
            binStr = [binStr stringByAppendingString:currentCharacter];
        }
        [binArray addObject:binStr];
    }
    return binArray;
}

-(NSArray*)characterArrayFromString: (NSString*) str{
    NSMutableArray* result = [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index < str.length; index++) {
        NSString* charStr = [NSString stringWithFormat:@"%c",[str characterAtIndex:index]];
        [result addObject:charStr];
    }
    return result;
}
 */

-(void) populateGraph: (StrinGraph*) graph from:(NSDictionary*)binDict{
    for (NSString* binKey in [binDict allKeys]){
        NSArray* bin = binDict[binKey];
        for (NSString* str1 in bin){
            for (NSString* str2 in bin){
                if (! [str1 isEqualToString:str2]) {
                    [graph connect:str1 with:str2];
                }
            }
        }
    }
}

-(NSArray*) ladderFrom:(NSString*) word1 toWord: (NSString*) word2{
    
    NSMutableSet* traversed = [[NSMutableSet alloc] init];
    
    if ([self.graph contains:word1] && [self.graph contains:word2]) {
        
        PathQueue* q = [[PathQueue alloc] init];
        [q enqueue:@[word1]];
        
        while (! [q isEmpty]) {
            NSArray* currentPath = [q dequeue];
            
            for (NSString* connectedWord in [self.graph getVerticesLinkedTo:[currentPath lastObject]]) {
                if ([connectedWord isEqualToString:word2]) {
                    return [currentPath arrayByAddingObject:word2];
                }
                
                if (! [traversed containsObject:connectedWord]) {
                    [q enqueue:[currentPath arrayByAddingObject:connectedWord]];
                    [traversed addObject:connectedWord];
                }
            }
        }
    }
    
    return nil;
    
}

@end
