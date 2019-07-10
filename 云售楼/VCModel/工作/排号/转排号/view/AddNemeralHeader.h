//
//  AddNemeralHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNemeralHeaderMoreBlock)(void);

@interface AddNemeralHeader : UIView

@property (nonatomic, copy) AddNemeralHeaderMoreBlock addNemeralHeaderMoreBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
