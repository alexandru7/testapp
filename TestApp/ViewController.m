//
//  ViewController.m
//  TestApp
//
//  Created by Alexandru Boruz on 4/2/17.
//  Copyright © 2017 company. All rights reserved.
//

#import "ViewController.h"

#define MINIMUM_PRESS_DURATION 1.0
#define NUMBER_OF_TRIALS 5

@interface ViewController () {
	UILongPressGestureRecognizer *longPressRecognizer;
	UITapGestureRecognizer *tapRecognizer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
	[longPressRecognizer setMinimumPressDuration:MINIMUM_PRESS_DURATION];
	[self.actionButton addGestureRecognizer:longPressRecognizer];
	
	tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapAction:)];
	[self.circleView addGestureRecognizer:tapRecognizer];
	
	self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
	self.circleView.layer.shouldRasterize = YES;
	
	[self setCircleViewToInitialState];
}

#pragma mark - UI State methods

- (void)setCircleViewToInitialState {
	self.circleView.backgroundColor = [UIColor blueColor];
	tapRecognizer.enabled = NO;
	
	self.startTime = nil;
	
	self.actionButton.enabled = YES;
}

- (void)setCircleViewToInteractiveState {
	self.circleView.backgroundColor = [UIColor greenColor];
	tapRecognizer.enabled = YES;
	
	self.instructionsLabel.text = NSLocalizedString(@"Tap the green circle", nil);
	
	self.actionButton.enabled = NO;
}

#pragma mark - Actions


- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
	if (longPressGestureRecognizer && longPressGestureRecognizer.state == UIGestureRecognizerStateEnded) {
		//make sure the delay is between 3 to 7 seconds
		long timerDelay = arc4random_uniform(4) + 3;
		
		self.actionButton.enabled = NO;
		
		[NSTimer scheduledTimerWithTimeInterval:timerDelay target:self selector:@selector(startTrial:) userInfo:nil repeats:NO];
	}
}

- (void)startTrial:(NSTimer *)timer {
	[self setCircleViewToInteractiveState];
	
	self.startTime = [NSDate date];
}

- (void)circleTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
	if (self.startTime) {
		if (self.timesArray == nil) {
			self.timesArray = [[NSMutableArray alloc] init];
		}
		NSNumber *time = [NSNumber numberWithDouble:(-1 * [self.startTime timeIntervalSinceNow])];
		
		[self.timesArray addObject:time];
		self.instructionsLabel.text = NSLocalizedString(@"Repeat the trial", nil);
		
		if ([self.timesArray count] >= NUMBER_OF_TRIALS) {
			self.resultsTextView.text = [self getJSONTextForNumbersArray:self.timesArray];
			self.instructionsLabel.text = @"";
			[self.timesArray removeAllObjects];
		}
	}
	
	[self setCircleViewToInitialState];
}

#pragma mark - Helpers

- (NSString*)getJSONTextForNumbersArray:(NSArray *)numbersArray {
	NSString *result = @"";
	if (numbersArray) {
		NSNumber *average = [NSNumber numberWithDouble:[self getAverageFromNumbersArray:self.timesArray]];
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
							  self.timesArray, @"times",
							  average, @"average", nil];
		
		NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
		result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	}
	
	return result;
}

- (double)getAverageFromNumbersArray:(NSArray *)numbersArray {
	double average = 0.0;
	if (numbersArray && [numbersArray count] > 1) {
		double total = 0.0;
		for (NSNumber *time in numbersArray) {
			total += [time doubleValue];
		}
		average = (total / [numbersArray count]);
	}
	
	return average;
}


@end
