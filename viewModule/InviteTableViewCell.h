//
//  InviteTableViewCell.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/5.
//

#import <UIKit/UIKit.h>
#import "CircularImageView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol InviteTableViewCellDelegate <NSObject>
- (void)friendsAgreeButtonTappedAtIndex:(NSInteger)index;
- (void)friendsDeleteButtonTappedAtIndex:(NSInteger)index;

@end
@interface InviteTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet CircularImageView* freiendImage;
@property (nonatomic, weak) IBOutlet UILabel* freiendIName; //邀請好友姓名
@property (nonatomic, weak) IBOutlet UIButton* friendsAgree;
@property (nonatomic, weak) IBOutlet UIButton* friendsDelete;
@property (nonatomic, weak) id<InviteTableViewCellDelegate> delegate;
@property (nonatomic) NSInteger rowIndex;
@property (nonatomic) CGRect orgineFrame;
- (void)setCellDataWithName:(NSString *)name avatarImage:(NSString*) imageString;
-(void) addShadow;

-(void) changeInterval:(CGRect)frame;
-(void) resetInterval:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
