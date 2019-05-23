//
//  UserModelArchiver.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModelArchiver : NSObject

+ (UserModel *)unarchive; //解码
+ (UserInfoModel *)InfoUnarchive;
+ (PowerModel *)PowerUnarchive;

+ (void)archive; //归档
+ (void)infoArchive; //iofo归档
+ (void)powerArchive; //iofo归档

+ (void)ClearModel;

@end
