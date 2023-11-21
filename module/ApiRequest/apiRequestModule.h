//
//  apiRequestModule.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface apiRequestModule : NSObject
+ (void)fetchDataFromAPIWithCompletion:(void (^)(NSDictionary *responseData, NSError *error))completion;

+ (void)fetchDataFromAPIWithURL:(NSURL *)apiUrl completion:(void (^)(NSDictionary *responseData, NSError *error))completion;

+ (void)performAsyncRequestWithCompletion:(void (^)(NSDictionary *mergedData, NSError *error))completion;

+(NSMutableDictionary*)performAsyncRequestWithCompletionByJsonFile:(NSString*) file1 margeFile:(NSString*) file2;

+(NSDictionary*)checkUpdateDateFormat:(NSDictionary*) dateDict;
@end

NS_ASSUME_NONNULL_END
