//
//  InviteTableViewCell.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/5.
//

#import "InviteTableViewCell.h"

@implementation InviteTableViewCell

-(void) setFrame:(CGRect)frame
{
    frame.origin.x +=30.0;
    [self.friendsAgree setTitle:@"" forState:UIControlStateNormal];
    [self.friendsDelete setTitle:@"" forState:UIControlStateNormal];
    [super setFrame:frame];
}

-(void) changeInterval:(CGRect)frame
{
    
}
-(void) resetInterval:(CGRect)frame
{
   
}

-(void) addShadow
{
    // 設定陰影顏色
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 設定陰影偏移量
    self.layer.shadowOffset = CGSizeMake(0, 4);
    // 設定陰影不透明度
    self.layer.shadowOpacity = 0.5;
    // 設定陰影半徑
    self.layer.shadowRadius = 2.0;
    // 設定陰影的模糊度
    self.layer.shadowRadius = 4.0;
    // 設定陰影的擴散度
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (IBAction)friendsAgreeButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(friendsAgreeButtonTappedAtIndex:)]) {
        [self.delegate friendsAgreeButtonTappedAtIndex:self.rowIndex];
    }
}

//TODO: Cell的屬性和內容
- (void)setCellDataWithName:(NSString *)name avatarImage:(NSString*) imageString{
    NSLog(@"naem:%@ image:%@ ",name,imageString);
    self.freiendIName.text = name;
    if (imageString == nil || [imageString isEqualToString:@""]) {
        self.freiendImage.image = [UIImage imageNamed:@"imgFriendsFemaleDefault"];
    } else {
        
        self.freiendImage.image = [UIImage imageNamed:imageString];
    }
}

- (IBAction)friendsDeleteButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(friendsDeleteButtonTappedAtIndex:)]) {
        [self.delegate friendsDeleteButtonTappedAtIndex:self.rowIndex];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
