//
//  DPUserModel.m
//  DPAssistant
//
//  Created by 吴曹敏 on 16/9/28.
//  Copyright © 2016年 吴曹敏. All rights reserved.
//

#import "MoUserModel.h"

static MoUserModel *singlton = nil;
@implementation MoUserModel

+ (id)currentUser
{
    @synchronized(self){
        if (!singlton) {
            singlton = [[self alloc] init];
        }
    }return singlton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userdefauls = [NSUserDefaults standardUserDefaults];
        
    }
    return self;
}

-(void)parseModelWithDictionary:(NSDictionary *)dictionary
{
    if ([dictionary objectForKey:@"userid"]) {
        self.userid = [dictionary objectForKey:@"userid"];
    }
    if ([dictionary objectForKey:@"sessid"]) {
        self.sessid = [dictionary objectForKey:@"sessid"];
    }
    id avato = [dictionary objectForKey:@"avatar"];
    if (![avato isEqual:[NSNull null]]) {
        self.avatar = [dictionary objectForKey:@"avatar"];
    }
    id nicknam = [dictionary objectForKey:@"nickname"];
    if (![nicknam isEqual:[NSNull null]]) {
        self.nickname = [dictionary objectForKey:@"nickname"];
    }
    id tips = [dictionary objectForKey:@"tips"];
    if (![tips isEqual:[NSNull null]]) {
        self.tips = [dictionary objectForKey:@"tips"];
    }
    
    if ([dictionary objectForKey:@"username"]) {
        self.username = [dictionary objectForKey:@"username"];
    }
    if ([dictionary objectForKey:@"password"]) {
        self.password = [dictionary objectForKey:@"password"];
    }
}

- (void)setUserid:(NSString *)userid
{
    _userid = userid;
    [_userdefauls setValue:userid forKey:@"userid"];
    [_userdefauls synchronize];
}

- (void)setSessid:(NSString *)sessid
{
    _sessid = sessid;
    [_userdefauls setValue:sessid forKey:@"sessid"];
    [_userdefauls synchronize];
}

-(void)setAvatar:(NSString *)avatar{
    if (avatar) {
        _avatar = avatar;
        [_userdefauls setValue:avatar forKey:@"avatarUrl"];
        [_userdefauls synchronize];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_avatar?:@""]]];
            if (!image) {
                return;
            }
            NSString *imageStr = [UIImageJPEGRepresentation(image, 1.0f) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [_userdefauls setValue:imageStr forKey:@"avatar"];
            [_userdefauls synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyIcon" object:nil];
        });
    }


}

- (void)setNickname:(NSString *)nickname
{
    _nickname = nickname;
    [_userdefauls setValue:nickname forKey:@"nickname"];
    [_userdefauls synchronize];
}

-(void)setTips:(NSString *)tips
{
    _tips = tips;
    [_userdefauls setValue:tips forKey:@"signature"];
    [_userdefauls synchronize];
}

- (void)setPassword:(NSString *)password
{
    _password = password;
    [_userdefauls setValue:password forKey:@"password"];
    [_userdefauls synchronize];
}

- (void)setUsername:(NSString *)username
{
    _username = username;
    [_userdefauls setValue:username forKey:@"username"];
    [_userdefauls synchronize];
}



@end
