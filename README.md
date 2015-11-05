###Usage:
Include both PAPromptHelper.h/.m and #import"PAPromptHelper.h"

Requirements:
<ul>
<li>ARC
<li>iOS8 or later
</ul>

####Show AlertView:
```
[PAPromptHelper showAlertViewIn:self withTitle:@"Hi there" message:@"This is alert view" cancelButtonTitle:@"I Know" otherButtonTitles:nil completionBlock:^(PAPromptHelper *prompt, NSUInteger buttonIndex){
            NSLog(@"Button index = %lu",(unsigned long)buttonIndex);
        }];
```
####Show ActionSheet:
```
[PAPromptHelper showActionSheetIn:self withTitle:@"Hi there" message:@"This is action sheet" cancelButtonTitle:@"I Know" destructiveButtonTitle:@"Cancel" otherButtonTitles:@[@"First button",@"Second button"] completionBlock:^(PAPromptHelper *prompt, NSUInteger buttonIndex){
            NSLog(@"Button index = %lu",(unsigned long)buttonIndex);
        }];
        
