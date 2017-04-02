//
//  ViewController.m
//  TestApp
//
//  Created by Alexandru Boruz on 4/2/17.
//  Copyright © 2017 company. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.circleView.backgroundColor = [UIColor blueColor];
	self.circleView.layer.cornerRadius = self.circleView.frame.size.width / 2;
	self.circleView.layer.shouldRasterize = YES;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
