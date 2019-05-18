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

+ (void)archive {
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserModel defaultModel] toFile:[self archivePath]];
    if (!flag) {
        //        NSLog(@"归档失败!");
    }
}


+ (void)infoArchive{
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserInfoModel defaultModel] toFile:[self infoArchivePath]];
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

+(void)ClearUserInfoModel
{
    BOOL flag = [NSKeyedArchiver archiveRootObject:[[UserInfoModel alloc]init] toFile:[self infoArchivePath]];
    if (!flag) {
        //        NSLog(@"清空用户信息失败!");
    }
}

@end
