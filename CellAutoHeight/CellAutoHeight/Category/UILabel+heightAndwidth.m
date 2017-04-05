//
//  UILabel+heightAndwidth.m
//  label(高度计算)
//
//  Created by 范云飞 on 17/3/13.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "UILabel+heightAndwidth.h"

@implementation UILabel (heightAndwidth)
/**
 *  给UILabel设置行间距和字间距
 *  @param space 间距
 *  @param text  内容
 *  @param font  字体
 *  @param zpace  字间距 --> @10 这样设置  默认的话设置 0 就ok
 */
-(void)setLineSpace:(CGFloat)space withLabelText:(NSString*)text withFont:(UIFont*)font withZspace:(NSNumber *)zspace Width:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    paraStyle.alignment =NSTextAlignmentLeft;
//    paraStyle.lineSpacing = space; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent =0.0;
    paraStyle.paragraphSpacingBefore =0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic;
    CGFloat height;
    CGFloat oneHeight;
    CGFloat rowHeight;
    if (zspace == 0) {
        dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@1.5f,
               };
    }else {
        dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:zspace,
               };
        // 计算文本的高度
        oneHeight = [@"这样貌似解决了" boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
        
        rowHeight = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
        if (rowHeight>oneHeight) {
            height = rowHeight;
            paraStyle.lineSpacing = space; //设置行间距
            dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:zspace,
                   };
        }
        else{
            height = oneHeight;
            paraStyle.lineSpacing = 0; //设置行间距
            dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:zspace,NSBaselineOffsetAttributeName:@(0),
                   };
        }
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    
    self.attributedText = attributeStr;
}
/**
 *  计算UILabel的高度(带有行间距的情况)
 *  @param text  内容
 *  @param font  字体
 *  @param width 宽度
 *  @return 高度
 *  @param zpace  字间距 --> @10 这样设置  默认的话设置 0 就ok
 */
-(CGFloat)getSpaceLabelHeight:(NSString*)text withFont:(UIFont*)font withWidth:(CGFloat)width withSpace:(CGFloat)space withZspace:(NSNumber *)zpace{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    paraStyle.alignment =NSTextAlignmentLeft;
//    paraStyle.lineSpacing = space;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent =0.0;
    paraStyle.paragraphSpacingBefore =0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic;
    CGFloat height;
    CGFloat oneHeight;
    CGFloat rowHeight;
    if (zpace == 0) {
        dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@1.5f
               };
    }else {
        // 计算文本的高度
        oneHeight = [@"这样貌似解决了" boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
        rowHeight = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
        if (rowHeight>oneHeight) {
            height = rowHeight;
            paraStyle.lineSpacing = space; //设置行间距
            dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:zpace,
                   };
        }
        else{
            height = oneHeight;
            paraStyle.lineSpacing = 0; //设置行间距
            dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:zpace,NSBaselineOffsetAttributeName:@(0),
                   };
        }
    }
        CGSize size = [text boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}

/**
 *  首行缩进 计算字符串高度
 *  @param text     内容
 *  @param indentationNum 要缩进几个字符
 *  @param alignment   对齐格式
 *  @param fontSize 字体大小
 *  @param width    宽度
 *  @return 返回高度
 */
- (CGFloat)getIndentationLabelHeight:(NSString *)text withStrIndentationNum:(int)indentationNum withNSTextAlignment:(NSTextAlignment )alignment withFontSize:(CGFloat)fontSize withWidth:(CGFloat)width
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = alignment;  //对齐
    paraStyle.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = fontSize * indentationNum;
    paraStyle.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle.tailIndent = 0.0f;//行尾缩进
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    self.attributedText = attrText;
    CGFloat height = [self sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
    return height;
}

- (void)labelTextAlignment
{
    NSMutableAttributedString *attributeString =  [[NSMutableAttributedString alloc] initWithString:self.text];
    CGSize attributeSize = [attributeString.string sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGSize adjustedSize = CGSizeMake(ceilf(attributeSize.width), ceilf(attributeSize.height));
    CGSize frame = self.frame.size;
    NSNumber *wordSpace = [NSNumber numberWithInt:((frame.width-adjustedSize.width)/(attributeString.length-1))];
    [attributeString addAttribute:NSKernAttributeName value:wordSpace range:NSMakeRange(0, attributeString.length-1)];
    self.attributedText = attributeString;
}

@end
