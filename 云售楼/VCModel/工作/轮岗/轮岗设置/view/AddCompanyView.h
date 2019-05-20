//
//  AddCompanyView.h
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AddBtnBlock)(void);

typedef void(^DeletBtnBlock)(void);

@interface AddCompanyView : UIView
@property (nonatomic, copy) AddBtnBlock addBtnBlock;

@property (nonatomic, copy) DeletBtnBlock deletBtnBlock;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) NSMutableArray *dataArr;


@end

NS_ASSUME_NONNULL_END
