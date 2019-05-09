//
//  UserModelArchiver.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModelArchiver : NSObject

+ (UserModel *)unarchive; //解码
//+ (UserInfoModel *)InfoUnarchive;
+ (void)archive; //归档
+ (void)infoArchive; //iofo归档
+ (void)ClearUserInfoModel;

@end

NS_ASSUME_NONNULL_END
