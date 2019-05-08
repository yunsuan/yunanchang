//
//  KyoCinameSeatScrollView.h
//  云算
//
//  Created by xiaoq on 2017/3/31.
//  Copyright © 2017年 xiaoqcd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KyoCinameSeatStateNormal = 0,    //正常
    KyoCinameSeatStateHadBuy = 1,   //已被购买
    KyoCinameSeatStateSelected = 2, //已选择
    KyoCinameSeatStateUnexist = 3,   //不存在
    KyoCinameSeatStateLoversLeftNormal = 4, //情侣左正常
    KyoCinameSeatStateLoversLeftHadBuy = 5, //情侣左已被购买
    KyoCinameSeatStateLoversLeftSelected = 6, //情侣左已选择
    KyoCinameSeatStateLoversRightNormal = 7, //情侣右正常
    KyoCinameSeatStateLoversRightHadBuy = 8, //情侣右已被购买
    KyoCinameSeatStateLoversRightSelected = 9 //情侣右已选择
} KyoCinameSeatState;   //座位状态

typedef enum : NSInteger {
    KyoCinameSeatRowIndexTypeNumber = 0,    //默认，显示数字
    KyoCinameSeatRowIndexTypeLetter = 1,    //显示字母
}KyoCinameSeatRowIndexType; //座位左边行号提示样式

@protocol KyoCinameSeatScrollViewDelegate;

IB_DESIGNABLE

@protocol KyoCinameSeatScrollViewDelegate <NSObject>

@optional
- (KyoCinameSeatState)kyoCinameSeatScrollViewSeatStateWithRow:(NSUInteger)row withColumn:(NSUInteger)column;
- (void)kyoCinameSeatScrollViewDidTouchInSeatWithRow:(NSUInteger)row withColumn:(NSUInteger)column;

@end
