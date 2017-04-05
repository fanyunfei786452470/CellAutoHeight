//
//  UITableView+CacheCellHeight.h
//  CellAutoHeight
//
//  Created by 范云飞 on 17/4/5.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  基于Masonry自动布局实现的自动计算cell的行高扩展
 */
@interface UITableView (CacheCellHeight)

/**
 用于缓存Cell的行高
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *fyf_cacheCellHeightDict;

/**
用于获取或者添加计算行高的cell，因为理论上只有一个cell用来计算行高，以降低消耗
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *fyf_reuseCells;

@end
