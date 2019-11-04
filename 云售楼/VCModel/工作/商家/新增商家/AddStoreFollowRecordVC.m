//
//  AddStoreFollowRecordVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/31.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddStoreFollowRecordVC.h"

#import "CalendarsManger.h"

#import "StoreVC.h"

#import "DropBtn.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

@interface AddStoreFollowRecordVC ()
{
    
    NSDateFormatter *_formatter;
    NSDateFormatter *_secondFormatter;
    
    NSMutableArray *_intentArr;
    NSMutableArray *_wayArr;
    NSMutableArray *_stageArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) DropBtn *intentBtn;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) DropBtn *wayBtn;

@property (nonatomic, strong) UILabel *stageL;

@property (nonatomic, strong) DropBtn *stageBtn;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropBtn *timeBtn;

@property (nonatomic, strong) UILabel *remindTimeL;

@property (nonatomic, strong) DropBtn *remindTimeBtn;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UITextView *contentView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddStoreFollowRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    _secondFormatter = [[NSDateFormatter alloc] init];
    [_secondFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    _intentArr = [@[] mutableCopy];
    _stageArr = [@[] mutableCopy];
    _wayArr = [@[] mutableCopy];
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            if (_intentArr.count) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_intentArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_intentBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                    self->_intentBtn->str = [NSString stringWithFormat:@"%@",ID];
                    self->_intentBtn.placeL.text = @"";
                };
                [self.view addSubview:view];
            }else{
                
                NSMutableDictionary *tempDic = [@{} mutableCopy];
                if (self.allDic.count) {
                    
                    [tempDic setObject:self.allDic[@"project_id"] forKey:@"project_id"];
                    [tempDic setObject:@"1" forKey:@"type"];
                }else{
                    
                    [tempDic setObject:self.project_id forKey:@"project_id"];
                    [tempDic setObject:@"1" forKey:@"type"];
                }
                [BaseRequest GET:ProjectBusinessGetBasicsList_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
                    
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        NSDictionary *dic = resposeObject[@"data"][i];
                        if ([dic[@"basics_name"] isEqualToString:@"合作意向"]) {
                            
                            for (int j = 0; j < [dic[@"children"] count]; j++) {
                                
                                [self->_intentArr addObject:@{@"param":dic[@"children"][j][@"basics_name"],
                                                @"id":dic[@"children"][j][@"basics_id"]
                                }];
                            }
                        }
                    }
                    if (self->_intentArr.count) {
                        
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_intentArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            self->_intentBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                            self->_intentBtn->str = [NSString stringWithFormat:@"%@",ID];
                            self->_intentBtn.placeL.text = @"";
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:@"未获取到合作意向"];
                    }
                } failure:^(NSError * _Nonnull error) {
                   
                    [self showContent:@"网络错误"];
                }];
            }
            break;
        }
        case 1:
        {
            if (_wayArr.count) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_wayArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_wayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                    self->_wayBtn->str = [NSString stringWithFormat:@"%@",ID];
                    self->_wayBtn.placeL.text = @"";
                };
                [self.view addSubview:view];
            }else{
                
                NSMutableDictionary *tempDic = [@{} mutableCopy];
                if (self.allDic.count) {
                                   
                    [tempDic setObject:self.allDic[@"project_id"] forKey:@"project_id"];
                    [tempDic setObject:@"1" forKey:@"type"];
                }else{
                                   
                    [tempDic setObject:self.project_id forKey:@"project_id"];
                    [tempDic setObject:@"1" forKey:@"type"];
                }
                [BaseRequest GET:ProjectBusinessGetBasicsList_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
                    
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        NSDictionary *dic = resposeObject[@"data"][i];
                        if ([dic[@"basics_name"] isEqualToString:@"跟进方式"]) {
                            
                            for (int j = 0; j < [dic[@"children"] count]; j++) {
                                
                                [self->_wayArr addObject:@{@"param":dic[@"children"][j][@"basics_name"],
                                                @"id":dic[@"children"][j][@"basics_id"]
                                }];
                            }
                        }
                    }
                    if (self->_wayArr.count) {
                        
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_wayArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            self->_wayBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                            self->_wayBtn->str = [NSString stringWithFormat:@"%@",ID];
                            self->_wayBtn.placeL.text = @"";
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:@"未获取到跟进方式"];
                    }
                } failure:^(NSError * _Nonnull error) {
                   
                    [self showContent:@"网络错误"];
                }];
            }
            break;
        }
        case 2:
        {
            if (_stageArr.count) {
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_stageArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_stageBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                    self->_stageBtn->str = [NSString stringWithFormat:@"%@",ID];
                    self->_stageBtn.placeL.text = @"";
                };
                [self.view addSubview:view];
            }else{
                
                NSMutableDictionary *tempDic = [@{} mutableCopy];
                if (self.allDic.count) {
                                   
                    [tempDic setObject:self.allDic[@"project_id"] forKey:@"project_id"];
                    [tempDic setObject:@"1" forKey:@"type"];
                }else{
                                   
                    [tempDic setObject:self.project_id forKey:@"project_id"];
                    [tempDic setObject:@"1" forKey:@"type"];
                }
                [BaseRequest GET:ProjectBusinessGetBasicsList_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
                    
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        NSDictionary *dic = resposeObject[@"data"][i];
                        if ([dic[@"basics_name"] isEqualToString:@"跟进阶段"]) {
                            
                            for (int j = 0; j < [dic[@"children"] count]; j++) {
                                
                                [self->_stageArr addObject:@{@"param":dic[@"children"][j][@"basics_name"],
                                                @"id":dic[@"children"][j][@"basics_id"]
                                }];
                            }
                        }
                    }
                    if (self->_stageArr.count) {
                        
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_stageArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            self->_stageBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                            self->_stageBtn->str = [NSString stringWithFormat:@"%@",ID];
                            self->_stageBtn.placeL.text = @"";
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:@"未获取到跟进阶段"];
                    }
                } failure:^(NSError * _Nonnull error) {
                   
                    [self showContent:@"网络错误"];
                }];
            }
            break;
        }
        case 3:
        {
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
            view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
            [view.pickerView setCalendar:[NSCalendar currentCalendar]];
            [view.pickerView setMaximumDate:[NSDate date]];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:15];//设置最大时间为：当前时间推后10天
            [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
            view.dateblock = ^(NSDate *date) {
                
                self->_timeBtn.content.text = [self->_secondFormatter stringFromDate:date];
                self->_timeBtn->str = [self->_secondFormatter stringFromDate:date];
                self->_intentBtn.placeL.text = @"";
            };
            [self.view addSubview:view];
            break;
        }
        case 4:
        {
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
            view.pickerView.datePickerMode = UIDatePickerModeDateAndTime;
            [view.pickerView setMinimumDate:[NSDate date]];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:15];//设置最大时间为：当前时间推后10天
            [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
            view.dateblock = ^(NSDate *date) {
                
                self->_remindTimeBtn.content.text = [self->_secondFormatter stringFromDate:date];
                self->_remindTimeBtn->str = [self->_secondFormatter stringFromDate:date];
                self->_remindTimeBtn.placeL.text = @"";
            };
            [self.view addSubview:view];
            break;
        }
        default:
            break;
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (!_intentBtn.content.text) {
        
        [self showContent:@"请选择合作意向"];
        return;
    }
    if (!_wayBtn.content.text) {
        
        [self showContent:@"请选择跟进方式"];
        return;
    }
    if (!_stageBtn.content.text) {
        
        [self showContent:@"请选择跟进阶段"];
        return;
    }
    if (!_timeBtn.content.text) {
        
        [self showContent:@"请选择跟进时间"];
        return;
    }
    if (!_remindTimeBtn.content.text) {

        [self showContent:@"请选择提醒日期"];
        return;
    }
    if (!_contentView.text.length) {
        
        [self showContent:@"请输入跟进内容"];
        return;
    }
    
    NSMutableDictionary *followDic = [@{} mutableCopy];
    [followDic setValue:_intentBtn->str forKey:@"cooperation_level"];
    [followDic setValue:_wayBtn->str forKey:@"follow_way"];
    [followDic setValue:_stageBtn->str forKey:@"follow_state"];
    [followDic setValue:_timeBtn.content.text forKey:@"follow_time"];
    [followDic setValue:_timeBtn.content.text forKey:@"next_follow_time"];
    [followDic setValue:_contentView.text forKey:@"content"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@[followDic] options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self.allDic setValue:jsonString forKey:@"follow_list"];
    
    if (self.business_id.length) {
        
        NSMutableDictionary *tempDic = [@{} mutableCopy];
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@[followDic] options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        [tempDic setValue:self.business_id forKey:@"business_id"];
        [tempDic setValue:jsonString forKey:@"follow_list"];
        
        [BaseRequest POST:ProjectBusinessUpdate_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                [self alertControllerWithNsstring:@"跟进记录" And:@"是否在日历添加日程" WithCancelBlack:^{
                    
                    if (self.addStoreFollowRecordVCBlock) {
                        
                        self.addStoreFollowRecordVCBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                } WithDefaultBlack:^{
                    
                    CalendarsManger *manger = [CalendarsManger sharedCalendarsManger];
                    [manger createCalendarWithTitle:@"跟进提醒" location:@"商家跟进" startDate:[self->_secondFormatter dateFromString:self->_remindTimeBtn.content.text] endDate:[self->_secondFormatter dateFromString:self->_remindTimeBtn.content.text] allDay:NO alarmArray:@[@"-1800"]];
                    if (self.addStoreFollowRecordVCBlock) {
                    
                        self.addStoreFollowRecordVCBlock();
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
        
        [BaseRequest POST:ProjectBusinessAdd_URL parameters:self.allDic success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 200) {

                [self alertControllerWithNsstring:@"跟进记录" And:@"是否在日历添加日程" WithCancelBlack:^{
                    
                    if (self.addStoreFollowRecordVCBlock) {
                        
                        self.addStoreFollowRecordVCBlock();
                    }
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[StoreVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
                } WithDefaultBlack:^{
                    
                    CalendarsManger *manger = [CalendarsManger sharedCalendarsManger];
                    [manger createCalendarWithTitle:@"跟进提醒" location:@"商家跟进" startDate:[self->_secondFormatter dateFromString:self->_remindTimeBtn.content.text] endDate:[self->_secondFormatter dateFromString:self->_remindTimeBtn.content.text] allDay:NO alarmArray:@[@"-1800"]];
                    if (self.addStoreFollowRecordVCBlock) {
                        
                        self.addStoreFollowRecordVCBlock();
                    }
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[StoreVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }
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

- (void)initUI{

    self.titleLabel.text = @"跟进记录";

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    NSArray *titleArr = @[@"合作意向：",@"跟进方式：",@"跟进阶段：",@"跟进时间：",@"提醒时间：",@"跟进内容："];
    
    for (int i = 0; i < titleArr.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLBlackColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:14 *SIZE];
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _intentL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_intentL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _intentL.attributedText = attr;
                [_scrollView addSubview:_intentL];
                
                _intentBtn = btn;
                if (self.followDic.count) {
                    
                    _intentBtn.content.text = self.followDic[@"cooperation_level_name"];
                    _intentBtn->str = self.followDic[@"cooperation_level"];
                    _intentBtn.placeL.text = @"";
                }
                [_scrollView addSubview:_intentBtn];
                break;
            }
            case 1:
            {
        
                _wayL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_wayL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _wayL.attributedText = attr;
                [_scrollView addSubview:_wayL];
                
                _wayBtn = btn;
                if (self.followDic.count) {
                    
                    _wayBtn.content.text = self.followDic[@"follow_way_name"];
                    _wayBtn->str = self.followDic[@"follow_way"];
                    _wayBtn.placeL.text = @"";
                }
                [_scrollView addSubview:_wayBtn];
                break;
            }
            case 2:
            {
                _stageL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_stageL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _stageL.attributedText = attr;
                [_scrollView addSubview:_stageL];
                
                _stageBtn = btn;
                if (self.followDic.count) {
                    
                    _stageBtn.content.text = self.followDic[@"follow_state_name"];
                    _stageBtn->str = self.followDic[@"follow_state"];
                    _stageBtn.placeL.text = @"";
                }
                [_scrollView addSubview:_stageBtn];
                break;
            }
            case 3:
            {
                _timeL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_timeL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _timeL.attributedText = attr;
                [_scrollView addSubview:_timeL];
                
                _timeBtn = btn;
                _timeBtn.content.text = [_secondFormatter stringFromDate:[NSDate date]];
                [_scrollView addSubview:_timeBtn];
                break;
            }case 4:{
                
                _remindTimeL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_remindTimeL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _remindTimeL.attributedText = attr;
                [_scrollView addSubview:_remindTimeL];
                
                _remindTimeBtn = btn;
//                _remindTimeBtn.content.text = [_formatter stringFromDate:[NSDate date]];
                [_scrollView addSubview:_remindTimeBtn];
            }
            case 5:
            {
                _contentL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_contentL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _contentL.attributedText = attr;
                [_scrollView addSubview:_contentL];
                break;
            }
            default:
                break;
        }
    }
    
    _contentView = [[UITextView alloc] init];
    _contentView.layer.cornerRadius = 4 *SIZE;
    _contentView.layer.borderWidth = SIZE;
    _contentView.layer.borderColor = CLLightGrayColor.CGColor;
    _contentView.clipsToBounds = YES;
    if ([self.followDic count]) {
            
        if (self.followDic[@"content"]) {
                
            _contentView.text = [NSString stringWithFormat:@"%@",self.followDic[@"content"]];
        }
    }
    _contentView.textContainerInset = UIEdgeInsetsMake(3 *SIZE, 3 *SIZE, 5 *SIZE, 30 *SIZE);
    //    _contentView.backgroundColor = CLLightGrayColor;
    [_scrollView addSubview:_contentView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.equalTo(self.view.mas_bottom).offset(-43 *SIZE - TAB_BAR_MORE);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(37 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_intentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(27 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_wayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_intentBtn.mas_bottom).offset(28 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_wayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_intentBtn.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_stageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_wayBtn.mas_bottom).offset(28 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_stageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_wayBtn.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_stageBtn.mas_bottom).offset(28 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_stageBtn.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_remindTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(28 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
        
    [_remindTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(22 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    //        make.bottom.equalTo(self->_scrollView).offset(-28 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_remindTimeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_remindTimeBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-28 *SIZE);
    }];
}

@end
