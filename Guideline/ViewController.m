//
//  ViewController.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import "ViewController.h"
#import "JsonModule.h"
#import "apiRequestModule.h"
#import "FriendListViewController.h"

#import "UIButton+UIButton_GradientBackground.h"
#import "UILabel+ReplaceTextWithDot.h"
#import "UIButton+Badge.h"
//顯示無好友畫面
@interface ViewController ()
{
    NSString* kokoName;
    NSString* kokoId;
    UIImage*  kokoImage;
    NSInteger segementIndex;
}
- (void)fetchDataFromAPI;
@end

@implementation ViewController

// TODO: 讀取使用者資料 => getJsonDataFromString
-(NSDictionary*) getJsonDataFromString{
    NSString *jsonString = @"{\"response\":[{\"name\":\"蔡國泰\",\"kokoid\":\"Mike\"}]}";
    
    return  [JsonModule parseJSONString:jsonString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    segementIndex =30001;
    [self chageAddFridendsStyle];
    //[self.view addSubview:gradientButton];
    // Do any additional setup after loading the view.
    //無好友頁面1-(1)
    [self getCustomerData];
    // 在視圖加載後執行API請求
    //[self fetchDataFromAPI];
    [self setFootButton];
}


// TODO: 經裡使用者登入後，後台回傳的已授權的(token）的使用者基本資料
-(void)getCustomerData{
    // 向後台API請求數據，取得傳回的數據
    // 這裡假設responseData是從API傳回的數據
    @autoreleasepool {
            //使用字串模式
            //NSDictionary *jsonDict = [self getJsonDataFromString];
            //使用檔案模式
        NSDictionary *jsonDict =  [JsonModule readJSONFromFile:@"main"];
            
            if (jsonDict) {
                NSArray *responseArray = jsonDict[@"response"];
                if (responseArray.count > 0) {
                    NSDictionary *firstItem = responseArray[0];
                    kokoName = firstItem[@"name"];
                    kokoId = firstItem[@"kokoid"];
                    NSString* imageString = firstItem[@"kokoImage"];
                    imageString = @"testImages1.jpeg";
                    if (imageString == nil || [imageString isEqualToString:@""]) {
                        kokoImage = [UIImage
                            imageNamed:@"imgFriendsFemaleDefault"];
                    } else {
                        kokoImage = [UIImage imageNamed:imageString];
                    }
                    self.customerImage.image = kokoImage;
                    NSLog(@"姓名：%@", kokoName);
                    NSLog(@"Kokoid：%@", kokoId);
                    self.customerName.text = kokoName;
                    self.customerId.text = kokoId;
                    [self.customerId replaceTextWithDotAndSetColor:[UIColor colorWithRed:236/255.0 green:0.0 blue:140/255.0 alpha:1.0]];
                  
                } else {
                    NSLog(@"JSON數據中沒有response數組或數組為空。");
                }
            }
        }
}

// TODO:取得客戶基本資料
-(int) getRequestFromApiURL{
    @autoreleasepool {
            [apiRequestModule fetchDataFromAPIWithCompletion:^(NSDictionary *responseData, NSError *error) {
                if (error) {
                    NSLog(@"API請求錯誤：%@", error.localizedDescription);
                } else {
                    NSLog(@"成功獲取數據：%@", responseData);
                    // 在這裡處理API回應數據
                }
            }];
            
            // 等待非同步請求完成
            [[NSRunLoop currentRunLoop] run];
        }
        return 0;
}
#pragma mark -  底端兩個按鍵：好友 聊天 上的brage ****************************
//TODO: 設置底端兩個按鍵
-(void)setFootButton
{
    //在按鈕上新增未讀取資訊數量標籤
    //[self.frientsButton addBadgeLabelWithText:@"2"];
    //[self.chatButton addBadgeLabelWithText:@"99+"];
    [self setUnderLine];
}

// TODO: 回應按鈕點擊事件
//好友按鈕點擊事件
- (IBAction)friendButtonTapped:(id)send {
    UIButton* button = (UIButton*)send;
    segementIndex = button.tag;
    NSLog(@"好友按鈕點擊事件");
    [self setUnderLine];
    //FIXME: 切換成好友列表tabelview
}
//TODO: 聊天按鈕點擊事件
- (IBAction)chatButtonTapped:(id)send {
    
    UIButton* button = (UIButton*)send;
    segementIndex = button.tag;
    NSLog(@"聊天按鈕點擊事件");
    [self setUnderLine];
    //FIXME: 切換成聊天列表tabelview
    
}

-(void) setUnderLine
{
    //好友按钮
    if(segementIndex == 30001){
        self.operation.frame= CGRectMake(40.0, 142.0, 20.0, 4.0);
    }else{
        self.operation.frame= CGRectMake(109.0, 142.0, 20.0, 4.0);
    }
}
- (void)fetchDataFromAPI {
    NSURL *apiURL = [NSURL URLWithString:@"https://api.example.com/your-api-endpoint"];
    
    [apiRequestModule fetchDataFromAPIWithURL:apiURL completion:^(NSDictionary *responseData, NSError *error) {
        if (error) {
            NSLog(@"API請求錯誤：%@", error.localizedDescription);
        } else {
            NSLog(@"成功獲取數據：%@", responseData);
            
            // 在這裡處理API回應數據，例如更新UI等操作
            // responseData 包含API的回應數據
        }
    }];
}

// TODO: 加入好友按鍵的樣式修改
-(void)chageAddFridendsStyle
{
    // 設置漸變背景色
    [self.addFriends setBackgroundImage:nil forState:UIControlStateNormal];
    UIColor* startColor = [UIColor colorWithRed:86.0/255.0 green:179.0/255.0 blue:11.0/255.0 alpha:1.0];
    UIColor* endColor = [UIColor colorWithRed:166.0/255.0 green:204.0/255.0 blue:66.0/255.0 alpha:1.0];
    [self.addFriends setGradientBackgroundFromColor:startColor toColor:endColor direction:GradientTypeLeftToRight];
        
    // 設置圆角
    self.addFriends.layer.cornerRadius = 25.0;
    self.addFriends.layer.masksToBounds = YES;

    // 設置陰影
    UIColor* shadowColor =  [UIColor colorWithRed:121.0/255.0 green:196.0/255.0 blue:24.0/255.0 alpha:0.4];
    [self.addFriends addShadowColor:shadowColor];
    
    // 設置 button image
    UIImage *imageFromAssets = [UIImage imageNamed:@"icAddFriendWhite"];
    if (!imageFromAssets) {
        NSLog(@"無法加載Assets中的image");
    }else {
        [self.addFriends addImageIcon:imageFromAssets];
    }
}


- (IBAction)senderbuttonTapped:(UIButton *)sender {
    // 處理按鈕點擊事件的邏輯
    NSLog(@"Button tapped!");
    // 取得Storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    // 使用Storyboard Identifier來實例化MFriendListViewController
    FriendListViewController *friendListViewController = [storyboard instantiateViewControllerWithIdentifier:@"FriendListViewController"];

    [self.navigationController pushViewController:friendListViewController animated:YES]; //
    friendListViewController.kokoName = kokoName;
    friendListViewController.kokoId = kokoId;
    
    friendListViewController.customerImage.image = kokoImage;
    
    //NSLog(@"下一頁：%@",friendListViewController.customerId.text);
    // 或
    //[self presentViewController:friendListViewController animated:YES completion:nil]; // 如果你要模態顯示

}
@end
