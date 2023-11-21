//
//  UIButton+Badge.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/8.
//

#import "UIButton+Badge.h"

@implementation UIButton (Badge)
- (void)addBadgeLabelWithText:(NSString *)text {
    UILabel *badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, 0, 20, 18)];
    UIColor *badgeColor = [UIColor colorWithRed:249.0/255.0 green:178.0/255.0 blue:220.0/255.0 alpha:1.0];
    badgeLabel.backgroundColor = badgeColor;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.font = [UIFont systemFontOfSize:12];
    badgeLabel.layer.cornerRadius = 10; // 將高度的一半作為半徑，使其成為圓形
    badgeLabel.layer.masksToBounds = YES;
    badgeLabel.text = text;
    [self addSubview:badgeLabel];
}

- (void)setUnderlineWithColor:(UIColor *)color andOffset:(CGFloat)offset{
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    
    [attributedTitle addAttribute:NSUnderlineColorAttributeName value:@(NSUnderlineStyleThick) range:NSMakeRange(0, attributedTitle.length)];
    // 添加底线颜色
    [attributedTitle addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:
     (NSRange){0, [attributedTitle length] }];
        
    [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
}

@end
