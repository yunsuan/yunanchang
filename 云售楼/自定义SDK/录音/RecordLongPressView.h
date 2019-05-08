//
//  RecordLongPressView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RecordLongPressViewBlock)(void);

@interface RecordLongPressView : UIView

@property (nonatomic, copy) RecordLongPressViewBlock recordLongPressViewBlock;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *remainL;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

- (void)startRecord;

- (void)stopAction;

@end

NS_ASSUME_NONNULL_END
