//
//  GZQFilterView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^GZQFilterViewTagBlock)(NSInteger idx);

typedef void(^GZQFilterViewConfirmBlock)(NSDictionary *dic);

@interface GZQFilterView : UIView

@property (nonatomic, strong) UILabel *regiterBeginL;

@property (nonatomic, strong) DropBtn *regiterBeginBtn;

@property (nonatomic, strong) UILabel *regiterEndL;

@property (nonatomic, strong) DropBtn *regiterEndBtn;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) DropBtn *levelBtn;

@property (nonatomic, strong) UILabel *followBeginL;

@property (nonatomic, strong) DropBtn *followBeginBtn;

@property (nonatomic, strong) UILabel *followEndL;

@property (nonatomic, strong) DropBtn *followEndBtn;

@property (nonatomic, copy) GZQFilterViewTagBlock GzqFilterViewTagBlock;

@property (nonatomic, copy) GZQFilterViewConfirmBlock GzqFilterViewConfirmBlock;

@end

NS_ASSUME_NONNULL_END
