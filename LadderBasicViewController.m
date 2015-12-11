//
//  LadderBasicViewController.m
//  wordLadderRD2
//
//  Created by lgong on 12/11/15.
//  Copyright © 2015 Liam Thomas Gong. All rights reserved.
//

#import "LadderBasicViewController.h"
#import "LadderBuilder.h"

@interface LadderBasicViewController ()<UITextFieldDelegate>

@property LadderBuilder* lb;

@property (strong, nonatomic) IBOutlet UITextView *output;
@property (strong, nonatomic) IBOutlet UILabel *stepCount;

@property (strong, nonatomic) IBOutlet UITextField *startField;
@property (strong, nonatomic) IBOutlet UITextField *endField;


@end

@implementation LadderBasicViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDelegates];
    
    self.lb = [[LadderBuilder alloc] initWithFileName:@"ScrabbleDict"];

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark: delegation

-(void) setDelegates{
    self.startField.delegate = self;
    self.endField.delegate = self;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark: actions

- (IBAction)editingChanged:(UITextField*)sender {
    NSLog(@"Editing changed");
    
    if ([self.lb.graph contains:sender.text]) {
        sender.textColor = [UIColor blueColor];
    }else{
        sender.textColor = [UIColor blackColor];
    }
    
    if (self.startField.textColor == [UIColor blueColor]&& self.endField.textColor == [UIColor blueColor]) {
        [self updateLadder];
    }else{
        self.output.text = @"Input two four-letter words";
    }
    
}



- (void)updateLadder {
    NSLog(@"refreshingWith %@ %@",self.startField.text,self.endField.text);
    
    NSDate *methodStart = [NSDate date];
    
    NSArray* ladderArray = [self.lb ladderFrom:self.startField.text toWord:self.endField.text];
    
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime);
    
    
    
    NSString* result = @"Error!";
    
    if (ladderArray) {
        result = @"";
        for (NSString* rung in ladderArray) {
            result = [result stringByAppendingString:[rung stringByAppendingString:@"\n"]];
        }
    }
    
    self.stepCount.text = [NSString stringWithFormat:@"%lu-rung ladder.",(unsigned long)ladderArray.count-1];
    self.output.text = result;
}

@end
