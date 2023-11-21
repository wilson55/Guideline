//
//  UIButton+Badge.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Badge)
- (void)addBadgeLabelWithText:(NSString *)text;

- (void)setUnderlineWithColor:(UIColor *)color andOffset:(CGFloat)offset;
@end

NS_ASSUME_NONNULL_END
