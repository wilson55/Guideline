//
//  JsonModule.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import "JsonModule.h"

@implementation JsonModule

+ (NSDictionary *)parseJSONString:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if (error) {
        NSDictionary *jsonError = [NSDictionary dictionaryWithObject:error.localizedDescription forKey:@"code"];
        NSLog(@"JSON解析錯誤：%@", error.localizedDescription);
        return jsonError;
    } else {
        return jsonDict;
    }
}

+ (NSDictionary *)parseJSONData:(NSData *)jsonData
{
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if (error) {
        NSDictionary *jsonError = [NSDictionary dictionaryWithObject:error.localizedDescription forKey:@"code"];
        NSLog(@"JSON解析錯誤：%@", error.localizedDescription);
        return jsonError;
    } else {
        NSArray* responseArray = jsonDict[@"response"];
        jsonDict = [self arrayConverToDirectory:responseArray];
        NSLog(@"jsonDict:%@", jsonDict);
        return jsonDict;
    }
    
}

+(NSMutableDictionary*) arrayConverToDirectory:(NSArray*)peopleArray{
    NSMutableDictionary *peopleDictionary = [NSMutableDictionary dictionary];

    for (NSDictionary *person in peopleArray) {
        [peopleDictionary setObject:person forKey:person];
    }
    
    return peopleDictionary;

}

+(NSMutableDictionary*) readJSONFromFile:(NSString*)path {
    // 假設你有一個 JSON 檔案的路徑
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    if (filePath) {
        // 從文件路徑讀取 JSON 數據
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        
        if (jsonData) {
            NSError *error = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            
            if (error) {
                NSLog(@"JSON 解析錯誤: %@", error.localizedDescription);
            } else {
                if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                    jsonDictionary = (NSMutableDictionary *)jsonObject;
                    NSLog(@"解析結果為: %@", jsonDictionary);
                } else {
                    NSLog(@"無法識別 JSON 數據的類型");
                }
            }
        } else {
            NSLog(@"無法讀取 JSON 文件數據");
        }
    } else {
        NSLog(@"找不到 JSON 文件");
    }
    return jsonDictionary;
}

@end
