//
//  RecordView.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
//#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RecordViewBlock)(void);

@interface RecordView : UIView

@property (nonatomic, copy) RecordViewBlock recordViewBlock;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *remainL;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

- (void)startRecord;

- (void)stopAction;

@end

NS_ASSUME_NONNULL_END
