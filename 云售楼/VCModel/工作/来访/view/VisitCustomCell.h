//
//  VisitCustomCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/6/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VisitCustomCellBlock)(void);

@interface VisitCustomCell : UITableViewCell

@property (nonatomic, copy) VisitCustomCellBlock visitCustomCellBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
