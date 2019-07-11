//
//  SelectPerferCollCell.h
//  云售楼
//
//  Created by 谷治墙 on 2019/7/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectPerferCollCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UILabel *describeL;

@property (nonatomic, strong) UILabel *cumulativeL;

@property (nonatomic, strong) UILabel *perferL;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
