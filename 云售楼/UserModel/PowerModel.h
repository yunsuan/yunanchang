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

+ (PowerModel *)defaultModel;
+ (void)resetModel;
@end

NS_ASSUME_NONNULL_END
