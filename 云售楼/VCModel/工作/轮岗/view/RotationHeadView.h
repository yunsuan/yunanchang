//
//  RotationHeadView.h
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RotationHeadView : UICollectionReusableView

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UIImageView *sexImg;
@property (nonatomic, strong) UILabel *beginL;
@property (nonatomic, strong) UILabel *endL;
@property (nonatomic, strong) UILabel *phoneL;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *timeL;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *companyL;
@property (nonatomic, strong) UIButton *compleBtn;





@end

NS_ASSUME_NONNULL_END
