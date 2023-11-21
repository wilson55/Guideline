//
//  JsonModule.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonModule : NSObject
+ (NSDictionary *)parseJSONString:(NSString *)jsonString;
+ (NSDictionary *)parseJSONData:(NSData *)jsonData;
+ (NSMutableDictionary*) readJSONFromFile:(NSString*)path;
@end

NS_ASSUME_NONNULL_END
