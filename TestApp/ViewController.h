//
//  ViewController.h
//  TestApp
//
//  Created by Alexandru Boruz on 4/2/17.
//  Copyright © 2017 company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextView *resultsTextView;
@property (nonatomic, weak) IBOutlet UIView *circleView;
@property (nonatomic, weak) IBOutlet UILabel *instructionsLabel;
@property (nonatomic, weak) IBOutlet UIButton *actionButton;

@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSMutableArray *timesArray;

- (void)circleTapAction:(UITapGestureRecognizer *)tapGestureRecognizer;

@end

