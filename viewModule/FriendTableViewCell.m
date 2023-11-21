//
//  FriendTableViewCell.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/5.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.transferAccounts.layer.cornerRadius = 2.0;
    self.transferAccounts.layer.borderWidth = 2.0;
    self.transferAccounts.layer.borderColor = [UIColor colorWithRed:236.0/255.0 green:0.0/255.0 blue:140.0/255.0 alpha:1.0].CGColor;
    self.invite.layer.cornerRadius = 2.0;
    self.invite.layer.borderWidth = 2.0;
    self.invite.layer.borderColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0].CGColor;
}

-(void) setFrame:(CGRect)frame
{
    frame.origin.y += 10.0;
    frame.origin.x +=30.0;
    frame.size.height -= 8.0;
    frame.size.width -= 50.0;
    
    [super setFrame:frame];
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
    self.layer.shadowRadius = 16.0;
    // 設定陰影的擴散度
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

//TODO: Cell的屬性和內容
- (void)setCellDataWithName:(NSString *)name status:(NSString *)_status isTop:(NSString *) isTop{
    NSLog(@"naem:%@ status:%@ isTop:%@",name,_status,isTop);
    self.freiendIName.text = name;
    self.freiendStatus.hidden = YES;
    //顯示邀請中
    if([_status isEqualToString:@"0"] ){ //邀請送出的顯示:邀請中
        self.invite.hidden = YES;
    }else {
        self.invite.hidden = NO; //for  status=1,2
        if([_status isEqualToString:@"1"] ){
            self.invite.layer.borderColor = [UIColor clearColor].CGColor;
            self.invite.text = @"...";
        }else {
            float grey = 201.0/255.0;
            self.invite.layer.borderColor = [UIColor colorWithRed:grey green:grey blue:grey alpha:1.0].CGColor;
            self.invite.text = @"邀請中";
        }
    }
    //顯示星星
    if([isTop isEqualToString:@"1"]){
        self.freiendIsTop.hidden = NO; //顯星
    }else{
        self.freiendIsTop.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
