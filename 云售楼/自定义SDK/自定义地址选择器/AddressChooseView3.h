//
//  AddressChooseView3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressChooseView2;

typedef void(^AddressChooseView3ConfirmBlock)(NSString * city, NSString * area,NSString * cityid,NSString *areaid);

typedef void(^AddressChooseView3CancelBlock)(void);

@interface AddressChooseView3 : UIView

@property(nonatomic, copy) AddressChooseView3ConfirmBlock addressChooseView3ConfirmBlock;

//@property (nonatomic, copy) AddressChooseView3CancelBlock addressChooseView3CancelBlock;

- (instancetype)initWithFrame:(CGRect)frame withdata:(NSArray *)data;

@end
