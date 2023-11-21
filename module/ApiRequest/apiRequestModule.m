//
//  apiRequestModule.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import "apiRequestModule.h"
#import "JsonModule.h"
@implementation apiRequestModule

// TODO: 取得客戶基本資料
+ (void)fetchDataFromAPIWithCompletion:(void (^)(NSDictionary *responseData, NSError *error))completion {
    // 設置API請求URL
    NSURL *url = [NSURL URLWithString:@"https://api.example.com/your-api-endpoint"];
    
    // NSURLSession對象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // NSURLSessionDataTask來執行非同步請求
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"API請求錯誤：%@", error.localizedDescription);
            } else {
                
                NSDictionary *responseData =[JsonModule parseJSONData:data];
                if ([responseData.allKeys containsObject:@"code"]) {
                    NSLog(@"JSON解析錯誤：%@", responseData[@"code"]);
                } else {
                    NSLog(@"成功獲取數據：%@", responseData);
                    completion(responseData, nil);
                }
            }
        });
    }];
    
    // 開始請求
    [task resume];
}

// TODO: 取得好友列表
+ (void)fetchDataFromAPIWithURL:(NSURL *)apiUrl completion:(void (^)(NSDictionary *responseData, NSError *error))completion {
    // 創建立NSURLSession對象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 建立NSURLSessionDataTask來執行非同步請求
    NSURLSessionDataTask *task = [session dataTaskWithURL:apiUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"API請求錯誤：%@", error.localizedDescription);
            } else {
                NSDictionary *responseData =[JsonModule parseJSONData:data];
                if ([responseData.allKeys containsObject:@"code"])  {
                    NSLog(@"JSON解析錯誤：%@", responseData[@"code"]);
                } else {
                    NSLog(@"成功獲取數據：%@", responseData);
                    completion(responseData, nil);
                }
            }
        });
    }];
    
    // 開始請求
    [task resume];
}


+ (void)performAsyncRequestWithCompletion:(void (^)(NSDictionary *mergedData, NSError *error))completion {
    NSMutableDictionary *mergedData = [NSMutableDictionary dictionary];
    // 建立一個平行隊列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.example.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);

    //建立兩個URL
    NSURL *url1 = [NSURL URLWithString:@"https://example.com/api/endpoint1"];
    NSURL *url2 = [NSURL URLWithString:@"https://example.com/api/endpoint2"];

    // 使用並行隊列執行非同步請求
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, concurrentQueue, ^{
           // 非同步請求1
           NSURLSessionDataTask *task1 = [[NSURLSession sharedSession] dataTaskWithURL:url1 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (error) {
                   NSLog(@"請求1失敗：%@", error.localizedDescription);
               } else {
                   // 解析請求1的JSON數據
                   NSDictionary *responseData =[JsonModule parseJSONData:data];
                   if ([responseData.allKeys containsObject:@"code"])  {
                       NSLog(@"JSON解析錯誤：%@", responseData[@"code"]);
                   }else {
                       [self mergeData:responseData intoDictionary:mergedData];
                   }
               }
               dispatch_group_leave(group);
           }];

           dispatch_group_enter(group);
           [task1 resume];
       });

       dispatch_group_async(group, concurrentQueue, ^{
           // 非同步請求2
           NSURLSessionDataTask *task2 = [[NSURLSession sharedSession] dataTaskWithURL:url2 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (error) {
                   NSLog(@"請求2失敗：%@", error.localizedDescription);
               } else {
                   // 解析請求2的JSON數據
                   NSDictionary *responseData =[JsonModule parseJSONData:data];

                   if ([responseData.allKeys containsObject:@"code"])  {
                       NSLog(@"JSON解析錯誤：%@", responseData[@"code"]);
                   }else {
                       [self mergeData:responseData intoDictionary:mergedData];
                   }
               }
               dispatch_group_leave(group);
           }];

           dispatch_group_enter(group);
           [task2 resume];
       });

       dispatch_group_notify(group, concurrentQueue, ^{
           // 所有请求都完成
           dispatch_async(dispatch_get_main_queue(), ^{
               // 在主线程中调用闭包并传递 mergedData
               if (completion) {
                   completion(mergedData, nil);
               }
           });
       });

}

+ (NSMutableDictionary*)performAsyncRequestWithCompletionByJsonFile:(NSString*) file1 margeFile:(NSString*) file2{
    NSMutableDictionary *mergedData = [NSMutableDictionary dictionary];

    //建立兩個JsonData
    NSDictionary *responseData1  =  [JsonModule readJSONFromFile:file1];
    

    NSDictionary *responseData2 = [JsonModule readJSONFromFile:file2];
    
    [self mergeData:responseData1 intoDictionary:mergedData];
    [self mergeData:responseData2 intoDictionary:mergedData];
    return mergedData;
}


+ (void)mergeData:(NSDictionary *)data intoDictionary:(NSMutableDictionary *)mergedData {
    NSArray* array = data[@"response"];
    for (NSDictionary *item in array) {
        NSString *fid = item[@"fid"];
        NSMutableDictionary *item_ = [[NSMutableDictionary alloc] init];
        item_ = (NSMutableDictionary*)[self checkUpdateDateFormat:item];
        NSLog(@"item_updateDate:%@",item[@"updateDate"]);
        
        NSInteger updateDateNumber= [item_[@"updateDate"] intValue];
        NSLog(@"日期數字:%ld",updateDateNumber);
        //是否已有該fid資料，若有時，則會取出來比較
        NSInteger existingUpdateDate = [mergedData[fid][@"updateDate"] intValue];
        
        if (existingUpdateDate > 0 || (updateDateNumber > existingUpdateDate)) {
            // 更新字典中的數據
            mergedData[fid] = item_;
        }
    }
}

//+(NSDictionary*)checkUpdateDateFormat:(NSString*) dateString
+(NSDictionary*)checkUpdateDateFormat:(NSDictionary*) dateDict
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"]; // 設定日期格式，若要與輸入字串的格式相符建立
    NSMutableDictionary* checkDict = [[NSMutableDictionary alloc] initWithDictionary:dateDict];
    
    NSString* dateString = checkDict[@"updateDate"];
    NSDate *date = [dateFormatter dateFromString:dateString]; // 嘗試將字串轉換為日期

    if (date) {
        NSLog(@"'%@' 是一個有效的日期字串，轉換後的日期為：%@", dateString, date);
        NSString *numberString = [dateString stringByReplacingOccurrencesOfString:@"/" withString:@""];
        NSLog(@"'%@' 轉換後的數值字符串為：%@", dateString, numberString);
        [checkDict setObject:numberString forKey:@"updateDate"];
        return checkDict;
        //return numberString;
    }
    NSLog(@"'%@' 不是一個有效的日期字串", dateString);
    return checkDict;
    //return dateString;
}
@end

