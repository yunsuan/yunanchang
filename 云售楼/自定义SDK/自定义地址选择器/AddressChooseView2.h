//
//  AddressChooseView2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressChooseView2;

//typedef void(^ConfirmBtnBlock)(NSString * province, NSString * city, NSString * area ,NSString *proviceid ,NSString * cityid,NSString *areaid);
typedef void(^ConfirmAreaBlock)(NSString * pro, NSString * city, NSString * area ,NSString *proviceid ,NSString * cityid,NSString *areaid);

typedef void(^CancelBtnBlock)(void);

@interface AddressChooseView2 : UIView

@property(nonatomic, copy) ConfirmAreaBlock confirmAreaBlock;

@property (nonatomic, copy) CancelBtnBlock cancelBtnBlock;

@end
