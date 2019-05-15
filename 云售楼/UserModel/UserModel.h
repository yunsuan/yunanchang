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

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *tel;

@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *head_img;

@property (nonatomic, strong) NSString *birth;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *absolute_address;

@property (nonatomic, strong) NSString *slef_desc;

@property (nonatomic, strong) NSString *account;

@property (nonatomic, strong) NSDictionary *Configdic;

+ (UserModel *)defaultModel;

@end

NS_ASSUME_NONNULL_END
