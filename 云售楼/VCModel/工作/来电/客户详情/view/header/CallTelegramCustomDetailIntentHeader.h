//
//  CallTelegramCustomDetailIntentHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallTelegramCustomDetailIntentHeaderEditBlock)(NSInteger index);

typedef void(^CallTelegramCustomDetailIntentHeaderDeleteBlock)(NSInteger index);

@interface CallTelegramCustomDetailIntentHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) CallTelegramCustomDetailIntentHeaderEditBlock callTelegramCustomDetailIntentHeaderEditBlock;

@property (nonatomic, copy) CallTelegramCustomDetailIntentHeaderDeleteBlock callTelegramCustomDetailIntentHeaderDeleteBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END
