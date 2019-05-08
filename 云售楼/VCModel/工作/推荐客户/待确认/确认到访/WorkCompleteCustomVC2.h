//
//  WorkCompleteCustomVC2.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkCompleteCustomVC2 : BaseViewController

@property (nonatomic , strong) NSDictionary *datadic;

@property (nonatomic, strong) NSMutableDictionary *consulDic;

- (instancetype)initWithData:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
