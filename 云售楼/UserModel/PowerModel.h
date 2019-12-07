//
//  PowerModel.h
//  云售楼
//
//  Created by xiaoq on 2019/5/23.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PowerModel : NSObject

@property (nonatomic , strong) NSArray *WorkListPower;
@property (nonatomic , strong) NSDictionary *telCallPower;//来电权限
@property (nonatomic , strong) NSDictionary *visitPower;//来访权限
@property (nonatomic , strong) NSDictionary *storePower;//商家权限
@property (nonatomic , strong) NSDictionary *intentStorePower;//意向商家权限
@property (nonatomic , strong) NSDictionary *orderStorePower;//定租商家权限
@property (nonatomic , strong) NSDictionary *signStorePower;//签租商家权限
@property (nonatomic , strong) NSArray *ReportListPower;
@property (nonatomic, strong) NSDictionary *visitReport; //来访报表
@property (nonatomic, strong) NSDictionary *channelReport; //来访报表

+ (PowerModel *)defaultModel;
+ (void)resetModel;
@end

NS_ASSUME_NONNULL_END
