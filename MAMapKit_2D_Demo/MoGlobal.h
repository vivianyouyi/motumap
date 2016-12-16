//
//  DPGlobal.h
//  DPAssistant
//
//  Created by 吴曹敏 on 16/9/26.
//  Copyright © 2016年 吴曹敏. All rights reserved.
//

#ifndef MoGlobal_h
#define MoGlobal_h


#define Baidu_AppKey @"ac86d6436b"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#pragma mark NSUserDefaults
#define USER_USERNAME [[NSUserDefaults standardUserDefaults]valueForKey:@"username"]
#define USER_PASSWORD [[NSUserDefaults standardUserDefaults]valueForKey:@"password"]
#define USER_SESSID [[NSUserDefaults standardUserDefaults]valueForKey:@"sessid"]
#define USER_USERID [[NSUserDefaults standardUserDefaults]valueForKey:@"userid"] 
#define USER_AVATAR [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]//头像
#define USER_AVATARURL [[NSUserDefaults standardUserDefaults] objectForKey:@"avatarUrl"]//头像Url
#define USER_NICKNAME [[NSUserDefaults standardUserDefaults]valueForKey:@"nickname"]//用户名
#define USER_SIGNATURE [[NSUserDefaults standardUserDefaults]valueForKey:@"signature"]//个人签名

#endif /* DPGlobal_h */
