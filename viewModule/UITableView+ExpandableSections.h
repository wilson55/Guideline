//
//  UITableView+ExpandableSections.h
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ExpandableSections)
// 用於儲存section的展開狀態（0為折疊，1為展開）
@property (nonatomic, strong) NSMutableArray<NSNumber *> *expandableSections;
- (void)setupExpandableSectionsWithNumberOfSections:(NSInteger)numberOfSections;
@end

NS_ASSUME_NONNULL_END
