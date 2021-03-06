//
//  RecordLongPressView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RecordLongPressView.h"

#import <AVFoundation/AVAudioSettings.h>

@interface RecordLongPressView ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    
    NSTimer *_recordTimer;//录音计时器
    NSInteger _recordSecond;//录音时间
    AVAudioPlayer *_player;
    NSInteger _playSecond;//播放时间
}

@property (nonatomic, strong) UIImageView *recordImg;

@property (nonatomic, strong) UIButton *playBtn;

@end

@implementation RecordLongPressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)startRecord{
    
    if (self.recorder) {
        //启动或者恢复记录的录音文件
        if ([self.recorder prepareToRecord] == YES) {
            [self.recorder record];
            
            _recordSecond = 0;
            _recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(recordSecondChange) userInfo:nil repeats:YES];
            [_recordTimer fire];
        }
        
    }else {
        NSLog(@"录音创建失败");
    }
}

//停止录音
- (void)stopAction {
    NSLog(@"停止录音");
    //停止录音
    [_recorder stop];
    _recorder = nil;
    [_recordTimer invalidate];
    
//    [self removeFromSuperview];
    if (self.recordLongPressViewBlock) {
        
        self.recordLongPressViewBlock();
    }
}

//播放录音
- (void)playAction {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSError *playError;
    
    NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL *tmpUrl = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.caf"]];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:tmpUrl error:&playError];
    //当播放录音为空, 打印错误信息
    if (_player == nil) {
        NSLog(@"Error crenting player: %@", [playError description]);
    }else {
        _player.delegate = self;
        NSLog(@"开始播放");
        //开始播放
        _playSecond = _recordSecond;
        if ([_player prepareToPlay] == YES) {
            //            playImg.userInteractionEnabled = NO;
            [_player play];
            //            playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playSecondChange) userInfo:nil repeats:YES];
            //            [playTimer fire];
        }
    }
}

- (void)PressGesture:(UITapGestureRecognizer *)sender{
    
    if ([sender state] == UIGestureRecognizerStateBegan) {
        
        [self startRecord];
    }else if ([sender state] == UIGestureRecognizerStateEnded){
        
        [self stopAction];
    }
}

- (void)ActionDoneBtn:(UIButton *)btn{
    
    [self stopAction];
}

//录音计时
- (void)recordSecondChange {
    
    if (_recordSecond < 30) {
        
        _recordSecond ++;
        _remainL.text = [NSString stringWithFormat:@"剩余录音时间:%ld秒",(30 - _recordSecond)];
    }else{
        
        [self stopAction];
    }
}

////播放录音
//- (void)playAction {
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//    NSError *playError;
//
//    NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSURL *tmpUrl = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.caf"]];
//    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:tmpUrl error:&playError];
//    //当播放录音为空, 打印错误信息
//    if (_player == nil) {
//        NSLog(@"Error crenting player: %@", [playError description]);
//    }else {
//        _player.delegate = self;
//        NSLog(@"开始播放");
//        //开始播放
//        _playSecond = _recordSecond;
//        if ([_player prepareToPlay] == YES) {
//   
//            [_player play];
//        }
//    }
//}


- (void)initUI{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    NSError *error = nil;
    NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL *tmpUrl = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.caf"]];
    
    self.recorder = [[AVAudioRecorder alloc]initWithURL:tmpUrl settings:recordSettings error:&error];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = CLBlackColor;
    alphaView.alpha = 0.3;
    [self addSubview:alphaView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0 *SIZE, SCREEN_Height - 158 *SIZE, 360 *SIZE, 158 *SIZE)];
    _backView.backgroundColor = CLWhiteColor;
    [self addSubview:_backView];
    
    _recordImg = [[UIImageView alloc] initWithFrame:CGRectMake(151 *SIZE, 18 *SIZE, 58 *SIZE, 58 *SIZE)];
    _recordImg.image = IMAGE_WITH_NAME(@"voice");
    _recordImg.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(PressGesture:)];
    longPress.minimumPressDuration = 0.5;//设置响应时间
    [_recordImg addGestureRecognizer:longPress];
    [_backView addSubview:_recordImg];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.frame = CGRectMake(85 *SIZE, 88 *SIZE, 190 *SIZE, 20 *SIZE);
    [_playBtn addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    _recordImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 190 *SIZE, 20 *SIZE)];
    _recordImg.image = IMAGE_WITH_NAME(@"voice_2");
    [_playBtn addSubview:_recordImg];
    [_backView addSubview:_playBtn];
    
    _remainL = [[UILabel alloc] initWithFrame:CGRectMake(0, 129 *SIZE, 360 *SIZE, 14 *SIZE)];
    _remainL.textColor = CLBlackColor;
    _remainL.font = [UIFont boldSystemFontOfSize:14 *SIZE];
    _remainL.textAlignment = NSTextAlignmentCenter;
    _remainL.text = @"按住说话";
    [_backView addSubview:_remainL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15 *SIZE, 158 *SIZE, 230 *SIZE, 44 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"完成录音" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueTagColor];
    _confirmBtn.layer.cornerRadius = 4 *SIZE;
    _confirmBtn.clipsToBounds = YES;
//    [_backView addSubview:_confirmBtn];
}

@end
