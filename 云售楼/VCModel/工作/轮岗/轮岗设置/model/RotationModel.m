//
//  RotationModel.m
//  云售楼
//
//  Created by xiaoq on 2019/5/21.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationModel.h"

@implementation RotationModel

-(void)setModelBydic:(NSMutableDictionary *)dic{
    self.company_name = dic[@"company_name"];
    self.company_id= dic[@"company_id"];
    self.contact = dic[@"contact"];
    self.contact_tel = dic[@"contact_tel"];
    self.logo = dic[@"logo"];
    if (dic[@"list"]) {
        self.list = dic[@"list"];
    }
    else{
        self.list =[@[] mutableCopy];
    }
}
@end
