//
//  ModifyAndAddRentalView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropBtn.h"
#import "BorderTextField.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ModifyAndAddRentalViewBlock)(void);

typedef void(^ModifyAndAddRentalViewComfirmBtnBlock)(NSString *str);

@interface ModifyAndAddRentalView : UIView

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) DropBtn *periodBtn;

@property (nonatomic, strong) BorderTextField *periodTF;

@property (nonatomic, copy) ModifyAndAddRentalViewBlock modifyAndAddRentalViewBlock;

@property (nonatomic, copy) ModifyAndAddRentalViewComfirmBtnBlock modifyAndAddRentalViewComfirmBtnBlock;

@end

NS_ASSUME_NONNULL_END
