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

@property (nonatomic, strong) NSString *loginAccount;

@property (nonatomic, strong) NSString *passWord;

@property (nonatomic, strong) NSString *agent_id;

@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSString *user_state;

@property (nonatomic, strong) NSString *agent_company_info_id;
@property (nonatomic, strong) NSString *company_id;
@property (nonatomic, strong) NSString *company_name;
@property (nonatomic, strong) NSString *company_state;
@property (nonatomic, strong) NSString *ex_state;
@property (nonatomic, strong) NSArray *project_list;
@property (nonatomic, strong) NSDictionary *projectinfo;
@property (nonatomic, strong) NSDictionary *Configdic;

@property (nonatomic, strong) NSMutableDictionary *projectPowerDic;

+ (UserModel *)defaultModel;

@end

NS_ASSUME_NONNULL_END
