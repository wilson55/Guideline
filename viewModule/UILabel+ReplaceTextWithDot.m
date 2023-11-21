//
//  UILabel+ReplaceTextWithDot.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/9.
//

#import "UILabel+ReplaceTextWithDot.h"

@implementation UILabel (ReplaceTextWithDot)

- (void)replaceTextWithDotAndSetColor:(UIColor *)dotColor {
    NSString *originalText = self.text;

    if (originalText) {
        
        NSUInteger length = originalText.length;
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:originalText];
        NSAttributedString *circleString = [[NSAttributedString alloc] initWithString:@"\u25cf" attributes:@{ NSForegroundColorAttributeName: dotColor }];
        //●
        for (NSUInteger i = 0; i < length; i++) {
            [attrStr replaceCharactersInRange:NSMakeRange(i, 1) withAttributedString:circleString];
        }
        
        self.attributedText = attrStr;
    }
}
@end
