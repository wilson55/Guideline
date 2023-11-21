//
//  FriendTableViewCell.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/5.
//

#import <UIKit/UIKit.h>
#import "CircularImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FriendTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView* freiendIsTop;//是否出現星星
//0:邀請送出, 1:已完成 2:邀請中, 參考(註解)
@property (nonatomic, weak) IBOutlet UIImageView* freiendStatus;
@property (nonatomic, weak) IBOutlet UILabel* freiendId;//好友id
@property (nonatomic, weak) IBOutlet CircularImageView* freiendImage;
@property (nonatomic, weak) IBOutlet UILabel* freiendIName; //好友姓名
@property (nonatomic, weak) IBOutlet UILabel* updateDate; //資料更新時間
@property (nonatomic, weak) IBOutlet UIButton* transferAccounts;
@property (nonatomic, weak) IBOutlet UILabel* invite; //𨘋請中或 ...

- (void)setCellDataWithName:(NSString *)name status:(NSString *)status isTop:(NSString *) isTop;
-(void) addShadow;
@end

NS_ASSUME_NONNULL_END
