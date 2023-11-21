//
//  ShadowModule.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/8.
//

#import "ShadowModule.h"
#import <QuartzCore/QuartzCore.h>
@implementation ShadowModule
+ (void)addShadowToView:(UIView *)view withColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius blur:(CGFloat)blur spread:(CGFloat)spread {
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = offset;
    view.layer.shadowOpacity = opacity;
    view.layer.shadowRadius = radius;

    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectInset(view.bounds, -spread, -spread)];
    view.layer.shadowPath = shadowPath.CGPath;
    
    // 設定陰影的模糊度
    view.layer.shadowRadius = blur;
}

@end
