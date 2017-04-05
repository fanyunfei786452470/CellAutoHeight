//
//  TextModel.h
//  CellAutoHeight
//
//  Created by 范云飞 on 17/4/5.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;

@end
