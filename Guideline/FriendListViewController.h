//
//  FriendListViewController.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import <UIKit/UIKit.h>
#import "InviteTableViewCell.h"
#import "CircularImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FriendListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,InviteTableViewCellDelegate>
{
    
    
}
@property (nonatomic) CGFloat tableViewHeight;


@property (nonatomic, weak) NSString* kokoName;
@property (nonatomic, weak) NSString* kokoId;
@property (nonatomic, weak) IBOutlet UIView* customerView;
@property (nonatomic, weak) IBOutlet CircularImageView* customerImage;
@property (nonatomic, weak) IBOutlet UIView* searchBarView;
@property (nonatomic, weak) IBOutlet UILabel* customerName;
@property (nonatomic, weak) IBOutlet UILabel* customerId;
@property (nonatomic, weak) IBOutlet UIButton* changeScene;
//好友過澽查詢
@property (nonatomic, weak) IBOutlet UISearchBar* searchBar;
//好友邀請中列表
@property (nonatomic, weak) IBOutlet UITableView* inviteTableView;
//好友列表
@property (nonatomic, weak) IBOutlet UITableView* tableView;

//顯示好友列表含邀請列表
@property (nonatomic, weak) IBOutlet UIButton* invitationSent;


//好友頁鍵
@property (nonatomic, weak) IBOutlet UIButton* frientsButton;
//聊天頁鍵
@property (nonatomic, weak) IBOutlet UIButton* chatButton;
@property (nonatomic, weak) IBOutlet UILabel* operation;

@end

NS_ASSUME_NONNULL_END
