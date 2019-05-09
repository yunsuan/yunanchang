//
//  UserModel.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "baseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : BaseModel

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *passWord;

@property (nonatomic, strong) NSString *agent_id;

@property (nonatomic, strong) NSMutableDictionary *company_info;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSString *user_state;

+ (UserModel *)defaultModel;

@end

NS_ASSUME_NONNULL_END
