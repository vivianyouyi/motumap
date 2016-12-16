//
//  NSString+Extension.h
//  太阳宝
//
//  Created by Dream lee on 15/7/28.
//  Copyright (c) 2015年 Dream lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)


/** 计算在字符串后几位有几个相同的0*/
- (NSInteger)countZero;

/** 将金钱格式转化为数字格式*/
- (float ) setFloatFromMoneyFormat;

/**
 *  将一个字符串中的特定字符添加颜色
 *
 *  @param colorStr 要加颜色的字符串
 *  @param color    颜色
 *  @param font     字体大小
 *
 *  @return 字符串属性
 */
- (NSMutableAttributedString *)colorStr:(NSString *)colorStr withColor:(UIColor *)color font:(NSInteger)font ;

/**
 *  将一个字符串转换成货币类型
 *
 *  @param moneyStr 字符串
 *
 *  @return 货币类型
 */
- (NSString *)setMoneyFormatter;

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


/** 判断字符串是否为空 */
- (BOOL)isBlankString;

/** 验证手机号是否合法 */
-(BOOL)checkPhoneNumInput;

/** 验证身份证号码 */
-(BOOL)checkIDNum;

/** 验证银行卡 */
- (BOOL)checkBankCardNumber;


/**
 *  用指定字符替代指定位置的字符（前后留下的字符串一样长）
 *
 *  @param fromIndex 起始位置
 *  @param charStr   指定的字符
 *  @return 返回一个被替代之后的字符串
 */
- (NSString *)subStringfrom:(NSInteger)fromIndex
                   withChar:(NSString *)charStr;

/**判断获取的数据处是否可用*/
+ (NSString *)stringJsonValue:(id)JsonValue;


/** md5 加密*/
- (NSString *)md5HexDigest;


- (NSString *)hmacMD5StringWithKey:(NSString *)key;

@end
