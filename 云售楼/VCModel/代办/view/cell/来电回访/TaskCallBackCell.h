//
//  TaskCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskCallBackCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *readImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *customL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) NSMutableArray *dataDic;

@end

NS_ASSUME_NONNULL_END
