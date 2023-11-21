//
//  UITableView+ExpandableSections.m
//  Guideline
//
//  Created by Wang YUAN-SHIH on 2023/10/8.
//

#import "UITableView+ExpandableSections.h"
#import <objc/runtime.h>
@implementation UITableView (ExpandableSections)

static const void *ExpandableSectionsKey = &ExpandableSectionsKey;

- (NSMutableArray<NSNumber *> *)expandableSections {
    return objc_getAssociatedObject(self, ExpandableSectionsKey);
}

- (void)setExpandableSections:(NSMutableArray<NSNumber *> *)expandableSections {
    objc_setAssociatedObject(self, ExpandableSectionsKey, expandableSections, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setupExpandableSectionsWithNumberOfSections:(NSInteger)numberOfSections {
    self.expandableSections = [NSMutableArray array];
    // 初始化expandableSections數組，初始狀態都為折疊
    for (NSInteger i = 0; i < numberOfSections; i++) {
        [self.expandableSections addObject:@(0)];
    }
}

@end
