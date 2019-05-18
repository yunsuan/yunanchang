//
//  UserInfoModel.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/10.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : BaseModel
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

+ (UserInfoModel *)defaultModel;
@end

NS_ASSUME_NONNULL_END
