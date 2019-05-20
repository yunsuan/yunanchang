//
//  AddCompanyCell.h
//  云售楼
//
//  Created by xiaoq on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddCompanyCell : UICollectionViewCell
@property (nonatomic, copy) void (^deleteBtnBlock)(NSUInteger );

@property(nonatomic, strong) UILabel *displayLabel;

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UIButton *cancelBtn;

-(void)setstylebytype:(NSString *)type andsetlab:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
