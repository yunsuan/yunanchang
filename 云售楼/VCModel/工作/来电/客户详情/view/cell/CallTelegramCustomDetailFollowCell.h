//
//  CallTelegramCustomDetailFollowCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/16.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef void(^Block)(void);

@interface CallTelegramCustomDetailFollowCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *speechImg;

@property (nonatomic, strong) UILabel *nextL;

@end

NS_ASSUME_NONNULL_END
