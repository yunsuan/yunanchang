//
//  WorkRecommendWaitCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WorkRecommendWaitCellBlock)(NSInteger index);

@interface WorkRecommendWaitCell : UITableViewCell

@property (nonatomic, copy) WorkRecommendWaitCellBlock workRecommendWaitCellBlock;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *validDic;

@property (nonatomic, strong) NSMutableDictionary *failDic;

@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
