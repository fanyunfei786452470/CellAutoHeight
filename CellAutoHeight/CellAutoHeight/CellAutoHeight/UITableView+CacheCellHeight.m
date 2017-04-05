//
//  UITableView+CacheCellHeight.m
//  CellAutoHeight
//
//  Created by 范云飞 on 17/4/5.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "UITableView+CacheCellHeight.h"
#import <objc/runtime.h>

static const void *__fyf_tableview_cacheCellHeightKey = "__fyf_tableview_cacheCellHeightKey";
static const void *__fyf_tableview_reuse_cells_key = "__fyf_tableview_reuse_cells_key";
@implementation UITableView (CacheCellHeight)

- (NSMutableDictionary *)fyf_cacheCellHeightDict {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, __fyf_tableview_cacheCellHeightKey);
    
    if (dict == nil) {
        dict = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 __fyf_tableview_cacheCellHeightKey,
                                 dict,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dict;
}

- (NSMutableDictionary *)fyf_reuseCells {
    NSMutableDictionary *cells = objc_getAssociatedObject(self, __fyf_tableview_reuse_cells_key);
    
    if (cells == nil) {
        cells = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 __fyf_tableview_reuse_cells_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return cells;
}

@end
