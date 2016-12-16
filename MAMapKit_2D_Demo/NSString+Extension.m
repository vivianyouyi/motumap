//
//  NSString+Extension.m
//  太阳宝
//
//  Created by Dream lee on 15/7/28.
//  Copyright (c) 2015年 Dream lee. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

#define     LocalStr_None           @""

@implementation NSString (Extension)


/** 计算在字符串后几位有几个相同的0*/
- (NSInteger)countZero {
    NSInteger count = 0;
    for (int i = 0; i < self.length; i ++) {
        char M = [self characterAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"%c",M];
        if ([str isEqualToString:@"0"] &&  i <= self.length - 1) {
            count ++;
        }
        else {
            count =  0;
        }
    }
    return count;
}

/* 将金额形式转换为小数*/
- (float)setFloatFromMoneyFormat {
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.locale =  [NSLocale currentLocale];
    format.numberStyle = kCFNumberFormatterDecimalStyle;
    
    NSNumber *num = [format numberFromString:self];
    
   return [num doubleValue];
}

/** 验证手机号码 */
-(BOOL)checkPhoneNumInput{
    
//    NSString *phoneRegex = @"^((13[0-9])|(147)|(17[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSString *phoneRegex = @"^((13)|(14)|(15)|(17)|(18))\\d{9}$";
//      NSString *phoneRegex = @"^((1)\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
    
}

/** 验证身份证号码 */
-(BOOL)checkIDNum {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
    
}

/** 验证银行卡 */
- (BOOL)checkBankCardNumber
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:self];
}

/**  将一个字符串中的特定字符添加颜色 */
- (NSMutableAttributedString *)colorStr:(NSString *)colorStr withColor:(UIColor *)color font:(NSInteger)font  {
    NSRange range = [self rangeOfString:colorStr];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = color;
    
    if (font > 0) {
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:font];
    }
    [attribute addAttributes:dic range:NSMakeRange(range.location,range.length)];
    
    return attribute;
}

/**  将字符串转化为货币类型 */
- (NSString *)setMoneyFormatter {
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.locale =  [NSLocale currentLocale];
    format.numberStyle = kCFNumberFormatterCurrencyStyle;
    format.usesGroupingSeparator = YES;
    NSNumber *num = [NSNumber numberWithDouble:[self doubleValue]];
    NSString *str = [format stringFromNumber:num];
    
    if ([str containsString:@"$"]) {
      str =  [str substringFromIndex:4];
    } else {
      str = [str substringFromIndex:1];
    }
    return str;
}


/**  返回字符串所占用的尺寸 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**  判断字符串是否为空 */
- (BOOL)isBlankString {
    
    if (self == nil) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isEqual:nil] || [self isEqual:Nil]){
        return YES;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (0 == [self length]){
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if([self isEqualToString:@"(null)"]){
        return YES;
    }
    
    return NO;
    
}


/**  用指定字符替代指定位置的字符（前后留下的字符串一样长）*/
- (NSString *)subStringfrom:(NSInteger)fromIndex withChar:(NSString *)charStr {
    
    NSMutableString *allStr = [NSMutableString string];
    NSMutableString *changeStr = [NSMutableString string];

    if (self.length < fromIndex) return nil;
    
    NSString *hearStr = [self substringToIndex:fromIndex];//头字符串
    
    NSString *str1 = [self substringFromIndex:fromIndex];
    
    //数值相减的时候，需要告知数值类型，
    if ((long long)(str1.length - fromIndex) > (long long)1)  {
    NSLog(@">>>>>>>>>>>  %ld  %ld  %ld",str1.length,fromIndex,str1.length - fromIndex);
        NSString *str2 = [str1 substringToIndex:str1.length - fromIndex];
        for (int i = 0; i < str2.length; i ++) {
            [changeStr appendString:charStr];
        }
    NSString *tailStr = [self substringFromIndex:fromIndex + str2.length];//尾部字符串
    [allStr appendString:hearStr];
    [allStr appendString:changeStr];
    [allStr appendString:tailStr];
    return allStr;
    }
    return nil;
   
}





/** md5 加密*/
- (NSString *)md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    unsigned char buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

+ (NSString *)stringJsonValue:(id)JsonValue
{
    NSString *string = @"";
    if (JsonValue == [NSNull null]) {
        string = @"";
    }else{
        
        if ([JsonValue isKindOfClass:[NSString class]])
        {
            string = JsonValue;
        }
        else if ([JsonValue isKindOfClass:[NSNumber class]])
        {
            string = [JsonValue stringValue];
        }
    }
    return string;
}

#pragma mark - 助手方法
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

@end
