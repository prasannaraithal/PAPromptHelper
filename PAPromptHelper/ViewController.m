//
//  ViewController.m
//  PAPromptHelper
//
//  Created by Prasanna on 05/11/15.
//  Copyright © 2015 Prasanna. All rights reserved.
//

#import "ViewController.h"
#import "PAPromptHelper.h"

#define BUTTON_WIDTH 150.0f
#define BUTTON_HEIGHT 55.0f
#define BUTTON_PADDING 20.0f

@interface ViewController ()

@property (nonatomic, strong) UIButton *alertViewButton;
@property (nonatomic, strong) UIButton *actionSheetButton;

@end

@implementation ViewController

#pragma mark - View life cycles
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Show buttons
    _alertViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _alertViewButton.frame = CGRectZero;
    [_alertViewButton setTitle:@"Show AlertView!" forState:UIControlStateNormal];
    [_alertViewButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_alertViewButton];
    
    _actionSheetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _actionSheetButton.frame = CGRectZero;
    [_actionSheetButton setTitle:@"Show ActionSheet!" forState:UIControlStateNormal];
    [_actionSheetButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_actionSheetButton];
}
- (void)viewDidLayoutSubviews
{
    CGRect bounds = self.view.bounds;
    _alertViewButton.frame = (CGRect){
        .origin.x = CGRectGetMidX(bounds) - BUTTON_WIDTH/2,
        .origin.y = CGRectGetMidY(bounds) - BUTTON_HEIGHT/2 - BUTTON_PADDING,
        .size.width = BUTTON_WIDTH,
        .size.height = BUTTON_HEIGHT,
    };
    
    _actionSheetButton.frame = (CGRect){
        .origin.x = CGRectGetMidX(bounds) - BUTTON_WIDTH/2,
        .origin.y = CGRectGetMidY(bounds) - BUTTON_HEIGHT/2 + BUTTON_PADDING,
        .size.width = BUTTON_WIDTH,
        .size.height = BUTTON_HEIGHT,
    };
}

#pragma mark - Button Event
- (IBAction)buttonTapped:(id)sender
{
    if (sender == _alertViewButton) {
        
        // Display the AlertView
        [PAPromptHelper showAlertViewIn:self withTitle:@"Hi there" message:@"This is alert view" cancelButtonTitle:@"I Know" otherButtonTitles:nil completionBlock:^(PAPromptHelper *prompt, NSUInteger buttonIndex){
            NSLog(@"Button index = %lu",(unsigned long)buttonIndex);
        }];
    }
    else
    {
        // Display the ActionSheet
        [PAPromptHelper showActionSheetIn:self withTitle:@"Hi there" message:@"This is action sheet" cancelButtonTitle:@"I Know" destructiveButtonTitle:@"Cancel" otherButtonTitles:@[@"First button",@"Second button"] completionBlock:^(PAPromptHelper *prompt, NSUInteger buttonIndex){
            NSLog(@"Button index = %lu",(unsigned long)buttonIndex);
        }];
    }
}
#pragma mark
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
