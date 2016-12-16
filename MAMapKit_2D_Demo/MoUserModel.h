//
//  DPUserModel.h
//  DPAssistant
//
//  Created by 吴曹敏 on 16/9/28.
//  Copyright © 2016年 吴曹敏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoUserModel : NSObject
@property (nonatomic,retain)NSUserDefaults *userdefauls ;

@property (nonatomic,retain)NSString *userid;
@property (nonatomic,retain)NSString *sessid;
@property (nonatomic,retain)NSString *avatar;
@property (nonatomic,retain)NSString *nickname;
@property (nonatomic,strong)NSString *tips;
@property (nonatomic,retain)NSString *username;
@property (nonatomic,retain)NSString *password;

-(void)parseModelWithDictionary:(NSDictionary *)dictionary;

+ (id)currentUser;

@end
