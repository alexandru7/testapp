//
//  TestAppUITests.m
//  TestAppUITests
//
//  Created by Alexandru Boruz on 4/2/17.
//  Copyright © 2017 company. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TestAppUITests : XCTestCase

@end

@implementation TestAppUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testActionButton {
	XCUIApplication *app = [[XCUIApplication alloc] init];
	XCUIElement *actionbuttonButton = app.buttons[@"actionButton"];
	
	[actionbuttonButton tap];
	XCTAssert(actionbuttonButton.enabled == YES, @"Button was not enabled after a tap");
	
	[actionbuttonButton pressForDuration:0.9];
	XCTAssert(actionbuttonButton.enabled == YES, @"Button was not enabled after 0.9 seconds");
	
	[actionbuttonButton pressForDuration:1.1];
	XCTAssert(actionbuttonButton.enabled == NO, @"Button was enabled after 1.1 seconds");
}

- (void)testCircle {
//	XCUIApplication *app = [[XCUIApplication alloc] init];
//	XCUIElement *actionbuttonButton = app.buttons[@"actionButton"];
//	XCUIElement *instructionsLabelElement = app.staticTexts[@"instructionsLabel"];
//	
//	[actionbuttonButton pressForDuration:1.1];
//	
//	sleep(7);
//	
//	XCTAssert([instructionsLabelElement.label isEqualToString: @"Tap the green circle"], @"The label had incorrect text");
}

@end
