//
//  UserModelArchiver.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

//#import "UserModelArchiver.h"

@implementation UserModelArchiver

+ (UserModel *)unarchive {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
}


+ (UserInfoModel *)InfoUnarchive {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self infoArchivePath]];
}


+ (PowerModel *)PowerUnarchive {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self powerArchivePath]];
}


+ (void)archive {
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserModel defaultModel] toFile:[self archivePath]];
    if (!flag){
        //        NSLog(@"归档失败!");
    }
}


+ (void)infoArchive{
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserInfoModel defaultModel] toFile:[self infoArchivePath]];
    if (!flag) {
        //        NSLog(@"归档失败!");
    }
}

+ (void)powerArchive{
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[PowerModel defaultModel] toFile:[self powerArchivePath]];
    if (!flag) {
        //        NSLog(@"归档失败!");
    }
}

+ (NSString *)infoArchivePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *basePath = paths.firstObject;
    
    return [basePath stringByAppendingPathComponent:@"UserInfoModel.dat"];
}

+ (NSString *)archivePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *basePath = paths.firstObject;
    
    return [basePath stringByAppendingPathComponent:@"UserModel.dat"];
    
}

+ (NSString *)powerArchivePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *basePath = paths.firstObject;
    
    return [basePath stringByAppendingPathComponent:@"PowerModel.dat"];
    
}


+(void)ClearModel
{
    //清空Userinfo;
    BOOL flag = [NSKeyedArchiver archiveRootObject:[[UserInfoModel alloc]init] toFile:[self infoArchivePath]];
    [UserInfoModel resetModel];
    if (!flag) {
        //        NSLog(@"归档失败!");
    }
    
    //清空Userinfo;
    BOOL flag1 = [NSKeyedArchiver archiveRootObject:[[PowerModel alloc]init] toFile:[self powerArchivePath]];
    [UserInfoModel resetModel];
    if (!flag1) {
        //        NSLog(@"归档失败!");
    }
    
    [UserModel defaultModel].token =@"";
    [UserModel defaultModel].agent_id = @"";
    [UserModel defaultModel].user_state = @"";
    [UserModel defaultModel].agent_company_info_id = @"";
    [UserModel defaultModel].company_id = @"";
    [UserModel defaultModel].company_name = @"";
    [UserModel defaultModel].company_state = @"";
    [UserModel defaultModel].ex_state = @"";
    [UserModel defaultModel].project_list = @[];
    [UserModel defaultModel].projectinfo = @{};
    [UserModel defaultModel].Configdic = @{};
//    [UserModel defaultModel].projectPowerDic = @{};
    BOOL flag2 = [NSKeyedArchiver archiveRootObject:[UserInfoModel defaultModel] toFile:[self infoArchivePath]];
    if (!flag2) {
        //        NSLog(@"归档失败!");
    }
}

@end
