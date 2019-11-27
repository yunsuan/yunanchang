


//  RecordView.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RecordView.h"

@interface RecordView ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    
    NSTimer *_recordTimer;//录音计时器
    NSInteger _recordSecond;//录音时间
    AVAudioPlayer *_player;
    NSInteger _playSecond;//播放时间
}
@end

@implementation RecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
        [self startRecord];
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
            
            
        }else{
            
            [_recorder stop];
            _recorder = nil;
            [_recordTimer invalidate];
            [MBProgressHUD showError:@"录音创建失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self removeFromSuperview];
            });
            
        }
    }else {
        
        [_recorder stop];
        _recorder = nil;
        [_recordTimer invalidate];
        [MBProgressHUD showError:@"录音创建失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self removeFromSuperview];
        });
    }
}

//停止录音
- (void)stopAction {
    //停止录音
    
    
    [_recorder stop];
    _recorder = nil;
    [_recordTimer invalidate];
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/aaa"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [data writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp/aaa"] atomically:YES];
    
 
    
//      NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
////    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"selfRecord.wav"];
//    NSURL* url = [NSURL fileURLWithPath:recordUrl];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    [data writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"selfRecord.wav"] atomically:YES];
    
    
    [self removeFromSuperview];
    if (self.recordViewBlock) {
        
        self.recordViewBlock();
    }
}

//播放录音
- (void)playAction {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//    NSError *playError;
    
//    NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSURL *tmpUrl = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.wav"]];
    
//    NSString *recordUrl = [NSHomeDirectory() stringByAppendingString:@"selfRecord.wav"];
//    NSURL *tmpUrl = [NSURL URLWithString:recordUrl];
    
//    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_tmpFile error:&playError];
    //当播放录音为空, 打印错误信息
    if (_player == nil) {
        
        
    }else {
        
        _player.delegate = self;
        
        //开始播放
        _playSecond = _recordSecond;
        if ([_player prepareToPlay] == YES) {
            
            [_player play];
        }
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
        

- (void)initUI{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSettings setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
    
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:1] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    
    [recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/aaa"];
    NSURL* url = [NSURL fileURLWithPath:path];
    
//    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
//
    NSError *error = nil;
//    NSString *recordUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
////    NSURL *tmpUrl = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.wav"]];
//    _tmpFile = [NSURL URLWithString:[recordUrl stringByAppendingPathComponent:@"selfRecord.wav"]];
    //    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"selfRecord.wav"];
//    NSURL *tmpUrl = [NSURL fileURLWithPath:path];
//    NSString *recordUrl = [NSHomeDirectory() stringByAppendingString:@"selfRecord.wav"];
//    NSURL *tmpUrl = [NSURL URLWithString:recordUrl];
    
    self.recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSettings error:&error];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = CLBlackColor;
    alphaView.alpha = 0.3;
    [self addSubview:alphaView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(62 *SIZE, 200 *SIZE, 260 *SIZE, 215 *SIZE)];
    _backView.backgroundColor = CLWhiteColor;
    [self addSubview:_backView];
    
    _remainL = [[UILabel alloc] initWithFrame:CGRectMake(0, 65 *SIZE, 260 *SIZE, 14 *SIZE)];
    _remainL.textColor = CLBlackColor;
    _remainL.font = [UIFont boldSystemFontOfSize:14 *SIZE];
    _remainL.textAlignment = NSTextAlignmentCenter;
    _remainL.text = @"剩余录音时间：30秒";
    [_backView addSubview:_remainL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15 *SIZE, 158 *SIZE, 230 *SIZE, 44 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"完成录音" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueTagColor];
    _confirmBtn.layer.cornerRadius = 4 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_backView addSubview:_confirmBtn];
}


@end
