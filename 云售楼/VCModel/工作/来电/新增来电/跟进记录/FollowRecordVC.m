//
//  FollowRecordVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>

#import "FollowRecordVC.h"
#import "CallTelegramVC.h"
#import "VisitCustomVC.h"
#import "TaskVC.h"

#import "RecordView.h"
//#import "RecordLongPressView.h"
#import "DateChooseView.h"

#import "CalendarsManger.h"

#import "BoxSelectCollCell.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface FollowRecordVC ()<AVAudioRecorderDelegate,AVAudioPlayerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    AVAudioPlayer *_player;
    NSDateFormatter *_formatter;
    
    NSString *_followWay;
    NSString *_level;
    NSString *_groupId;
    
    NSArray *_followArr;
    
    NSMutableDictionary *_directDic;
    
    BOOL Isplay;
    
    NSMutableArray *_levelArr;
    NSMutableArray *_followSelectArr;
    NSMutableArray *_levelSelectArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *followPurposeL;

@property (nonatomic, strong) BorderTextField *followPurposeTF;

@property (nonatomic, strong) UILabel *followWayL;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout1;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *followWayColl;

@property (nonatomic, strong) UILabel *levelL;

@property (nonatomic, strong) UICollectionView *levelColl;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UITextView *contentView;

@property (nonatomic, strong) UIButton *recordBtn;

@property (nonatomic, strong) UIImageView *recordImg;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) DropBtn *nextTimeBtn;

@property (nonatomic, strong) UILabel *remindTimeL;

@property (nonatomic, strong) DropBtn *remindTimeBtn;

@property (nonatomic, strong) UILabel *remindPurposeL;

@property (nonatomic, strong) BorderTextField *remindPurposeTF;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation FollowRecordVC

- (instancetype)initWithGroupId:(NSString *)groupId
{
    self = [super init];
    if (self) {
        
        _groupId = groupId;
        Isplay = NO;
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FollowWay) name:@"followReload" object:nil];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    
    _directDic = [@{} mutableCopy];
    
    _followArr = [self getDetailConfigArrByConfigState:23];
//    if (!_followArr.count) {
//
//        _followArr = [self getDetailConfigArrByConfigState:23];
//    }
    _followSelectArr = [@[] mutableCopy];
    _levelSelectArr = [@[] mutableCopy];
    for (int i = 0; i < self->_followArr.count; i++) {
        
        [self->_followSelectArr addObject:@0];
    }
    _levelArr = [@[] mutableCopy];
}

- (void)FollowWay{
    
    _followArr = [self getDetailConfigArrByConfigState:23];
    [self->_followWayColl reloadData];
    [self->_followWayColl mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(self->_followWayColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":self.info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
            self->_levelArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][1]];
            for (int i = 0; i < self->_levelArr.count; i++) {
                
                [self->_levelSelectArr addObject:@0];
            }
//            self.levelColl.contentOffset = CGPointZero;
//            self.followWayColl.contentOffset = CGPointZero;
            [self->_levelColl reloadData];
            [self->_followWayColl reloadData];
            [self->_followWayColl mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(self->_followWayColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
            }];
            [self->_levelColl mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(self->_levelColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
            }];
            if ([self.status isEqualToString:@"direct"]) {
                
                self->_followPurposeTF.textField.text = self.followDic[@"follow_goal"];
//                self->_contentView.text = self.followDic[@"comment"];
                for (int i = 0; i < self->_followArr.count; i++) {
                    
                    if ([self.followDic[@"follow_way"] isEqualToString:self->_followArr[i][@"param"]]) {
                        
//                        [self->_followWayColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
                        self->_followWay = [NSString stringWithFormat:@"%@",self->_followArr[i][@"id"]];
                        [self->_followSelectArr replaceObjectAtIndex:i withObject:@1];
                    }
                }
                for (int i = 0; i < self->_levelArr.count; i++) {
                    
                    if ([self.followDic[@"level"] isEqualToString:self->_levelArr[i][@"config_name"]]) {
                        
                        self->_level = [NSString stringWithFormat:@"%@",self->_levelArr[i][@"config_id"]];
                        NSDate *newDate = [[NSDate date] dateByAddingTimeInterval:24 * 60 * 60  * [self->_levelArr[i][@"value_time"] integerValue]];
                        self->_nextTimeBtn.content.text = [NSString stringWithFormat:@"%@", [self->_formatter stringFromDate:newDate]];
                        [self->_levelSelectArr replaceObjectAtIndex:i withObject:@1];
                    }
                }
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)ActionRecordBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    
    [_contentView endEditing:YES];
    
    Isplay = YES;
    RecordView *view = [[RecordView alloc] initWithFrame:self.view.bounds];
    view. recordViewBlock = ^{

        self->_playBtn.hidden = NO;
        [self->_nextTimeL mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self->_scrollView).offset(9 *SIZE);
            make.top.equalTo(self->_playBtn.mas_bottom).offset(25 *SIZE);
            make.width.mas_equalTo(70 *SIZE);
        }];

        [self->_nextTimeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self->_scrollView).offset(80 *SIZE);
            make.top.equalTo(self->_playBtn.mas_bottom).offset(15 *SIZE);
            make.width.mas_equalTo(258 *SIZE);
            make.height.mas_equalTo(33 *SIZE);
        }];
    };
    [self.view addSubview:view];
    
}

- (void)ActionPlayBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    [_contentView endEditing:YES];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSError *playError;
    
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/aaa"];
    NSURL* url = [NSURL fileURLWithPath:path];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&playError];
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

- (void)ActionTimeBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    
    [_contentView endEditing:YES];
    if (_nextTimeBtn.content.text.length) {
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
        view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
        [view.pickerView setCalendar:[NSCalendar currentCalendar]];
        [view.pickerView setMaximumDate:[NSDate date]];
//        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
//        [comps setDay:30];//设置最大时间为：当前时间推后10天
        [view.pickerView setMinimumDate:[NSDate date]];
        [view.pickerView setMaximumDate:[_formatter dateFromString:_nextTimeBtn.content.text]];
        view.dateblock = ^(NSDate *date) {
            
            self->_remindTimeBtn.content.text = [self->_formatter stringFromDate:date];
            self->_remindTimeBtn.placeL.text = @"";
        };
        [self.view addSubview:view];
    }else{
        
        [self alertControllerWithNsstring:@"错误" And:@"请先选择客户等级"];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{

    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    [_contentView endEditing:YES];
    
    if ([self isEmpty:_followPurposeTF.textField.text]) {
        
        [self alertControllerWithNsstring:@"补充信息" And:@"请输入跟进目的"];
        return;
    }
    
    if (!_followWay.length) {
        
        [self alertControllerWithNsstring:@"补充信息" And:@"请选择跟进方式"];
        return;
    }
    
    if (!_level.length) {
        
        [self alertControllerWithNsstring:@"补充信息" And:@"请选择客户等级"];
        return;
    }
    
    
    
    if (!_remindTimeBtn.content.text) {

        [self alertControllerWithNsstring:@"补充信息" And:@"请选择提醒日期"];
        return;
    }

    if (Isplay == NO) {
        if ([self isEmpty:_contentView.text]) {
            
            [self alertControllerWithNsstring:@"补充信息" And:@"请输入跟进内容"];
            return;
        }
    }


    if ([self.status isEqualToString:@"direct"]) {
        
        [_directDic setObject:_groupId forKey:@"group_id"];
        [_directDic setObject:_followPurposeTF.textField.text forKey:@"follow_goal"];
        [_directDic setObject:_followWay forKey:@"follow_way"];
        [_directDic setObject:_level forKey:@"level"];
        [_directDic setObject:_nextTimeBtn.content.text forKey:@"time_limit"];
        [_directDic setObject:_contentView.text forKey:@"comment"];
        [_directDic setObject:_remindTimeBtn.content.text forKey:@"next_tip_time"];
        if (self.visit_id.length) {
            
            [_directDic setObject:self.visit_id forKey:@"visit_id"];
        }
        if (![self isEmpty:_remindPurposeTF.textField.text]) {
            
            [_directDic setObject:_remindPurposeTF.textField.text forKey:@"tip_comment"];
        }

        if (Isplay == YES) {
            [_directDic removeObjectForKey:@"comment"];
        }

        
        [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
          
            if (self->Isplay == YES) {
                NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/aaa"];
                NSURL* url = [NSURL fileURLWithPath:path];
                NSError *error;
                [formData appendPartWithFileURL:url name:@"file" fileName:@"file.wav" mimeType:@"mp3/wav" error:&error];
                //                [formData appendPartWithFileData:data name:@"file" fileName:@"file.wav" mimeType:@"mp3/wav"];
                NSLog(@"%@",error);
            }
           
            
        } url:WorkClientAutoFollowAdd_URL parameters:_directDic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TaskReolad" object:nil];
                [self alertControllerWithNsstring:@"跟进记录" And:@"是否在日历添加日程" WithCancelBlack:^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTask" object:nil];
                    if (self.followRecordVCBlock) {
                        
                        self.followRecordVCBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                } WithDefaultBlack:^{
                    
                    CalendarsManger *manger = [CalendarsManger sharedCalendarsManger];
                    [manger createCalendarWithTitle:@"跟进提醒" location:self->_remindPurposeTF.textField.text startDate:[formatter dateFromString:self->_remindTimeBtn.content.text] endDate:[formatter dateFromString:self->_remindTimeBtn.content.text] allDay:NO alarmArray:@[@"-1800"]];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTask" object:nil];
                    if (self.followRecordVCBlock) {
                        
                        self.followRecordVCBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }];

            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [self.allDic setObject:_followPurposeTF.textField.text forKey:@"follow_goal"];
        [self.allDic setObject:_followWay forKey:@"follow_way"];
        [self.allDic setObject:_level forKey:@"level"];
        [self.allDic setObject:_nextTimeBtn.content.text forKey:@"time_limit"];
        [self.allDic setObject:_contentView.text forKey:@"comment"];
        [self.allDic setObject:_remindTimeBtn.content.text forKey:@"next_tip_time"];
        
        if (![self isEmpty:_remindPurposeTF.textField.text]) {
            
            [self.allDic setObject:_remindPurposeTF.textField.text forKey:@"tip_comment"];
        }
        
        if (Isplay == YES) {
            
             [_directDic removeObjectForKey:@"comment"];
        }
        
        [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            if (self->Isplay == YES) {
                NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/aaa"];
                NSURL* url = [NSURL fileURLWithPath:path];
                NSError *error;
                [formData appendPartWithFileURL:url name:@"file" fileName:@"file.wav" mimeType:@"mp3/wav" error:&error];
                NSLog(@"%@",error);
            }
           
        } url:ProjectClientAutoAdd_URL parameters:self.allDic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
                
                [self alertControllerWithNsstring:@"跟进记录" And:@"是否在日历添加日程" WithCancelBlack:^{
                    
                    if ([self.status isEqualToString:@"add"]) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCall" object:nil];
                        if (self.followRecordVCBlock) {
                            
                            self.followRecordVCBlock();
                        }
                        for (UIViewController *vc in self.navigationController.viewControllers) {
                            
                            if ([vc isKindOfClass:[CallTelegramVC class]]) {
                                
                                [self.navigationController popToViewController:vc animated:YES];
                                break;
                            }
                            if ([vc isKindOfClass:[VisitCustomVC class]]) {
                                
                                [self.navigationController popToViewController:vc animated:YES];
                                break;
                            }
                        }
                    }
                    else{
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } WithDefaultBlack:^{
                    
                    CalendarsManger *manger = [CalendarsManger sharedCalendarsManger];
                    [manger createCalendarWithTitle:@"跟进提醒" location:self->_remindPurposeTF.textField.text startDate:[formatter dateFromString:self->_remindTimeBtn.content.text] endDate:[formatter dateFromString:self->_remindTimeBtn.content.text] allDay:NO alarmArray:@[@"-1800"]];
                    if ([self.status isEqualToString:@"add"]) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCall" object:nil];
                        if (self.followRecordVCBlock) {
                            
                            self.followRecordVCBlock();
                        }
                        for (UIViewController *vc in self.navigationController.viewControllers) {
                            
                            if ([vc isKindOfClass:[CallTelegramVC class]]) {
                                
                                [self.navigationController popToViewController:vc animated:YES];
                                break;
                            }
                            if ([vc isKindOfClass:[VisitCustomVC class]]) {
                                
                                [self.navigationController popToViewController:vc animated:YES];
                                break;
                            }
                        }
                    }
                    else{
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
                
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }
}

- (BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}


#pragma mark -- CollectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _followWayColl) {
        
        return _followArr.count;
    }
    return _levelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxSelectCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoxSelectCollCell" forIndexPath:indexPath];
    if (!cell) {
    
        cell = [[BoxSelectCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 20 *SIZE)];
    }
    
    cell.tag = 1;
    
    if (collectionView == _followWayColl) {
        
        [cell setIsSelect:[_followSelectArr[indexPath.item] integerValue]];
        
        cell.titleL.text = _followArr[indexPath.item][@"param"];
    }else{
        
        [cell setIsSelect:[_levelSelectArr[indexPath.item] integerValue]];
        
        cell.titleL.text = _levelArr[indexPath.item][@"config_name"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView == _followWayColl) {
        
        for (int i = 0; i < _followSelectArr.count; i++) {
            
            [_followSelectArr replaceObjectAtIndex:i withObject:@0];
        }
        _followWay = [NSString stringWithFormat:@"%@",_followArr[indexPath.item][@"id"]];
        [_followSelectArr replaceObjectAtIndex:indexPath.item withObject:@1];

    }else{
        
        for (int i = 0; i < _levelSelectArr.count; i++) {
            
            [_levelSelectArr replaceObjectAtIndex:i withObject:@0];
        }
        _level = [NSString stringWithFormat:@"%@",_levelArr[indexPath.item][@"config_id"]];
        
        NSDate *newDate = [[NSDate date] dateByAddingTimeInterval:24 * 60 * 60  * [_levelArr[indexPath.item][@"value_time"] integerValue]];
        _nextTimeBtn.content.text = [NSString stringWithFormat:@"%@", [_formatter stringFromDate:newDate]];
        [_levelSelectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    
    [collectionView reloadData];
}

- (void)initUI{
    
    self.titleLabel.text = @"跟进记录";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    
    NSArray *titleArr = @[@"跟进目的：",@"跟进方式：",@"客户等级：",@"跟进内容：",@"超期时间：",@"提醒日期：",@"提醒目的："];
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLBlackColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:14 *SIZE];
        switch (i) {
            case 0:
            {
                _followPurposeL = label;
                [_scrollView addSubview:_followPurposeL];
                break;
            }
            case 1:
            {
    
                _followWayL = label;
                [_scrollView addSubview:_followWayL];
                break;
            }
            case 2:
            {
                _levelL = label;
                [_scrollView addSubview:_levelL];
                break;
            }
            case 3:
            {
                _contentL = label;
                [_scrollView addSubview:_contentL];
                break;
            }
            case 4:
            {
                _nextTimeL = label;
                [_scrollView addSubview:_nextTimeL];
                break;
            }
            case 5:
            {
                _remindTimeL = label;
                [_scrollView addSubview:_remindTimeL];
                break;
            }
            case 6:{
                
                _remindPurposeL = label;
                [_scrollView addSubview:_remindPurposeL];
                break;
            }
            default:
                break;
        }
    }
    
    _followPurposeTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _followPurposeTF.textField.placeholder = @"请输入跟进目的";
    [_scrollView addSubview:_followPurposeTF];
    
    _remindPurposeTF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _remindPurposeTF.textField.placeholder = @"请输入提醒目的";
    [_scrollView addSubview:_remindPurposeTF];
    
    _contentView = [[UITextView alloc] init];
    _contentView.layer.cornerRadius = 4 *SIZE;
    _contentView.layer.borderWidth = SIZE;
    _contentView.layer.borderColor = _followPurposeTF.layer.borderColor;
    _contentView.clipsToBounds = YES;
//    if ([self.followDic count]) {
//
//        if (self.followDic[@"comment"]) {
//
//            _contentView.text = [NSString stringWithFormat:@"%@",self.followDic[@"comment"]];
//        }
//    }
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
    
    
    _remindTimeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    [_remindTimeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    _remindTimeBtn.placeL.text = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    _remindTimeBtn.content.text = [NSString stringWithFormat:@"%@ 09:00:00",[dateFormatter stringFromDate:[NSDate date]]];
    [_scrollView addSubview:_remindTimeBtn];
    
    _nextTimeBtn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _nextTimeBtn.backgroundColor = CLBackColor;
    [_scrollView addSubview:_nextTimeBtn];
    
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
//    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout1.itemSize = CGSizeMake(100 *SIZE, 20 *SIZE);
    
    _followWayColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 255 *SIZE, 100 *SIZE) collectionViewLayout:_flowLayout];
    _followWayColl.backgroundColor = CLWhiteColor;
    _followWayColl.delegate = self;
    _followWayColl.dataSource = self;
    [_followWayColl registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
    [_scrollView addSubview:_followWayColl];
    
    _levelColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 255 *SIZE, 100 *SIZE) collectionViewLayout:_flowLayout1];
    _levelColl.backgroundColor = CLWhiteColor;
    _levelColl.delegate = self;
    _levelColl.dataSource = self;
    [_levelColl registerClass:[BoxSelectCollCell class] forCellWithReuseIdentifier:@"BoxSelectCollCell"];
    [_scrollView addSubview:_levelColl];
    

    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchDown];
    [_confirmBtn setTitle:@"确认完成" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueTagColor];
    _confirmBtn.layer.cornerRadius = 5 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [self.view addSubview:_confirmBtn];
    
//    if ([self.status isEqualToString:@"direct"]) {
//
//        _followPurposeTF.textField.text = self.followDic[@"follow_goal"];
//        _contentView.text = self.followDic[@"comment"];
//        for (int i = 0; i < _followArr.count; i++) {
//
//            if ([self.followDic[@"follow_way"] isEqualToString:_followArr[i][@"param"]]) {
//
//                [_followWayColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//            }
//        }
//    }
    
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
    
    [_followWayColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_followPurposeTF.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(self->_followWayColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    [_levelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_followWayColl.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_levelColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_followWayColl.mas_bottom).offset(30 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(self->_levelColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];

    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_levelColl.mas_bottom).offset(41 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_levelColl.mas_bottom).offset(41 *SIZE);
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
//        make.bottom.equalTo(self->_scrollView).offset(-28 *SIZE);
    }];
    
    [_remindPurposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_remindTimeBtn.mas_bottom).offset(26 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_remindPurposeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_remindTimeBtn.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-28 *SIZE);
    }];
}

@end
