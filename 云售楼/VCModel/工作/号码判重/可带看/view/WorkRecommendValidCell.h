//
//  WorkRecommendValidCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WorkRecommendValidCellBlock)(NSInteger index);

@interface WorkRecommendValidCell : UITableViewCell

@property (nonatomic, copy) WorkRecommendValidCellBlock workRecommendValidCellBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *confirmL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *useDic;

@property (nonatomic, strong) NSMutableDictionary *inValidDic;

@end

NS_ASSUME_NONNULL_END
