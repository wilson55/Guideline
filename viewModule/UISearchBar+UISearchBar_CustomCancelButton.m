//
//  UISearchBar+UISearchBar_CustomCancelButton.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/7.
//

#import "UISearchBar+UISearchBar_CustomCancelButton.h"

@implementation UISearchBar (UISearchBar_CustomCancelButton)
- (void)changeCustomCancelButton {
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton *)view;
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}
@end
