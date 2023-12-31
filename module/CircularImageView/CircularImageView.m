//
//  CircularImageView.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/8.
//

#import "CircularImageView.h"

@implementation CircularImageView
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 圓形罩板
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    self.layer.mask = maskLayer;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
