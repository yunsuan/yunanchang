//
//  TitleRightBtnHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TitleRightBtnHeaderMoreBlock)(void);

typedef void(^TitleRightBtnHeaderAddBlock)(void);

@interface TitleRightBtnHeader : UITableViewHeaderFooterView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

@property (nonatomic, copy) TitleRightBtnHeaderMoreBlock titleRightBtnHeaderMoreBlock;

@property (nonatomic, copy) TitleRightBtnHeaderAddBlock titleRightBtnHeaderAddBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
