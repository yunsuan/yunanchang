//
//  PowerMannerger.m
//  云售楼
//
//  Created by xiaoq on 2019/5/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PowerMannerger.h"


@implementation PowerMannerger

+(void)RequestPowerByprojectID:(NSString *)project_id success:(nonnull void (^)(NSString * _Nonnull))success failure:(nonnull void (^)(NSString * _Nonnull))failure
{
    
    [BaseRequest GET:PersonProjectRoleProjectPower_URL parameters:@{@"project_id":project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
//            [UserModel defaultModel].projectPowerDic = resposeObject[@"data"];
            [self GetWorkListPowerWithdata:resposeObject[@"data"]];
            success(@"获取权限成功");
            
        }else{
            failure(resposeObject[@"msg"]);
        }
    } failure:^(NSError * _Nonnull error) {
        failure(@"网络错误");
    }];
}


//初始化工作列表权限
+(void)GetWorkListPowerWithdata:(NSDictionary *)datadic{
    NSMutableArray * WorkListPower =[@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    if (datadic) {
        
//        [WorkListPower replaceObjectAtIndex:10 withObject:@1];
//        [WorkListPower replaceObjectAtIndex:5 withObject:@1];
//        [WorkListPower replaceObjectAtIndex:6 withObject:@1];
//        [WorkListPower replaceObjectAtIndex:7 withObject:@1];
        
        if ([datadic[@"is_butter"] boolValue]) {
            [WorkListPower replaceObjectAtIndex:1 withObject:@1];
            [WorkListPower replaceObjectAtIndex:2 withObject:@1];
        }
        if ([datadic[@"duty_operate"] boolValue]) {
            [WorkListPower replaceObjectAtIndex:9 withObject:@1];
        }
        if (datadic[@"trade_app_operate"]) {
            
            if ([datadic[@"trade_app_operate"] isKindOfClass:[NSArray class]]) {
                
                for (int i = 0; i < [datadic[@"trade_app_operate"] count]; i++) {
                    
                    if ([datadic[@"trade_app_operate"][i][@"type"] isEqualToString:@"商家信息"]) {
                        
                        if ([datadic[@"trade_app_operate"][i][@"detail"] integerValue] == 1) {

                            [PowerModel defaultModel].storePower = [datadic[@"trade_app_operate"][i] copy];
                            [WorkListPower replaceObjectAtIndex:10 withObject:@1];
                        }
                    }else if ([datadic[@"trade_app_operate"][i][@"type"] isEqualToString:@"意向商家"]){
                        
                        if ([datadic[@"trade_app_operate"][i][@"detail"] integerValue] == 1) {

                            [PowerModel defaultModel].intentStorePower = [datadic[@"trade_app_operate"][i] copy];
                            [WorkListPower replaceObjectAtIndex:11 withObject:@1];
                        }
                    }else if ([datadic[@"trade_app_operate"][i][@"type"] isEqualToString:@"定租商家"]){
                        
                        if ([datadic[@"trade_app_operate"][i][@"detail"] integerValue] == 1) {

                            [PowerModel defaultModel].orderStorePower = [datadic[@"trade_app_operate"][i] copy];
                            [WorkListPower replaceObjectAtIndex:12 withObject:@1];
                        }
                    }else if ([datadic[@"trade_app_operate"][i][@"type"] isEqualToString:@"签租商家"]){
                        
                        if ([datadic[@"trade_app_operate"][i][@"detail"] integerValue] == 1) {

                            [PowerModel defaultModel].signStorePower = [datadic[@"trade_app_operate"][i] copy];
                            [WorkListPower replaceObjectAtIndex:13 withObject:@1];
                        }
                    }
                }
            }
        }
//        if ([datadic[@"person_check"] boolValue]) {
//            [WorkListPower replaceObjectAtIndex:8 withObject:@1];
//        }
        NSArray *arr = datadic[@"app_operate"];
        for (int i = 0 ; i < arr.count; i++) {
            if ([arr[i][@"detail"] integerValue] == 1) {
                if (i==0) {
                    [WorkListPower replaceObjectAtIndex:0 withObject:@1];
                }
                else if(i==1){
                    [WorkListPower replaceObjectAtIndex:3 withObject:@1];
                }else if (i == 5){
                    
                    [WorkListPower replaceObjectAtIndex:4 withObject:@1];
                }else if (i == 6){
                    
                    [WorkListPower replaceObjectAtIndex:5 withObject:@1];
                }else if (i == 7){
                    
                    [WorkListPower replaceObjectAtIndex:6 withObject:@1];
                }
            }
        }
    }
    for (int i = 0; i < 10; i++) {
        
        if ([WorkListPower[i] integerValue] == 1) {
            
            [WorkListPower replaceObjectAtIndex:14 withObject:@1];
        }
    }
    [PowerModel defaultModel].WorkListPower = [WorkListPower copy];
    
    //报表
    NSMutableArray * ReportListPower =[@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];//,@0,@0] mutableCopy];
    if (datadic) {
        NSArray *arr = datadic[@"app_operate"];
        if (arr.count > 2) {
            
            NSDictionary *dic = arr[2];
            if ([dic[@"report"][@"FYSMXXB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:11 withObject:@1];
            }
            if ([dic[@"report"][@"LDKHFXB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:0 withObject:@1];
            }
            if ([dic[@"report"][@"LFKHFXB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:1 withObject:@1];
            }
            if ([dic[@"report"][@"QDFXB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:2 withObject:@1];
            }
            if ([dic[@"report"][@"SKTJB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:8 withObject:@1];
            }
            if ([dic[@"report"][@"XSMXB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:5 withObject:@1];
            }
            if ([dic[@"report"][@"XSPMB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:7 withObject:@1];
            }
            if ([dic[@"report"][@"XSYHZB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:10 withObject:@1];
            }
            if ([dic[@"report"][@"XSZHZB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:9 withObject:@1];
            }
            if ([dic[@"report"][@"ZYPDB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:6 withObject:@1];
            }
            if ([dic[@"report"][@"CJKHFXB"][@"detail"] integerValue] == 1) {
                
                [ReportListPower replaceObjectAtIndex:4 withObject:@1];
            }
            if (arr.count > 3) {
                
                NSDictionary *dic = arr[3];
                if ([dic[@"detail"] integerValue] == 1) {
                    
                    [ReportListPower replaceObjectAtIndex:3 withObject:@1];
                }
            }
        }else{
            
            
        }
    }
    [PowerModel defaultModel].ReportListPower = [ReportListPower copy];
    [PowerModel defaultModel].telCallPower = [datadic[@"app_operate"][0] copy];
    [PowerModel defaultModel].visitPower = [datadic[@"app_operate"][1] copy];
//    [PowerModel defaultModel].visitReport = [datadic[@"app_operate"][2] copy];
//    [PowerModel defaultModel].channelReport = [datadic[@"app_operate"][3] copy];
    [UserModelArchiver powerArchive];

}

@end
