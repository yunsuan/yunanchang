//
//  PowerMannerger.h
//  云售楼
//
//  Created by xiaoq on 2019/5/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PowerMannerger : NSObject

+(void)RequestPowerByprojectID:(NSString *)project_id success:(void(^)(NSString * result))success failure:(void(^)(NSString *error))failure;//网络

//+(void)GetWorkListPower;//初始化工作列表权限

@end

NS_ASSUME_NONNULL_END
