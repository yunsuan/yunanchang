//
//  ChangeNameVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ChangeNameVCBlock)(NSString *str);

@interface ChangeNameVC : BaseViewController

@property (nonatomic, copy) ChangeNameVCBlock changeNameVCBlock;

- (instancetype)initWithName:(NSString *)name;

@end
