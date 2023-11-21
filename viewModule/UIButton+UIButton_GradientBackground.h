//
//  UIButton+UIButton_GradientBackground.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//從上到下
    GradientTypeLeftToRight = 1,//從左到右
};
@interface UIButton (UIButton_GradientBackground)

- (void)setGradientBackgroundFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor  direction:(GradientType)direction;

- (void) addShadowColor:(UIColor *)shadowColor;

- (void) addImageIcon:(UIImage*) iconImage;
@end

NS_ASSUME_NONNULL_END
