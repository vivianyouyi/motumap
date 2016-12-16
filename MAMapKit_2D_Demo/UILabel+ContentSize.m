//
//  UILabel+ContentSize.m
//  BoBoPlayer4.0
//
//  Created by 王亚辉 on 16/3/2.
//  Copyright © 2016年 deepoon. All rights reserved.
//

#import "UILabel+ContentSize.h"

@implementation UILabel (ContentSize)

- (CGSize)contentSize {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
//                                  NSParagraphStyleAttributeName : paragraphStyle
                                  };
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    
    return contentSize;
}

+(UILabel *)labelWithFrame:(CGRect)frame font:(CGFloat)font backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    return label;
}

@end
