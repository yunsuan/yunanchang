//
//  SignFailView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SignFailViewBlock)(void);

@interface SignFailView : UIView

@property (nonatomic, copy)  SignFailViewBlock signFailViewBlock;

@property (nonatomic, strong) NSString *agentId;

@property (nonatomic, strong) UITextView *markTV;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIView *nameView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *dropImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *nameBtn;

@property (nonatomic, strong) UIButton *recommendBtn;

@end

NS_ASSUME_NONNULL_END
