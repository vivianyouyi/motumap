//
//  DPAPIs.h
//  DPAssistant
//
//  Created by 吴曹敏 on 16/9/27.
//  Copyright © 2016年 吴曹敏. All rights reserved.
//

#ifndef MoAPIs_h
#define MoAPIs_h

//客户端升级
#define UPDATE_URL @"http://deepoon.com/dpassistant/android.html" //正式版

#pragma mark - 关于请求头加密
#define VERSION_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define VERSIONINFOFALSE @"versionInfoFalse"   //获取新版本信息错误

//测试域名：http://t.m.api.deepoon.com
//API
#pragma mark API

#define DPASSISTANT_API @"http://t.m.api.deepoon.com"

//意见反馈
#define SENDFEEDBACK DPASSISTANT_API @"/common/feedback?"
//升级功能提示接口
#define UPGRADEURL DPASSISTANT_API @"/common/iosversion" //升级功能提示接口

#pragma mark 游戏模块
//游戏请求相关的API
#define GAME_API DPASSISTANT_API @"/appstore"
#define GETRECOMMEND GAME_API @"/getIndex?" //首页推荐页
#define GETGAMECLASS GAME_API @"/getGameClass?"//游戏分类
#define GETGAMERANK GAME_API @"/getGameTop?"//游戏排行
#define GETGAMELIST GAME_API @"/getApplist?" //游戏列表
#define GETGAMEINFO GAME_API @"/getAppInfo?" //游戏详情
//评论相关的API
#define COMMENT_API DPASSISTANT_API @"/user"
#define GETCOMMENTLIST COMMENT_API @"/getCmtList?" //获取评论列表
#define ADDCOMMENT COMMENT_API @"/addComment?" //添加评论
#define DELCOMMENT COMMENT_API @"/delComment" //删除评论
#define ADDSCORE COMMENT_API @"/addScore?" //添加打分
#define ISSCORE COMMENT_API @"/isScore?" //是否对这个APP打过分 如果打过会返回他打过的分数
//支付相关的API
#define GAMEPAY_API DPASSISTANT_API @"/order"
#define CREATEORDER GAMEPAY_API @"/createOrder?" //创建订单
#define GETALIPAYSTR GAMEPAY_API @"/getAlipaySign?" //获取支付宝加密字符串
#define GETWEIXINSTR GAMEPAY_API @"/getWXPaySign?"//获取微信加密字符串
#define GETORDERLIST GAMEPAY_API @"/getOrderList?" //获取订单列表
#define GETORDERINFO GAMEPAY_API @"/getOrderInfo?" //订单详细
#define GETCOUPON GAMEPAY_API @"/coupon?" //激活码
#define GAMEISBUY GAMEPAY_API @"/isUserBuyApp?"//判断用户是否购买
//设备绑定相关
#define DEVICE_API DPASSISTANT_API @"/datasharing"
#define GETBINDDEVICE DEVICE_API @"/getUserBind?" //获取用户绑定的M2设备
#define ISBIND DEVICE_API @"/isUserBind?" //判断该设备是否被绑定
#define GAMEISGET DEVICE_API @"/isDatasharing?" //游戏是否获取
#define ADDGMAE DEVICE_API @"/addDatasharing?" //支付成功后表示已获取游戏
#define ADDBINDDEVICE DEVICE_API @"/addUserBind?" //添加绑定的设备到后台
#define DELBINDDEVICE DEVICE_API @"/delUserBind?" //删除绑定的设备,即所谓的解绑
#define GETMYCLOUDDATA DEVICE_API @"/getDatasharing?" //获取我的云端数据


#pragma mark 用户模块
//测试的url @"https://y.passport.deepoon.com/api/user"
#define USERURL_DEEPOON  @"https://passport.deepoon.com/api/user"                //用户
#define USER_REGISTER USERURL_DEEPOON @"/register?"                 //用户注册
#define USER_GETVERFYCODE USERURL_DEEPOON @"/getVerifyCode?"        //获取短信
#define USER_LOGIN USERURL_DEEPOON @"/login?"                       //登录
#define USER_LOGOUT USERURL_DEEPOON @"/outlogin?"                       //退出登录
#define USER_FINDPASSWORD USERURL_DEEPOON @"/findpassword?"         //重置密码/找回密码
#endif /* DPAPIs_h */
