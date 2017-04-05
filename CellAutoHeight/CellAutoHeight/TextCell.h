//
//  TextCell.h
//  CellAutoHeight
//
//  Created by 范云飞 on 17/4/5.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextModel;
typedef void(^FYFExpandBlock)(BOOL isExpand);

@interface TextCell : UITableViewCell

@property (nonatomic, copy) FYFExpandBlock expandBlock;

- (void)configCellWithModel:(TextModel *)model;

@end
