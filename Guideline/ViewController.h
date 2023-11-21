//
//  ViewController.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import <UIKit/UIKit.h>
#import "CircularImageView.h"
@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton*  addFriends;
@property (nonatomic, retain) IBOutlet UILabel* customerName;
@property (nonatomic, retain) IBOutlet UILabel* customerId;
@property (nonatomic, weak) IBOutlet CircularImageView* customerImage;
//好友頁鍵
@property (nonatomic, weak) IBOutlet UIButton* frientsButton;
//聊天頁鍵
@property (nonatomic, weak) IBOutlet UIButton* chatButton;
@property (nonatomic, weak) IBOutlet UILabel* operation;
- (IBAction)senderbuttonTapped:(UIButton *)sender;
@end

