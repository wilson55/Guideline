//
//  ShadowModule.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ShadowModule : NSObject
+ (void)addShadowToView:(UIView *)view withColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius blur:(CGFloat)blur spread:(CGFloat)spread;
@end

NS_ASSUME_NONNULL_END
