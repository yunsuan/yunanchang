//
//  BaseRequest.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseRequest.h"

static AFHTTPSessionManager *manager;

static NSString *const kACCESSROLE = @"saleApp";

@implementation BaseRequest

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure{
    
    [MBProgressHUD showActivityMessage:@"加载中"];
    AFHTTPSessionManager *htttmanger  =   [BaseRequest sharedHttpSessionManager];
    [manager.requestSerializer setValue:[UserModel defaultModel].token forHTTPHeaderField:@"ACCESS-TOKEN"];
    [manager.requestSerializer setValue:kACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",TestBase_Net,url];
    
    [htttmanger GET:str parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue] == 200)
        {
            success(responseObject);
            return;
            
        }else if ([responseObject[@"code"] integerValue] == 401) {
            
            [MBProgressHUD showError:@"账号在其他地点登录，请重新登录！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
//                [UserModel defaultModel].Token = @"";
//                [UserModelArchiver archive];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
            });
            return;
        }else{
            
            if (![responseObject[@"msg"] isEqualToString:@"该项目暂无项目分析"] || ![responseObject[@"msg"] isEqualToString:@"未找到房源信息"]) {
                
//                [BaseRequest showConten:responseObject[@"msg"]];
            }
            
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUD];
        if (failure) {
            failure(error);
            
        }
    }];
}

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure{
    [MBProgressHUD showActivityMessage:@"加载中"];
    AFHTTPSessionManager *htttmanger  =   [BaseRequest sharedHttpSessionManager];
    [manager.requestSerializer setValue:[UserModel defaultModel].token forHTTPHeaderField:@"ACCESS-TOKEN"];
    [manager.requestSerializer setValue:kACCESSROLE forHTTPHeaderField:@"ACCESS-ROLE"];
    
    NSString *str = [NSString stringWithFormat:@"%@%@",TestBase_Net,url];
    [htttmanger POST:str parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [MBProgressHUD hideHUD];
        if ([responseObject[@"code"] integerValue] == 200)
        {
            success(responseObject);
            return ;
            
        }else if ([responseObject[@"code"] integerValue] == 401) {
            
            [MBProgressHUD showError:@"账号在其他地点登录，请重新登录！"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
//                [UserModel defaultModel].Token = @"";
//                [UserModelArchiver archive];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"goLoginVC" object:nil];
            });
            return;
        }else{
            
            success(responseObject);
            return;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        if (failure) {
            failure(error);
        }
    }];
}

+ (AFHTTPSessionManager *)sharedHttpSessionManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
    });
    return manager;
}

@end
