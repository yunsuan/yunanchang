//
//  UserModelArchiver.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "UserModelArchiver.h"

@implementation UserModelArchiver

+ (UserModel *)unarchive {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
}


//+ (UserInfoModel *)InfoUnarchive {
//    
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self infoArchivePath]];
//}

+ (void)archive {
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserModel defaultModel] toFile:[self archivePath]];
    if (!flag) {
        //        NSLog(@"归档失败!");
    }
}


+ (void)infoArchive{
    
//    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserInfoModel defaultModel] toFile:[self infoArchivePath]];
//    if (!flag) {
//        //        NSLog(@"归档失败!");
//    }
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
//    BOOL flag = [NSKeyedArchiver archiveRootObject:[[UserInfoModel alloc]init] toFile:[self infoArchivePath]];
//    if (!flag) {
//        //        NSLog(@"清空用户信息失败!");
//    }
}

@end
