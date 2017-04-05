//
//  UITableViewCell+MasonryAutoCellHeight.m
//  CellAutoHeight
//
//  Created by 范云飞 on 17/4/5.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "UITableViewCell+MasonryAutoCellHeight.h"
#import <objc/runtime.h>

NSString *const kFYFCacheUniqueKey = @"kFYFCacheUniqueKey";
NSString *const kFYFCacheStateKey = @"kFYFCacheStateKey";
NSString *const kFYFRecalculateForStateKey = @"kFYFRecalculateForStateKey";
NSString *const kFYFCacheForTableViewKey = @"kFYFCacheForTableViewKey";

const void *s_fyf_lastViewInCellKey = "fyf_lastViewInCellKey";
const void *s_fyf_bottomOffsetToCellKey = "fyf_bottomOffsetToCellKey";

@implementation UITableViewCell (HYBMasonryAutoCellHeight)

#pragma mark - Public
+ (CGFloat)fyf_heightForTableView:(UITableView *)tableView config:(FYFCellBlock)config {
    UITableViewCell *cell = [tableView.fyf_reuseCells objectForKey:[[self class] description]];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                           reuseIdentifier:nil];
        [tableView.fyf_reuseCells setObject:cell forKey:[[self class] description]];
    }
    
    if (config) {
        config(cell);
    }
    
    return [cell private_fyf_heightForTableView:tableView];
}

+ (CGFloat)fyf_heightForTableView:(UITableView *)tableView
                           config:(FYFCellBlock)config
                            cache:(FYFCacheHeight)cache {
    
    NSAssert(tableView, @"tableView is necessary param");
    
    if (cache) {
        NSDictionary *cacheKeys = cache();
        NSString *key = cacheKeys[kFYFCacheUniqueKey];
        NSString *stateKey = cacheKeys[kFYFCacheStateKey];
        NSString *shouldUpdate = cacheKeys[kFYFRecalculateForStateKey];
        
        NSMutableDictionary *stateDict = tableView.fyf_cacheCellHeightDict[key];
        NSString *cacheHeight = stateDict[stateKey];
        
        if (tableView.fyf_cacheCellHeightDict.count == 0
            || shouldUpdate.boolValue
            || cacheHeight == nil) {
            CGFloat height = [self fyf_heightForTableView:tableView config:config];
            
            if (stateDict == nil) {
                stateDict = [[NSMutableDictionary alloc] init];
                tableView.fyf_cacheCellHeightDict[key] = stateDict;
            }
            
            [stateDict setObject:[NSString stringWithFormat:@"%lf", height] forKey:stateKey];
            
            return height;
        } else if (tableView.fyf_cacheCellHeightDict.count != 0
                   && cacheHeight != nil
                   && cacheHeight.integerValue != 0) {
            return cacheHeight.floatValue;
        }
    }
    
    return [self fyf_heightForTableView:tableView config:config];
}

- (void)setFyf_lastViewInCell:(UIView *)fyf_lastViewInCell {
    objc_setAssociatedObject(self,
                             s_fyf_lastViewInCellKey,
                             fyf_lastViewInCell,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)fyf_lastViewInCell {
    return objc_getAssociatedObject(self, s_fyf_lastViewInCellKey);
}

- (void)setFyf_lastViewsInCell:(NSArray *)fyf_lastViewsInCell {
    objc_setAssociatedObject(self,
                             @selector(fyf_lastViewsInCell),
                             fyf_lastViewsInCell,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)fyf_lastViewsInCell {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFyf_bottomOffsetToCell:(CGFloat)fyf_bottomOffsetToCell {
    objc_setAssociatedObject(self,
                             s_fyf_bottomOffsetToCellKey,
                             @(fyf_bottomOffsetToCell),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)fyf_bottomOffsetToCell {
    NSNumber *valueObject = objc_getAssociatedObject(self, s_fyf_bottomOffsetToCellKey);
    
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return valueObject.floatValue;
    }
    
    return 0.0;
}

#pragma mark - Private
- (CGFloat)private_fyf_heightForTableView:(UITableView *)tableView {
    //    NSAssert(self.fyf_lastViewInCell != nil
    //             || self.fyf_lastViewsInCell.count != 0,
    //             @"您未指定cell排列中最后的视图对象，无法计算cell的高度");
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
    CGFloat rowHeight = 0.0;
    
    for (UIView *bottomView in self.contentView.subviews) {
        if (rowHeight < CGRectGetMaxY(bottomView.frame)) {
            rowHeight = CGRectGetMaxY(bottomView.frame);
        }
    }
    
    //    if (self.fyf_lastViewInCell) {
    //        rowHeight = self.fyf_lastViewInCell.frame.size.height + self.fyf_lastViewInCell.frame.origin.y;
    //    } else {
    //        for (UIView *view in self.fyf_lastViewsInCell) {
    //            if (rowHeight < CGRectGetMaxY(view.frame)) {
    //                rowHeight = CGRectGetMaxY(view.frame);
    //            }
    //        }
    //    }
    
    rowHeight += self.fyf_bottomOffsetToCell;
    
    return rowHeight;
}



@end

