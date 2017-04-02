//
//  ViewController.m
//  TestApp
//
//  Created by Alexandru Boruz on 4/2/17.
//  Copyright © 2017 company. All rights reserved.
//

#import "ViewController.h"

#define MINIMUM_PRESS_DURATION 1.0

@interface ViewController () {
	UILongPressGestureRecognizer *longPressRecognizer;
	UITapGestureRecognizer *tapRecognizer;
	NSDate *startTime;
}

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
	[longPressRecognizer setMinimumPressDuration:MINIMUM_PRESS_DURATION];
	[self.actionButton addGestureRecognizer:longPressRecognizer];
	
	tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleTapAction:)];
	
	self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
	self.circleView.layer.shouldRasterize = YES;
	
	[self setCircleViewToInitialState];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
	//make sure the delay si between 3 to 7 seconds
	long timerDelay = arc4random_uniform(4) + 3;
	
	[NSTimer timerWithTimeInterval:timerDelay repeats:NO block:^(NSTimer * _Nonnull timer) {
		[self setCircleViewToInteractiveState];
		self.instructionsLabel.text = NSLocalizedString(@"Tap the green circle", nil);
		
		startTime = [NSDate date];
	}];
}

- (void)circleTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
	
}

- (void)setCircleViewToInitialState {
	self.circleView.backgroundColor = [UIColor blueColor];
	self.circleView.userInteractionEnabled = NO;
	[self.circleView removeGestureRecognizer:tapRecognizer];
	
	startTime = nil;
}

- (void)setCircleViewToInteractiveState {
	self.circleView.backgroundColor = [UIColor greenColor];
	self.circleView.userInteractionEnabled = YES;
	[self.circleView addGestureRecognizer:tapRecognizer];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
