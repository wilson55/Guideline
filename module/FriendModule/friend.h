//
//  friend.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface friend : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *isTop;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *updateDate;
@end

NS_ASSUME_NONNULL_END
