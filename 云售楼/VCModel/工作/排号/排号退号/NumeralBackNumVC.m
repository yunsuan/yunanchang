//
//  NumeralBackNumVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/29.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralBackNumVC.h"

#import "NumeralBackNumView.h"

#import "SinglePickView.h"

@interface NumeralBackNumVC ()
{
    
    NSString *_project_id;
    NSString *_role_id;
    
    NSDictionary *_dataDic;
    
    NSMutableDictionary *_progressDic;
    
    NSMutableArray *_progressAllArr;
    NSMutableArray *_roleArr;
    NSMutableArray *_rolePersonArr;
    NSMutableArray *_progressArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NumeralBackNumView *numeralBackNumView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation NumeralBackNumVC

- (instancetype)initWithProject_id:(NSString *)project_id dataDic:(nonnull NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _project_id = project_id;
//        _sincerity = sincerity;
        
        _dataDic = dataDic;
        
        _progressDic = [@{} mutableCopy];
        
//        [_progressDic setObject:sincerity forKey:@"origin"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self PropertyRequestMethod];
}

- (void)initDataSource{
    
    _progressArr = [@[] mutableCopy];
    
    _progressAllArr = [@[] mutableCopy];
    _roleArr = [@[] mutableCopy];
    _rolePersonArr = [@[] mutableCopy];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:ProjectProgressGet_URL parameters:@{@"project_id":_project_id,@"config_type":@"2",@"progress_defined_id":@"2"} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_progressArr removeAllObjects];
            [self->_progressAllArr removeAllObjects];
            self->_progressAllArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            
            for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                
                [self->_progressArr addObject:@{@"param":[NSString stringWithFormat:@"%@",resposeObject[@"data"][i][@"progress_name"]],@"id":resposeObject[@"data"][i][@"progress_id"]}];
            }
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    [BaseRequest GET:ProjectRoleListAll_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (NSDictionary *dic in resposeObject[@"data"]) {
                
                [self->_roleArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",dic[@"project_name"],dic[@"role_name"]],@"id":dic[@"role_id"]}];
            }
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id}];
    
    if (_role_id.length) {
        
        [dic setObject:_role_id forKey:@"role_id"];
    }
    
    [BaseRequest GET:ProjectRolePersonList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_rolePersonArr removeAllObjects];
            //            self->_rolePersonArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                
                [self->_rolePersonArr addObject:@{@"param":resposeObject[@"data"][i][@"agent_name"],@"id":resposeObject[@"data"][i][@"agent_id"]}];
            }
            //            self->_sincerityChangeView.personArr = self->_rolePersonArr;
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}


- (void)ActionNextBtn:(UIButton *)btn{
    
    
    
    if (!_numeralBackNumView.typeBtn.content.text.length) {
        [self showContent:@"请选择审批流程"];
        return;
    }
    
    if (!_numeralBackNumView.roleBtn.content.text.length) {
        [self showContent:@"请选择项目角色流程"];
        return;
    }
    
    if (!_numeralBackNumView.personBtn.content.text.length) {
        [self showContent:@"请选择审核人员"];
        return;
    }
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"primary_id":self->_dataDic[@"row_id"],@"progress_defined_id":@"1"}];
    [dic setObject:_progressDic[@"progress_id"] forKey:@"progress_id"];
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < [_dataDic[@"beneficiary"] count]; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:_dataDic[@"beneficiary"][i]];
        //        [tempDic removeObjectForKey:@"client_id"];
        [tempArr addObject:tempDic];
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *personjson = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [dic setObject:personjson forKey:@"beneficiary_list"];
    
    [dic setObject:_dataDic[@"project_id"] forKey:@"project_id"];
    [dic setObject:_dataDic[@"config_id"] forKey:@"config_id"];
    [dic setObject:_dataDic[@"row_code"] forKey:@"row_code"];
    [dic setObject:_dataDic[@"sincerity"] forKey:@"sincerity"];
    if (_dataDic[@"row_time"]) {
        
        [dic setObject:_dataDic[@"row_time"] forKey:@"row_time"];
    }
    if (_dataDic[@"end_time"]) {
        
        [dic setObject:_dataDic[@"end_time"] forKey:@"end_time"];
    }
    [dic setObject:_progressDic[@"person_id"] forKey:@"param"];
    
    NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:self->_dataDic[@"advicer"] options:NSJSONWritingPrettyPrinted error:&error];
    NSString *personjson1 = [[NSString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
    [dic setObject:personjson1 forKey:@"advicer_list"];
    [BaseRequest POST:ProjectChange_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.numeralBackNumVCBlock) {
                
                self.numeralBackNumVCBlock();
            }
            [self showContent:resposeObject[@"msg"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}



- (void)initUI{
    
    self.titleLabel.text = @"增加诚意金";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    SS(strongSelf);
    
    _numeralBackNumView = [[NumeralBackNumView alloc] init];
    _numeralBackNumView.dataDic = _progressDic;
    _numeralBackNumView.numeralBackNumViewAuditBlock = ^{
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:@[@{@"param":@"自由流程",@"id":@"1"},@{@"param":@"固定流程",@"id":@"2"}]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"auditMC"];
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"auditID"];
            strongSelf->_numeralBackNumView.dataDic = strongSelf->_progressDic;
        };
        [strongSelf.view addSubview:view];
    };
    
    _numeralBackNumView.numeralBackNumViewTypeBlock = ^{
        
        if (strongSelf->_progressArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_progressArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                if ([MC isEqualToString:@"自由"]) {
                    
                    [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                }else if ([MC isEqualToString:@"固定"]){
                    
                    [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                }else{
                    
                    [strongSelf->_progressDic removeObjectForKey:@"auditMC"];
                    [strongSelf->_progressDic removeObjectForKey:@"auditID"];
                }
                if (![MC isEqualToString:strongSelf->_progressDic[@"progress_name"]]) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    //                    [strongSelf->_rolePersonSelectArr removeAllObjects];
                    strongSelf->_numeralBackNumView.personArr = strongSelf->_rolePersonArr;
                    //                    strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                    [strongSelf->_progressDic removeObjectForKey:@"role_name"];
                    [strongSelf->_progressDic removeObjectForKey:@"role_id"];
                }
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                for (int i = 0; i < strongSelf->_progressAllArr.count; i++) {
                    
                    if ([ID integerValue] == [strongSelf->_progressAllArr[i][@"progress_id"] integerValue]) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",strongSelf->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                    }
                }
                strongSelf->_numeralBackNumView.dataDic = strongSelf->_progressDic;
            };
            [strongSelf.view addSubview:view];
        }else{
            
            [BaseRequest GET:ProjectProgressGet_URL parameters:@{@"project_id":strongSelf->_project_id,@"config_type":@"1",@"progress_defined_id":@"2"} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [strongSelf->_progressArr removeAllObjects];
                    [strongSelf->_progressAllArr removeAllObjects];
                    strongSelf->_progressAllArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        [strongSelf->_progressArr addObject:@{@"param":[NSString stringWithFormat:@"%@",resposeObject[@"data"][i][@"progress_name"]],@"id":resposeObject[@"data"][i][@"progress_id"]}];
                    }
                    
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_progressArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                        for (int i = 0; i < strongSelf->_progressAllArr.count; i++) {
                            
                            if ([ID integerValue] == [strongSelf->_progressAllArr[i][@"progress_id"] integerValue]) {
                                
                                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",strongSelf->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                            }
                        }
                        strongSelf->_numeralBackNumView.dataDic = strongSelf->_progressDic;
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                
            }];
        }
    };
    
    _numeralBackNumView.numeralBackNumViewRoleBlock = ^{
        
        if (strongSelf->_roleArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_roleArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                if (![MC isEqualToString:strongSelf->_progressDic[@"role_name"]]) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    [strongSelf RequestMethod];
                }
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                strongSelf->_numeralBackNumView.dataDic = strongSelf->_progressDic;
                [strongSelf RequestMethod];
            };
            [strongSelf.view addSubview:view];
        }else{
            
            [BaseRequest GET:ProjectRoleListAll_URL parameters:@{@"project_id":strongSelf->_project_id} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    for (NSDictionary *dic in resposeObject[@"data"]) {
                        
                        [strongSelf->_roleArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",dic[@"project_name"],dic[@"role_name"]],@"id":dic[@"role_id"]}];
                    }
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_roleArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                        strongSelf->_numeralBackNumView.dataDic = strongSelf->_progressDic;
                        [strongSelf RequestMethod];
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
        }
    };
    
    _numeralBackNumView.numeralBackNumViewPersonBlock = ^{
        
        if (strongSelf->_rolePersonArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_rolePersonArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"person_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"person_id"];
                strongSelf->_numeralBackNumView.dataDic = strongSelf->_progressDic;
            };
            [strongSelf.view addSubview:view];
        }else{
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":strongSelf->_project_id}];
            
            if (strongSelf->_role_id.length) {
                
                [dic setObject:strongSelf->_role_id forKey:@"role_id"];
            }
            
            [BaseRequest GET:ProjectRolePersonList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        [strongSelf->_rolePersonArr addObject:@{@"param":resposeObject[@"data"][i][@"agent_name"],@"id":resposeObject[@"data"][i][@"agent_id"]}];
                    }
                    
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_rolePersonArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"person_name"];
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"person_id"];
                        strongSelf->_numeralBackNumView.dataDic = strongSelf->_progressDic;
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
        }
    };
    
    [_scrollView addSubview:_numeralBackNumView];
    
    
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
    
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    [_numeralBackNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        //        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
}

@end
