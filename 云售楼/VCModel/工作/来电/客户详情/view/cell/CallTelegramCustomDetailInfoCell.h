//
//  CallTelegramCustomDetailInfoCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/15.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CallTelegramCustomDetailInfoCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIButton *editBtn;

@end

NS_ASSUME_NONNULL_END
