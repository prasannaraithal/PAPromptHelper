//
//  PAPromptHelper.m
//  PAPromptController
//
//  Created by Prasanna on 29/10/15.
//  Copyright © 2015 Prasanna. All rights reserved.
//

#import "PAPromptHelper.h"
#import <UIKit/UIKit.h>

// Returns the main queue
#define GET_ASYNC_MAIN_QUEUE(...) dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ })

// Set the default buttons index
static NSUInteger  kPACancelButtonIndex = 0;
static NSUInteger  kPADestructiveButtonIndex =  1;
static NSUInteger  kPAOtherButtonStartIndex =  2;

@interface PAPromptHelper ()

@property (nonatomic, copy) PAPromptHelperCompletionBlock completionBlock;
@property (nonatomic, strong) id owner;

- (instancetype)initWithUserPromptIn:(id)instance withTitle:(NSString *)title
                message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
                destructiveButtonTitle:(NSString *)descrutiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(UIAlertControllerStyle)style completionBlock:(PAPromptHelperCompletionBlock)completionBlock;


@end

@implementation PAPromptHelper

+ (instancetype)showAlertViewIn:(id)instance withTitle:(NSString *)title
                        message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
                        otherButtonTitles:(NSArray *)otherButtonTitles completionBlock:(PAPromptHelperCompletionBlock)completionBlock
{
    
    return [[self alloc] initWithUserPromptIn:instance withTitle:title message:message cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles style:UIAlertControllerStyleAlert completionBlock:completionBlock];
}

+ (instancetype)showActionSheetIn:(id)instance withTitle:(NSString *)title
                          message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle
                              otherButtonTitles:(NSArray *)otherButtonTitles completionBlock:(PAPromptHelperCompletionBlock)completionBlock
{
    
    return [[self alloc] initWithUserPromptIn:instance withTitle:title message:message cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles style:UIAlertControllerStyleActionSheet completionBlock:completionBlock];
}

- (instancetype)initWithUserPromptIn:(id)instance withTitle:(NSString *)title
                             message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)descrutiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles style:(UIAlertControllerStyle)style completionBlock:(PAPromptHelperCompletionBlock)completionBlock
{
    if (self = [super init]) {
       
        _completionBlock = [completionBlock copy];
        _owner = instance;
        
       
        // Create the instance of UIAlertController
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
        
        if (cancelButtonTitle != nil) {
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                   style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                           {
                                               [self handleCompletionBlock:kPACancelButtonIndex];
                                               
                                           }];
            // Add cancel event
            [alertController addAction:cancelAction];
        }
        
        if (descrutiveButtonTitle != nil) {
            UIAlertAction *descrutiveAction = [UIAlertAction actionWithTitle:descrutiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
                                           {
                                               
                                               [self handleCompletionBlock:kPADestructiveButtonIndex];
                                               
                                            }];
            // Add destructive event
            [alertController addAction:descrutiveAction];
        }
        
        // Add other button event.
        NSUInteger otherButtonIndex = kPAOtherButtonStartIndex;
        for (NSString *otherButtonTitle in otherButtonTitles)
        {
            UIAlertAction *otherButtonAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                                  style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                          {

                                              [self handleCompletionBlock:otherButtonIndex];
                                           
                                          }];
            
            [alertController addAction:otherButtonAction];
            otherButtonIndex += 1;
        }
        
        // Update the UI using main thread.
        GET_ASYNC_MAIN_QUEUE({
            // Always display the user prompt on the top of visible view controller.
            UIViewController *controller = [PAPromptHelper topMostVisibleViewController];
            
            // Present the alert view controller
            if(controller)
                [controller presentViewController:alertController animated:YES completion:nil];
            else
                NSLog(@"Something went wrong here:%s",__PRETTY_FUNCTION__);
        });
        
        
    }
    return self;
}

// Inform the caller
- (void)handleCompletionBlock:(NSUInteger)buttonIndex
{
    if (_completionBlock != nil) {
        if (_owner != nil) {
            _completionBlock(self, buttonIndex);
        }
    }
    _completionBlock = nil;
    _owner = nil;
}

// Returns the topmost view controller
+ (UIViewController *)topMostVisibleViewController
{
    UIViewController *topMostViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *lastController;
    
    while (topMostViewController.presentedViewController) {
        
        // Check whether the presentedViewController is already a UIAlertController
        if ([topMostViewController.presentedViewController isKindOfClass:[UIAlertController class]]) {
            return lastController;
        }
        
        lastController = topMostViewController.presentedViewController;
        topMostViewController = topMostViewController.presentedViewController;
    }
    
    return topMostViewController;
}

@end
