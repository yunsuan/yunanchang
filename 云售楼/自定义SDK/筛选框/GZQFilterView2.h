//
//  GZQFilterView2.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^GZQFilterView2TagBlock)(NSInteger idx);

typedef void(^GZQFilterView2ConfirmBlock)(NSDictionary *dic);

@interface GZQFilterView2 : UIView

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) DropBtn *levelBtn;

@property (nonatomic, strong) UILabel *followBeginL;

@property (nonatomic, strong) DropBtn *followBeginBtn;

@property (nonatomic, strong) UILabel *followEndL;

@property (nonatomic, strong) DropBtn *followEndBtn;

@property (nonatomic, strong) UILabel *needFollowL;

@property (nonatomic, strong) DropBtn *needFollowBtn;

@property (nonatomic, copy) GZQFilterView2TagBlock GzqFilterView2TagBlock;

@property (nonatomic, copy) GZQFilterView2ConfirmBlock GzqFilterView2ConfirmBlock;

@end

NS_ASSUME_NONNULL_END
