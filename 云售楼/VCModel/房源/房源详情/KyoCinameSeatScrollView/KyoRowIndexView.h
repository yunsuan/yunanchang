//
//  KyoRowIndexView.h
//  云算
//
//  Created by xiaoq on 2017/3/31.
//  Copyright © 2017年 xiaoqcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KyoCinameSeatScrollView.h"

@interface KyoRowIndexView : UIView

@property (nonatomic, assign) NSUInteger row;
@property (assign, nonatomic) CGFloat width;
@property (weak, nonatomic) UIColor *rowIndexViewColor;
@property (assign, nonatomic) KyoCinameSeatRowIndexType rowIndexType;
@property (strong, nonatomic) NSMutableArray *arrayRowIndex; //座位号左边行号提示（用它则忽略rowindextype）

@end
