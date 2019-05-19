//
//  RotationCell.h
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, KRotationState){
    A_TYPE=1, //b位
    B_TYPE=2, //a位
    WAIT_TYPE=8, //等待
    REST_TYPE=9, //休假
};

@interface RotationCell : UICollectionViewCell

@property (nonatomic , strong) UIButton *headBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic , assign) KRotationState rotationState;

-(void)ConfigCellByType:(KRotationState)type
                  Title:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
