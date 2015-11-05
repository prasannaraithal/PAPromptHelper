//
//  PAPromptHelper.h
//  PAPromptController
//
//  Created by Prasanna on 29/10/15.
//  Copyright © 2015 Prasanna. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PAPromptHelper;

typedef void (^PAPromptHelperCompletionBlock)(PAPromptHelper *prompt, NSUInteger buttonIndex);

@interface PAPromptHelper : NSObject

+ (instancetype)showAlertViewIn:(id)instance withTitle:(NSString *)title
                message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
                otherButtonTitles:(NSArray *)otherButtonTitles completionBlock:(PAPromptHelperCompletionBlock)completionBlock;

+ (instancetype)showActionSheetIn:(id)instance withTitle:(NSString *)title
                          message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle
                    otherButtonTitles:(NSArray *)otherButtonTitles completionBlock:(PAPromptHelperCompletionBlock)completionBlock;
@end
