//
//  TestAppTests.m
//  TestAppTests
//
//  Created by Alexandru Boruz on 4/2/17.
//  Copyright © 2017 company. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface TestAppTests : XCTestCase

@end

@implementation TestAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTrials {
	ViewController *vc = [[ViewController alloc] init];
	[vc viewDidLoad];
	for (int i = 1; i < 5; i++) {
		[self doTrialAfterDelay:i inViewController:vc];
		XCTAssert([vc.timesArray count] == i);
		
		int lastDelay = [[vc.timesArray objectAtIndex:(i-1)] intValue];
		
		XCTAssert(lastDelay == i);
	}
	
	//after the 5th trial the times array is cleared and results are displayed
	[self doTrialAfterDelay:1 inViewController:vc];
	XCTAssert([vc.timesArray count] == 0);
}

- (void)doTrialAfterDelay:(int)seconds inViewController:(ViewController *)vc {
	vc.startTime = [NSDate date];
	sleep(seconds);
	[vc circleTapAction:nil];
}

@end
