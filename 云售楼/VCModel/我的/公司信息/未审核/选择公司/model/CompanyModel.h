//
//  CompanyModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@interface CompanyModel : BaseModel

@property (nonatomic, copy) NSString *absolute_address;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *company_id;

@property (nonatomic, copy) NSString *company_name;

@property (nonatomic, copy) NSString *contact;

@property (nonatomic, copy) NSString *contact_tel;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, copy) NSString *province;

@end
