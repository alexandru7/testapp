//
//  ViewController.m
//  TestApp
//
//  Created by Alexandru Boruz on 4/2/17.
//  Copyright © 2017 company. All rights reserved.
//

#import "ViewController.h"

#define MINIMUM_PRESS_DURATION 1.0
#define NUMBER_OF_TRIALS 3

@interface ViewController () {
	UILongPressGestureRecognizer *longPressRecognizer;
	UITapGestureRecognizer *tapRecognizer;
	NSDate *startTime;
	NSMutableArray *timesArray;
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
	
	timesArray = [[NSMutableArray alloc] init];
	
	self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
	self.circleView.layer.shouldRasterize = YES;
	
	[self setCircleViewToInitialState];
}

#pragma mark - UI State methods

- (void)setCircleViewToInitialState {
	self.circleView.backgroundColor = [UIColor blueColor];
	tapRecognizer.enabled = NO;
	
	startTime = nil;
	
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
	//make sure the delay si between 3 to 7 seconds
	long timerDelay = arc4random_uniform(4) + 3;
	
	self.actionButton.enabled = NO;
	
	[NSTimer scheduledTimerWithTimeInterval:timerDelay repeats:NO block:^(NSTimer * _Nonnull timer) {
		[self setCircleViewToInteractiveState];
		
		startTime = [NSDate date];
	}];
}

- (void)circleTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
	if (timesArray == nil) {
		timesArray = [[NSMutableArray alloc] init];
	}
	
	if (startTime) {
		NSNumber *time = [NSNumber numberWithDouble:(-1 * [startTime timeIntervalSinceNow])];
		NSLog(@"Added time: %@", time);
		[timesArray addObject:time];
		self.instructionsLabel.text = NSLocalizedString(@"Repeat the trial", nil);
		
		if ([timesArray count] >= NUMBER_OF_TRIALS) {
			self.resultsTextView.text = [self getJSONTextForNumbersArray:timesArray];
			self.instructionsLabel.text = @"";
			
			timesArray = [[NSMutableArray alloc] init];
		}
	}
	
	[self setCircleViewToInitialState];
}

#pragma mark - Helpers

- (NSString*)getJSONTextForNumbersArray:(NSArray *)numbersArray {
	NSNumber *average = [NSNumber numberWithDouble:[self getAverageFromNumbersArray:timesArray]];
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
						  timesArray, @"times",
						  average, @"average", nil];
	
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
	return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
