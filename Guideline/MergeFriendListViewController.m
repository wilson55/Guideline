//
//  FriendListViewController.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import "MergeFriendListViewController.h"
#import "FriendTableViewCell.h"
#import "InviteTableViewCell.h"
#import "apiRequestModule.h"
#import "UISearchBar+UISearchBar_CustomCancelButton.h"
#import "ShadowModule.h"
#import "UIButton+Badge.h"
#import "JsonModule.h"
@interface MergeFriendListViewController ()
{
    BOOL containsStatusZero;
    BOOL testPullDownToUpdate;
    int testOperation;
    NSInteger segementIndex;
}
@property (nonatomic) CGRect originalTableViewFrame; // 保存原始UITableView的frame
@property (nonatomic) CGRect originalSearchBarFrame; // 保存原始UISearchBar的frame
@property (nonatomic) CGRect originalBaseDataFram;// 保存原始顯示客戶的基本資料區域的frame

@property (nonatomic, strong) NSArray* originalData; // 原始資料
@property (nonatomic, strong) NSMutableArray* filteredData; // 過澽後後的資料
@property (strong, nonatomic) NSMutableArray* inviteFriendList;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIAlertController *alertController;
@end

@implementation MergeFriendListViewController
#pragma mark - ************************************************************

#pragma mark - ************************************************************
// TODO: 仿API 調用回傳的資料 ＝> 使用好友列表 1
-(void)getFriendslist_1
{
    // 向後台API請求數據，取得傳回的數據
    // 這裡假設responseData是從API傳回的數據

    //使用檔案模式
    NSDictionary *friendsList1_1 =  [JsonModule readJSONFromFile:@"friend1"];
    [self setDataSource:friendsList1_1];
}

// TODO: tableview 取得好友列表_2 + 好友列表3  進行合併
-(void)getFriendsList2_FriendsList3
{
    NSMutableDictionary* friendsList2_3 = [[NSMutableDictionary alloc] init];
    friendsList2_3 = [apiRequestModule performAsyncRequestWithCompletionByJsonFile:@"friend2" margeFile:@"friend3"];
   
    NSLog(@"好友資料列表:%@", friendsList2_3);
    
    
    [self setDataSource:friendsList2_3];
}



#pragma mark - 設置tableview的資料來源*****************************************
-(void)setDataSource:(NSDictionary*)dataDictionary
{
    if(dataDictionary[@"response"] != nil){
        self.originalData = dataDictionary[@"response"];
    }else{
        self.originalData = [dataDictionary allValues];
    }
    self.filteredData = [NSMutableArray arrayWithArray:self.originalData];
    
    //originalData 包含解析後的JSON數據
    //NSLog(@"josn data:%@",self.originalData);
    [self checkStatusZero];
}

// TODO: 檢查是否有status : 0 的資料 to inviteTableView, 非0 的資料 to tabelview
-(void)checkStatusZero {
    containsStatusZero = NO;
    self.inviteFriendList = [NSMutableArray array];
    self.filteredData = [NSMutableArray array];
    for (NSDictionary *item in self.originalData) {
        NSInteger status = [item[@"status"] integerValue];
        if (status == 0) {
            [self.inviteFriendList addObject:item];
        }else {
            [self.filteredData addObject:item];
        }
    }
    NSLog(@"inviteFriendList:%@",self.inviteFriendList); //在邀請列表中
    NSLog(@"filteredData:%@",self.filteredData); //在好友列表中
    
    
    if(self.inviteFriendList.count== 0) {
        containsStatusZero = NO;
        NSLog(@"不存在status為0的數據");
        self.customerView.frame = CGRectMake(0,94.0,414,140.0);
        self.searchBarView.frame =CGRectMake(0,243.0,414.0,61.0);
        self.frientsButton.frame= CGRectMake(18.0, 105.0, 63.0, 35.0);
        self.chatButton.frame= CGRectMake(86.0, 105.0, 63.0, 35.0);
        // 調整inviteTableView的frame
        self.inviteTableView.frame = CGRectMake(0, 112, 414, 0);
        // 調整tableView的frame
        self.tableView.frame = CGRectMake(0, 364, 414, 435);
    }else {
        containsStatusZero = YES;
        NSLog(@"存在status為0的數據"); //有送出好友邀請函
        self.customerView.frame = CGRectMake(0,94.0,414,345.0);
        self.searchBarView.frame =CGRectMake(0,438.0,414.0,61.0);
        self.frientsButton.frame= CGRectMake(18.0, 301.0, 63.0, 35.0);
        self.chatButton.frame= CGRectMake(86.0, 301.0, 63.0, 35.0);
        // 調整inviteTableView的frame
        self.inviteTableView.frame = CGRectMake(0, 112, 414, 182);
        // 調整tableView的frame
        self.tableView.frame = CGRectMake(0, 496, 414, 305);
    }
    // 保存原始frame
    self.originalTableViewFrame = self.tableView.frame;
    self.originalSearchBarFrame = self.searchBarView.frame;
    self.originalBaseDataFram = self.customerView.frame;
    [self setUnderLine];
}
#pragma mark - UIViewContorll 生命週期***********************************
-(void)viewWillAppear:(BOOL)animated
{
    //註冊自訂UITableViewCell,使用xib
    [self.inviteTableView registerNib:[UINib nibWithNibName:@"InviteTableViewCell" bundle:nil] forCellReuseIdentifier:@"inviteCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"friendCell"];
    
    
    //有好友含邀請資料時為畫面1-(2)呈現 :好友列表1
    //[self getFriendslist_1];
    //有好友且無邀請資料時為畫面1-(2)呈現 :好友列表1
    [self setDataSource:[JsonModule readJSONFromFile:@"friend1"]];
    
    //取得好友列表_2 + 好友列表3  進行合併
    [self getFriendsList2_FriendsList3];
    
    testPullDownToUpdate=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customerName.text = self.kokoName;
    self.customerId.text = [self.kokoId stringByAppendingString:@"     >"];
    
    segementIndex=30001;
    
    // 建立並配置UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    // 螢幕點擊手勢辨識器
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.searchBar.delegate = self;
    
    //設置取消鍵
    [self setSoftKeyboardInputAccessoryView];
    
    //設置底端兩個按鍵:好友、聊天
    [self setFootButtonBarge];
}
#pragma mark -  底端兩個按鍵：好友 聊天 上的brage ****************************
//TODO: 設置底端兩個按鍵
-(void)setFootButtonBarge
{
    //在按鈕上新增未讀取資訊數量標籤
    [self.frientsButton addBadgeLabelWithText:@"2"];
    [self.chatButton addBadgeLabelWithText:@"99+"];
    
}

// TODO: 回應按鈕點擊事件
//好友按鈕點擊事件
- (IBAction)friendButtonTapped:(id)send {
    UIButton* button = (UIButton*)send;
    segementIndex = button.tag;
    NSLog(@"好友按鈕點擊事件");
    [self setUnderLine];
    // FIXME: 切換成好友列表tabelview
}
//TODO: 聊天按鈕點擊事件
- (IBAction)chatButtonTapped:(id)send {
    
    UIButton* button = (UIButton*)send;
    segementIndex = button.tag;
    NSLog(@"好友按鈕點擊事件");
    [self setUnderLine];
    // FIXME: 切換成聊天列表tabelview
    
}

-(void) setUnderLine
{
    //好友按钮
    if(segementIndex == 30001){
        if(containsStatusZero){
            self.operation.frame= CGRectMake(40.0, 335.0, 20.0, 4.0);
        }else{
            self.operation.frame= CGRectMake(40.0, 139.0, 20.0, 4.0);
        }
        
    }else{
        if(containsStatusZero){
            self.operation.frame= CGRectMake(109.0, 335.0, 20.0, 4.0);
        }else{
            self.operation.frame= CGRectMake(109.0, 139.0, 20.0, 4.0);
        }
    }
}

#pragma mark - ***************************************************
// TODO: uitabelview 相關的內容
//返回總共有多少cell筆數
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 20002) {
            // 如果是inviteTableView
        if(containsStatusZero){
            return self.inviteFriendList.count;
        }else{
            return 0;
        }
    } else if (tableView.tag == 20001) {
        // 如果是tableView
        return self.filteredData.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 20002) {
        if(containsStatusZero){
            InviteTableViewCell *inviteCell = [self.inviteTableView dequeueReusableCellWithIdentifier:@"inviteCell" forIndexPath:indexPath];
                   
            NSDictionary *rowData = self.inviteFriendList[indexPath.row];
            //NSLog(@"inviteFriendList rowData:%@",rowData);
            NSString *name = rowData[@"name"];
            //NSString *isTop = rowData[@"isTop"];
            //NSString *fid = rowData[@"fid"];
            NSString *status = [NSString stringWithFormat:@"%@", rowData[@"status"]];
            NSLog(@"inviteFriendList status:%@",status);
            //NSString *updateDate = rowData[@"updateDate"];
            inviteCell.delegate = self;
            inviteCell.rowIndex = indexPath.row;
            //NSLog(@"fid:%@",fid);
            //NSLog(@"updateDate:%@",updateDate);
            // inviteFriendList[indexPath.row] 等于inviteTableView的数据源
            //新增陰影效果到UITableViewCell的contentView
            [(InviteTableViewCell *)inviteCell addShadow];
            
            [inviteCell setCellDataWithName:name avatarImage:@"testImages1.jpeg"];
            if(indexPath.row == 2){
                inviteCell.layer.zPosition = 200;
            }
           
            return inviteCell;
        }
    } else if (tableView.tag == 20001) {
        
        FriendTableViewCell *friendCell = [self.tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
        NSDictionary *rowData = self.filteredData[indexPath.row];
        //NSLog(@"rowData:%@",rowData);
        NSString *name = rowData[@"name"];
        NSString *isTop = rowData[@"isTop"];
        //NSString *fid = rowData[@"fid"];
        NSString *status = [NSString stringWithFormat:@"%@", rowData[@"status"]];
        [friendCell setCellDataWithName:name status:status isTop:isTop];
        return friendCell;
    }
    return nil;
}
//TODO: 點選cell後會呼叫此function告知哪個cell已經被選擇(0開始)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"已選擇的cell編號:%ld",indexPath.row);
    NSLog(@"cell值: %@",[self.filteredData objectAtIndex:indexPath.row]);
    NSLog(@"\r\n");
}


#pragma mark - ************************************************************
// TODO : InviteTableViewCellDelegate方法实现
- (void)friendsAgreeButtonTappedAtIndex:(NSInteger)index {
    NSLog(@"處理friendsAgree按鈕點擊事件，可以使用index來取得特定行的數據 %ld",index);
}

- (void)friendsDeleteButtonTappedAtIndex:(NSInteger)index {
    // 处理friendsDelete按钮点击事件，可以使用index来获取特定行的数据
    NSLog(@"處理friendsDelete按鈕點擊事件，可以使用index來取得特定行的數據 @%ld",index);
}
#pragma mark - ************************************************************
// TODO:UISearbar 協議相關
// TODO:點擊搜尋框,畫面上推至搜尋框置頂至navigationBar下方
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    // 當UISearchBar開始編輯時，上推UITableView和UISearchBar
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    NSLog(@"navigationBar的高度：%f", navigationBarHeight);
    
    UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject;
    
    CGFloat statusBarHeight = windowScene.statusBarManager.statusBarFrame.size.height;
    NSLog(@"狀能欄的高度：%f", statusBarHeight);
    
    CGFloat customerViewHeight = 260.0;
    if(!containsStatusZero){
        customerViewHeight = 72.0;
    }
    
    //statusBarManager
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newTableViewFrame = self.originalTableViewFrame;
        newTableViewFrame.origin.y -= (navigationBarHeight + statusBarHeight + customerViewHeight);
        
        CGRect newSearchBarFrame = self.originalSearchBarFrame;
        newSearchBarFrame.origin.y -= (navigationBarHeight + statusBarHeight + customerViewHeight);
        
        self.tableView.frame = newTableViewFrame;
        self.searchBarView.frame = newSearchBarFrame;
    }];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchText = searchBar.text;
    [self filterContentForSearchText:searchText];
}

// TODO: 恢復UITableView和UISearchBar的位置
-(void) cancelButtonTapped
{
    [self.searchBar resignFirstResponder]; // 隱藏鍵盤
        
    // 隱藏自訂取消按鈕
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    self.filteredData = [NSMutableArray arrayWithArray:self.originalData];
    // 刷新UITableView以顯示過濾結果
    [self.tableView reloadData];
    [self restoreTabelViewFrame];
    
}

// TODO:按下Enter 鍵也表示過濾查詢結束
-(void) filterContentForSearchText:(NSString*) searchText{
    if (searchText.length == 0) {
        // 如果搜尋欄為空，顯示全部數據
        self.filteredData = [NSMutableArray arrayWithArray:self.originalData];
    } else {
        NSMutableArray<NSDictionary *> *filteredResult = [NSMutableArray array];
        NSLog(@"輸入的文字:%@", searchText);
        for (NSDictionary *item in self.originalData) {
            NSString *name = item[@"name"];
            NSLog(@"name:%@",name);
            if ([name containsString:searchText]) {
                [filteredResult addObject:item];
            }
        }
        NSLog(@"過濾結果:%@", filteredResult);
        
        if (filteredResult.count == 0) {
            // 如果没有找到匹配项，顯示一個提示訊息
            [self showAlert:searchText];
            NSLog(@"没有找到匹配的數據");
        }else{
            self.filteredData = [filteredResult mutableCopy];
            NSLog(@"filteredData:%@",self.filteredData);
            // 清空UISearchBar中的文本
            self.searchBar.text = @"";
            [self.searchBar resignFirstResponder]; // 隱藏鍵盤
            // 刷新UITableView以顯示過濾結果
            [self.tableView reloadData];
            [self restoreTabelViewFrame];
        }
    }
}
// TODO: 没有找到匹配的數據
- (void)showAlert:(NSString*) searchText{
    self.alertController = [UIAlertController alertControllerWithTitle:@"" message:@"没有找到符合的好友姓名" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 按下了確定鈕后的操作
        NSLog(@"按下了確定鈕");
        [self.searchBar resignFirstResponder]; // 隱藏鍵盤
        [self restoreTabelViewFrame];
       
    }];
    
    [self.alertController addAction:okAction];
    
    [self presentViewController:self.alertController animated:YES completion:nil];
}
#pragma mark - 當使用者點任何位置時，會將頁面復原位置
// TODO: 手勢處理
- (void)handleTap:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self.view];

    // 檢查是否點擊了UISearchBar以外的區域，且UISearchBar沒有內容
    if (!CGRectContainsPoint(self.searchBar.frame, tapPoint) && [self.searchBar.text isEqualToString:@""]) {
        [self.searchBar resignFirstResponder]; // 隱藏鍵盤

        [self restoreTabelViewFrame];
    }
}

// TODO: 恢復原始frame
- (void) restoreTabelViewFrame
{
    [UIView animateWithDuration:0.3 animations:^{
        // 恢復原始frame
        self.searchBar.text = @"";
        self.tableView.frame = self.originalTableViewFrame;
        self.searchBarView.frame = self.originalSearchBarFrame;
    }];
}

// TODO: 設置在軟鍵盤的新增一個取消查詢鍵
-(void)setSoftKeyboardInputAccessoryView{
    // 調整 frame 大小以適應
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped)];
        
    // 將取消按鈕移到右側
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
    // 將取消按鈕和空白間距按鈕新增至 toolbar
    [toolbar setItems:@[flexibleSpace, cancelButton]];
        
    // 將 toolbar 設定為 inputAccessoryView
    self.searchBar.inputAccessoryView = toolbar;
}


#pragma mark - ************************************************************
/*API請在開始時作非同步request, 同時request兩個資料,將兩個資料源整合為列表
 若重覆fid資料則取updateDate較新的那一筆
 */
-(void)getAllKokoData
{
    [apiRequestModule performAsyncRequestWithCompletion:^(NSDictionary *mergedData, NSError *error) {
        if (!error) {
            // 處理 mergedData
            NSLog(@"合併後的數據：%@", mergedData);
        } else {
            // 處理錯誤
            NSLog(@"發生錯誤：%@", error.localizedDescription);
        }
    }];
    
}

#pragma mark - ************************************************************
// TODO: 當使用下拉式選單時，在好友列表中顯示不同的資料內容，來表示對後台的API進行請求結果
// 取得資料並設定資料來源
- (void)fetchDataFromAPI {
    // 向後台API請求數據，取得傳回的數據
    // 這裡假設responseData是從API傳回的數據
    //好友列表2
    //好友列表2
    NSDictionary *dataDictionary = [JsonModule readJSONFromFile:@"friend2"];
    //好友列表1
    if(testPullDownToUpdate){
        dataDictionary = [JsonModule readJSONFromFile:@"friend3"];
    }
    
    // 將dataDictionary設定為UITableView的資料來源
    [self setDataSource:dataDictionary];
    
    // 刷新UITableView
    [self.tableView reloadData];
}

- (void)fetchDataFromFile {
    // 向後台API請求數據，取得傳回的數據
    // 這裡假設responseData是從API傳回的數據
    //好友列表2
    NSDictionary *dataDictionary =  [JsonModule readJSONFromFile:@"friend2"];
    //好友列表1
    if(testPullDownToUpdate){
        dataDictionary =  [JsonModule readJSONFromFile:@"friend1"];
    }
    
    // 將dataDictionary設定為UITableView的資料來源
    [self setDataSource:dataDictionary];
    
    // 刷新UITableView
    [self.tableView reloadData];
}


// TODO: 好友列表支援下拉更新
- (void)refreshData {
    // 向后台API重新请求數據
    //[self fetchDataFromAPI];
    [self fetchDataFromFile];

    // 结束刷新
    [self.refreshControl endRefreshing];
    if(testPullDownToUpdate){
        [self.changeScene setTitle:@"好友列表含邀請好友" forState:UIControlStateNormal];
        testPullDownToUpdate=NO;
    } else {
        [self.changeScene setTitle:@"好友列表無邀請" forState:UIControlStateNormal];
        testPullDownToUpdate=YES;
    }
    
}

//TODO: 切換好友列表
-(IBAction)changeFriendList:(id)sender
{
    [self refreshData];
}
#pragma mark - ************************************************************


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
