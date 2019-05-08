//
//  FollowRecordVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "FollowRecordVC.h"

#import <AVFoundation/AVFoundation.h>
#import "RecordView.h"
#import "RecordLongPressView.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface FollowRecordVC ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    
    AVAudioPlayer *_player;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *followPurposeL;

@property (nonatomic, strong) BorderTextField *followPurposeTF;

@property (nonatomic, strong) UILabel *followWayL;

@property (nonatomic, strong) UIButton *telBtn;

@property (nonatomic, strong) UIButton *netBtn;

@property (nonatomic, strong) UIButton *faceBtn;

@property (nonatomic, strong) UIButton *otherBtn;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) UIButton *aBtn;

@property (nonatomic, strong) UIButton *bBtn;

@property (nonatomic, strong) UIButton *cBtn;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UITextView *contentView;

@property (nonatomic, strong) UIButton *recordBtn;

@property (nonatomic, strong) UIImageView *recordImg;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) DropBtn *nextTimeBtn;

@property (nonatomic, strong) UILabel *remindTimeL;

@property (nonatomic, strong) DropBtn *remindTimeBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation FollowRecordVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag < 4) {
        
        _telBtn.selected = NO;
        _netBtn.selected = NO;
        _faceBtn.selected = NO;
        _otherBtn.selected = NO;
        if (btn.tag == 0) {
            
            _telBtn.selected = YES;
        }else if (btn.tag == 1){
            
            _netBtn.selected = YES;
        }else if (btn.tag == 2){
            
            _faceBtn.selected = YES;
        }else{
            
            _otherBtn.selected = YES;
        }
    }else{
        
        _aBtn.selected = NO;
        _bBtn.selected = NO;
        _cBtn.selected = NO;
        if (btn.tag == 4) {
            
            _aBtn.selected = YES;
        }else if (btn.tag == 5){
            
            _bBtn.selected = YES;
        }else{
            
            _cBtn.selected = YES;
        }
    }
}

- (void)ActionRecordBtn:(UIButton *)btn{
    
//    RecordView *view = [[RecordView alloc] initWithFrame:self.view.bounds];
//    view.recordViewBlock = ^{
//
//        self->_playBtn.hidden = NO;
//        [self->_nextTimeL mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
//            make.top.equalTo(self->_playBtn.mas_bottom).offset(25 *SIZE);
//            make.width.mas_equalTo(70 *SIZE);
//        }];
//
//        [self->_nextTimeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
//            make.top.equalTo(self->_playBtn.mas_bottom).offset(15 *SIZE);
//            make.width.mas_equalTo(258 *SIZE);
//            make.height.mas_equalTo(33 *SIZE);
//        }];
//    };
//    [self.view addSubview:view];
//    [view startRecord];
    RecordLongPressView *view = [[RecordLongPressView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
}

- (void)ActionPlayBtn:(UIButton *)btn{
    
    
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
        [_player stop];
        //开始播放
        if ([_player prepareToPlay] == YES) {

            [_player play];

        }
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    
    
}

//- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
//
//    //获取当前录音时长
//    float voiceSize = recorder.currentTime;
//
//    NSLog(@"录音时长 = %f",voiceSize);
//
//    if(voiceSize < 1){
//        [recorder deleteRecording];
//        UIAlertView * altView = [[UIAlertView alloc]initWithTitle:nil
//                                                          message:@"时长小于3秒，重新录制" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//        [altView show];
//
////        [self performSelector:@selector(performDismiss:) withObject:altView afterDelay:1.5];
//
//    }else if (voiceSize > 60){
//
//        [recorder deleteRecording];
//        UIAlertView * altView = [[UIAlertView alloc]initWithTitle:nil
//                                                          message:@"时长大于1分钟，重新录制" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//        [altView show];
//
////        [self performSelector:@selector(performDismiss:) withObject:altView afterDelay:1.5];
//    }
//
//    [recorder stop];
//}

- (void)initUI{
    
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    
    NSArray *titleArr = @[@"跟进目的：",@"跟进方式：",@"客户等级：",@"跟进内容：",@"下次跟进：",@"提醒日期"];
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLBlackColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:14 *SIZE];
        switch (i) {
            case 0:
            {
                _followPurposeL = label;
                [self.view addSubview:_followPurposeL];
                break;
            }
            case 1:
            {
    
                _followWayL = label;
                [self.view addSubview:_followWayL];
                break;
            }
            case 2:
            {
                _levelL = label;
                [self.view addSubview:_levelL];
                break;
            }
            case 3:
            {
                _contentL = label;
                [self.view addSubview:_contentL];
                break;
            }
            case 4:
            {
                _nextTimeL = label;
                [self.view addSubview:_nextTimeL];
                break;
            }
            case 5:
            {
                _remindTimeL = label;
                [self.view addSubview:_remindTimeL];
                break;
            }
            default:
                break;
        }
    }
    
    _followPurposeTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _followPurposeTF.textField.placeholder = @"请输入跟进目的";
    [_scrollView addSubview:_followPurposeTF];
    
    _contentView = [[UITextView alloc] init];
    _contentView.layer.cornerRadius = 4 *SIZE;
    _contentView.layer.borderWidth = SIZE;
    _contentView.layer.borderColor = _followPurposeTF.layer.borderColor;
    _contentView.clipsToBounds = YES;
    _contentView.textContainerInset = UIEdgeInsetsMake(3 *SIZE, 3 *SIZE, 5 *SIZE, 30 *SIZE);
//    _contentView.backgroundColor = CLLightGrayColor;
    _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recordBtn.frame = CGRectMake(236 *SIZE, 55 *SIZE, 14 *SIZE, 14 *SIZE);
    [_recordBtn setImage:IMAGE_WITH_NAME(@"voice_3") forState:UIControlStateNormal];
    [_recordBtn addTarget:self action:@selector(ActionRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_recordBtn];
    [_scrollView addSubview:_contentView];
    
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn addTarget:self action:@selector(ActionPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    _recordImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 190 *SIZE, 20 *SIZE)];
    _recordImg.image = IMAGE_WITH_NAME(@"voice_2");
    [_playBtn addSubview:_recordImg];
    _playBtn.hidden = YES;
    [_scrollView addSubview:_playBtn];
    
    
    NSArray *btnArr = @[@"电话",@"网络",@"面谈",@"其他",@"A",@"B",@"C"];
    for (int i = 0; i < 7; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:CL95Color forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"default") forState:UIControlStateNormal];
        [btn setImage:IMAGE_WITH_NAME(@"selected") forState:UIControlStateSelected];
        switch (i) {
            case 0:
            {
                _telBtn = btn;
                [_scrollView addSubview:_telBtn];
                break;
            }
            case 1:
            {
                _netBtn = btn;
                [_scrollView addSubview:_netBtn];
                break;
            }
            case 2:
            {
                _faceBtn = btn;
                [_scrollView addSubview:_faceBtn];
                break;
            }
            case 3:
            {
                _otherBtn = btn;
                [_scrollView addSubview:_otherBtn];
                break;
            }
            case 4:
            {
                _aBtn = btn;
                [_scrollView addSubview:_aBtn];
                break;
            }
            case 5:
            {
                _bBtn = btn;
                [_scrollView addSubview:_bBtn];
                break;
            }
            case 6:
            {
                _cBtn = btn;
                [_scrollView addSubview:_cBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _remindTimeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _remindTimeBtn.placeL.text = @"选择日期";
    [_scrollView addSubview:_remindTimeBtn];
    
    _nextTimeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _nextTimeBtn.placeL.text = @"选择跟进日期";
    [_scrollView addSubview:_nextTimeBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchDown];
    [_confirmBtn setTitle:@"确认完成" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueTagColor];
    _confirmBtn.layer.cornerRadius = 5 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [self.view addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.equalTo(self.view.mas_bottom).offset(-43 *SIZE - TAB_BAR_MORE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_followPurposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(37 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_followPurposeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(27 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_followWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_followPurposeTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_followPurposeTF.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_netBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(150 *SIZE);
        make.top.equalTo(self->_followPurposeTF.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(220 *SIZE);
        make.top.equalTo(self->_followPurposeTF.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(290 *SIZE);
        make.top.equalTo(self->_followPurposeTF.mas_bottom).offset(27 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_telBtn.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_aBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_telBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_bBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(150 *SIZE);
        make.top.equalTo(self->_telBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];
    
    [_cBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(220 *SIZE);
        make.top.equalTo(self->_telBtn.mas_bottom).offset(25 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(23 *SIZE);
    }];

    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_aBtn.mas_bottom).offset(41 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_aBtn.mas_bottom).offset(41 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_contentView.mas_bottom).offset(14 *SIZE);
        make.width.mas_equalTo(190 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_nextTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_contentView.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nextTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_contentView.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_remindTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nextTimeBtn.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_remindTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_nextTimeBtn.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-28 *SIZE);
    }];
}

@end
