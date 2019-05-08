//
//  MineHeader.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineHeaderImgBlock)(void);

typedef void(^MineHeaderNameBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface MineHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, copy) MineHeaderImgBlock mineHeaderImgBlock;

@property (nonatomic, copy) MineHeaderNameBlock mineHeaderNameBlock;

@property (nonatomic, strong) UIImageView *backImg;

@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

//@property (nonatomic, strong) UIView *nameLine;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
