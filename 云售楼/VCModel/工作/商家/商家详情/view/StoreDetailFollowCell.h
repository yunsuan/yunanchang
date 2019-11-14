//
//  StoreDetailFollowCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/11/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailFollowCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *stageL;

@end

NS_ASSUME_NONNULL_END
