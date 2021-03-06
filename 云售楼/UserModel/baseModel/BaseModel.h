//
//  BaseModel.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (NSMutableDictionary *)modeltodic;

@end

NS_ASSUME_NONNULL_END
