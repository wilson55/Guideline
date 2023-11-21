//
//  UIButton+GradientBackground.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/7.
//

#import "UIButton+UIButton_GradientBackground.h"

@implementation UIButton (UIButton_GradientBackground)

- (void)setGradientBackgroundFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor direction:(GradientType)direction {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    //起點和終點表示的座標系位置，(0,0)表示左上角，(1,1)表示右下角
    
//    switch (direction) {
//            case GradientTypeTopToBottom:
//            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
//            gradientLayer.endPoint = CGPointMake(0.0, 1.0);
//                break;
//            case GradientTypeLeftToRight:
//            gradientLayer.startPoint = CGPointMake(0.0, 0.0);
//            gradientLayer.endPoint = CGPointMake(1.0, 0.0);
//                break;
//            default:
//                break;
//        }
    
    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, NO, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    
    [self.layer addSublayer:gradientLayer];
}
-(void) addShadowColor:(UIColor *)shadowColor
{
    // 陰影效果
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.shadowRadius = 8.0;
    self.layer.shadowOpacity = 1.0;
}

-(void) addImageIcon:(UIImage *)iconImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    imageView.image = iconImage;
    [self addSubview:imageView];

    // 調整UIImageView的位置
    CGFloat imageWidth = imageView.frame.size.width;
    CGFloat buttonWidth = self.frame.size.width;
    CGFloat imageX = buttonWidth - imageWidth -10.0; // 右對齊
    imageView.frame = CGRectMake(imageX, 10.0, imageWidth, imageView.frame.size.height);
    
    // UIImageView到UIButton上
    [self addSubview:imageView];
   
}
@end
