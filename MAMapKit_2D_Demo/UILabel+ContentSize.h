//
//  UILabel+ContentSize.h
//  BoBoPlayer4.0
//
//  Created by 王亚辉 on 16/3/2.
//  Copyright © 2016年 deepoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ContentSize)
-(CGSize)contentSize;

+(UILabel *)labelWithFrame:(CGRect)frame font:(CGFloat)font backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor;

@end
