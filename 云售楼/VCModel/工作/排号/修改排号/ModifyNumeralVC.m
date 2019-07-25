//
//  ModifyNumeralVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/24.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "ModifyNumeralVC.h"

#import "AddCallTelegramGroupMemberVC.h"
#import "CallTelegramSimpleCustomVC.h"

#import "AddNemeralHeader.h"

#import "AddNumeralPersonView.h"
#import "AddNumeralInfoView.h"
#import "AddNumeralProcessView.h"

#import "SinglePickView.h"
#import "DateChooseView.h"
#import "AdressChooseView.h"

@interface ModifyNumeralVC ()<UIScrollViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_project_id;
    NSString *_info_id;
    NSString *_group_id;
    NSString *_role_id;
    NSString *_row_id;
    
    NSArray *_titleArr;
    
    NSDictionary *_dataDic;
    
    NSMutableDictionary *_infoDic;
    NSMutableDictionary *_progressDic;
    
    NSMutableArray *_certArr;
    NSMutableArray *_personArr;
    NSMutableArray *_proportionArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_typeArr;
    NSMutableArray *_progressArr;
    NSMutableArray *_progressAllArr;
    NSMutableArray *_roleArr;
    NSMutableArray *_rolePersonArr;
    NSMutableArray *_rolePersonSelectArr;
    
    NSDateFormatter *_formatter;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) AddNemeralHeader *personHeader;

@property (nonatomic, strong) AddNumeralPersonView *addNumeralPersonView;

@property (nonatomic, strong) AddNemeralHeader *infoHeader;

@property (nonatomic, strong) AddNumeralInfoView *addNumeralInfoView;

@property (nonatomic, strong) AddNemeralHeader *processHeader;

@property (nonatomic, strong) AddNumeralProcessView *addNumeralProcessView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ModifyNumeralVC

- (instancetype)initWithRowId:(NSString *)row_id projectId:(NSString *)project_id info_Id:(NSString *)info_id dataDic:(nonnull NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _row_id = row_id;
        _project_id = project_id;
        _group_id = dataDic[@"beneficiary"][0][@"group_id"];
        _info_id = info_id;
        
        _dataDic = dataDic;
        
        _infoDic = [@{} mutableCopy];
        [_infoDic setObject:dataDic[@"row_code"] forKey:@"row_code"];
        [_infoDic setObject:dataDic[@"sincerity"] forKey:@"sincerity"];
        [_infoDic setObject:dataDic[@"config_id"] forKey:@"config_id"];
        [_infoDic setObject:dataDic[@"row_time"] forKey:@"row_time"];
        [_infoDic setObject:dataDic[@"end_time"] forKey:@"end_time"];
        
        _progressDic = [@{} mutableCopy];
        [_progressDic setObject:dataDic[@"progressList"][@"progress_id"] forKey:@"progress_id"];
        [_progressDic setObject:dataDic[@"progressList"][@"check_type"] forKey:@"check_type"];
        
        _personArr = [[NSMutableArray alloc] initWithArray:dataDic[@"beneficiary"]];
        _proportionArr = [@[] mutableCopy];
        for (int i = 0; i < _personArr.count; i++) {
            
            [_proportionArr addObject:_personArr[i][@"property"]];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self PropertyRequestMethod];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _num = 0;
    _titleArr = @[@"权益人信息",@"排号信息",@"流程信息"];
    _certArr = [@[] mutableCopy];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0]];
    _typeArr = [@[] mutableCopy];
    _progressArr = [@[] mutableCopy];
    _progressAllArr = [@[] mutableCopy];
    _roleArr = [@[] mutableCopy];
    _rolePersonArr = [@[] mutableCopy];
    _rolePersonSelectArr = [@[] mutableCopy];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    
    [_infoDic setObject:[_formatter stringFromDate:[NSDate date]] forKey:@"row_time"];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][2] count]; i++) {
                
                NSDictionary *dic = @{@"id":resposeObject[@"data"][2][i][@"config_id"],
                                      @"param":resposeObject[@"data"][2][i][@"config_name"]};
                [self->_certArr addObject:dic];
                
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
    
    [BaseRequest GET:ProjectRowGetRowList_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_typeArr removeAllObjects];
            for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                
                NSArray *arr = resposeObject[@"data"][i][@"list"];
                for (int j = 0; j < arr.count; j++) {
                    
                    [self->_typeArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",resposeObject[@"data"][i][@"batch_name"],arr[j][@"row_name"]],@"id":arr[j][@"config_id"]}];
                }
            }
            for (int i = 0; i < self->_typeArr.count; i++) {
                
                if ([self->_typeArr[i][@"id"] integerValue] == [self->_infoDic[@"config_id"] integerValue]) {
                    
                    [self->_infoDic setObject:self->_typeArr[i][@"param"] forKey:@"config_name"];
                    if (self->_addNumeralInfoView) {
                        
                        self->_addNumeralInfoView.dataDic = self->_infoDic;
                    }
                }
            }
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    [BaseRequest GET:ProjectProgressGet_URL parameters:@{@"project_id":_project_id,@"config_type":@"1",@"progress_defined_id":@"1"} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self->_progressArr removeAllObjects];
            [self->_progressAllArr removeAllObjects];
            self->_progressAllArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                
                [self->_progressArr addObject:@{@"param":[NSString stringWithFormat:@"%@",resposeObject[@"data"][i][@"progress_name"]],@"id":resposeObject[@"data"][i][@"progress_id"]}];
                
                if ([resposeObject[@"data"][i][@"progress_id"] integerValue] == [self->_progressDic[@"progress_id"] integerValue]) {
                    
                    [self->_progressDic setObject:resposeObject[@"data"][i][@"progress_name"] forKey:@"progress_name"];
                    if ([self->_progressDic[@"progress_name"] containsString:@"自由"]) {
                        
                        [self->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                        [self->_progressDic setObject:@"1" forKey:@"auditID"];
                    }else{
                        
                        [self->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                        [self->_progressDic setObject:@"2" forKey:@"auditID"];
                    }
                    if (self->_addNumeralProcessView) {
                        
                        self->_addNumeralProcessView.dataDic = self->_progressDic;
                    }
                }
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
            
            self->_rolePersonArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0 ; i < [resposeObject[@"data"] count]; i++) {
                
                
                if ([resposeObject[@"data"][i][@"agent_id"] integerValue] == [self->_dataDic[@"advicer"][0][@"advicer"] integerValue]) {
                    
                    [self->_rolePersonSelectArr addObject:@1];
                }else{
                    
                    [self->_rolePersonSelectArr addObject:@0];
                }
            }
            self->_addNumeralProcessView.personArr = self->_rolePersonArr;
            self->_addNumeralProcessView.personSelectArr = self->_rolePersonSelectArr;
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    BOOL isFull = YES;
    NSInteger percent = 0;
    for (NSString *str in _proportionArr) {
        
        if (!str.length) {
            
            isFull = NO;
            //            [self showContent:@"请填写权益人比例"];
            break;
        }else{
            
            percent += [str integerValue];
        }
    }
    if (!isFull) {
        
        [self showContent:@"请填写权益人比例"];
        return;
    }
    if (percent != 100) {
        
        [self showContent:@"权益人比例总和不为100"];
        return;
    }
    
    if (!_addNumeralInfoView.typeBtn.content.text.length) {
        
        [self showContent:@"请选择排号类别"];
        return;
    }
    if (!_addNumeralInfoView.numTF.textField.text.length) {
        
        [self showContent:@"请输入排号号码"];
        return;
    }
    if (!_addNumeralInfoView.freeTF.textField.text.length) {
        
        [self showContent:@"请输入诚意金"];
        return;
    }
    if (!_addNumeralProcessView.typeBtn.content.text.length) {
        [self showContent:@"请选择审批流程"];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id,@"config_id":_infoDic[@"config_id"]}];
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (int i = 0; i < _personArr.count; i++) {
        
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:_personArr[i]];
        if (i == 0) {
            
            [tempDic setObject:@"1" forKey:@"beneficiary_type"];
        }else{
            
            [tempDic setObject:@"2" forKey:@"beneficiary_type"];
        }
        //        [tempDic removeObjectForKey:@"client_id"];
        [tempDic removeObjectForKey:@"comment"];
        [tempDic removeObjectForKey:@"mail_code"];
        [tempDic removeObjectForKey:@"tel_show_state"];
        [tempDic setObject:_group_id forKey:@"group_id"];
        
        [tempDic setObject:_proportionArr[i] forKey:@"property"];
        [tempArr addObject:tempDic];
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *personjson = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [dic setObject:personjson forKey:@"beneficiary_list"];
    [dic setObject:@"3" forKey:@"from_type"];
    [dic setObject:_group_id forKey:@"from_id"];
    [dic setObject:_infoDic[@"row_code"] forKey:@"row_code"];
    [dic setObject:_infoDic[@"sincerity"] forKey:@"sincerity"];
    if (_infoDic[@"row_time"]) {
        
        [dic setObject:_infoDic[@"row_time"] forKey:@"row_time"];
    }
    if (_infoDic[@"end_time"]) {
        
        [dic setObject:_infoDic[@"end_time"] forKey:@"end_time"];
    }
    
//    NSArray *arr = @[@{@"advicer":self.advicer_id,@"name":self.advicer_name,@"type":@"1",@"property":@"100.00",@"comment":@"",@"state":@"1"}];
    
    
    NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:self->_dataDic[@"advicer"] options:NSJSONWritingPrettyPrinted error:&error];
    NSString *personjson1 = [[NSString alloc]initWithData:jsonData1 encoding:NSUTF8StringEncoding];
    [dic setObject:personjson1 forKey:@"advicer_list"];
    [dic setObject:_progressDic[@"progress_id"] forKey:@"progress_id"];
    NSString *param;
    for (int i = 0; i < _rolePersonSelectArr.count; i++) {
        
        if ([_rolePersonSelectArr[i] integerValue] == 1) {
            
            if (param.length) {
                
                param = [NSString stringWithFormat:@"%@,%@",param,_rolePersonArr[i][@"agent_id"]];
            }else{
                
                param = [NSString stringWithFormat:@"%@",_rolePersonArr[i][@"agent_id"]];
            }
        }
    }
    if (param.length) {
        
        [dic setObject:param forKey:@"param"];
    }
    [dic setObject:_row_id forKey:@"row_id"];
    
    [BaseRequest POST:ProjectRowUpdateRow_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyNumeralVCBlock) {
                
                self.modifyNumeralVCBlock();
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
    
    self.titleLabel.text = @"修改排号";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    SS(strongSelf);
    _personHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _personHeader.backgroundColor = CLWhiteColor;
    _personHeader.titleL.text = @"权益人信息";
    _personHeader.addBtn.hidden = YES;
    [_personHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    _personHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[0] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@0];
            [strongSelf->_personHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralPersonView.hidden = YES;
            [strongSelf->_infoHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_personHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@1];
            [strongSelf->_personHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralPersonView.hidden = NO;
            [strongSelf->_infoHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralPersonView.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_personHeader];
    
    _addNumeralPersonView = [[AddNumeralPersonView alloc] init];
    _addNumeralPersonView.dataArr = _personArr;
    _addNumeralPersonView.num = _num;
    _addNumeralPersonView.proportion = _proportionArr[_num];
    
    _addNumeralPersonView.addNumeralPersonViewDeleteBlock = ^(NSInteger num) {
        
        if (strongSelf->_num == num) {
            
            strongSelf->_num = num - 1;
            strongSelf->_addNumeralPersonView.num = num - 1;
        }
        [strongSelf->_personArr removeObjectAtIndex:num];
        [strongSelf->_proportionArr removeObjectAtIndex:num];
    };
    
    _addNumeralPersonView.addNumeralPersonViewStrBlock = ^(NSString * _Nonnull str, NSInteger num) {
        
        [strongSelf->_proportionArr replaceObjectAtIndex:num withObject:str];
        NSLog(@"1111111111%@",strongSelf->_proportionArr);
    };
    
    _addNumeralPersonView.addNumeralPersonViewCollBlock = ^(NSInteger num) {
        
        strongSelf->_num = num;
        strongSelf->_addNumeralPersonView.num = num;
        strongSelf->_addNumeralPersonView.proportion = strongSelf->_proportionArr[num];
    };
    _addNumeralPersonView.addNumeralPersonViewAddBlock = ^(NSInteger num) {
        
        AddCallTelegramGroupMemberVC *nextVC = [[AddCallTelegramGroupMemberVC alloc] initWithProjectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.group_id = [NSString stringWithFormat:@"%@",strongSelf->_group_id];
        nextVC.addCallTelegramGroupMemberVCBlock = ^(NSString * _Nonnull group, NSDictionary * _Nonnull dic) {
            
            [strongSelf->_proportionArr addObject:@""];
            [strongSelf->_personArr addObject:dic];
            strongSelf->_addNumeralPersonView.dataArr = strongSelf->_personArr;
            strongSelf->_num = strongSelf->_personArr.count - 1;
            strongSelf->_addNumeralPersonView.num = strongSelf->_personArr.count - 1;
            strongSelf->_addNumeralPersonView.proportion = strongSelf->_proportionArr[strongSelf->_personArr.count - 1];
            if (strongSelf.modifyNumeralVCBlock) {
                
                strongSelf.modifyNumeralVCBlock();
            }
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    _addNumeralPersonView.addNumeralPersonViewEditBlock = ^(NSInteger num) {
        
        CallTelegramSimpleCustomVC *nextVC = [[CallTelegramSimpleCustomVC alloc] initWithDataDic:strongSelf->_personArr[num] projectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.callTelegramSimpleCustomVCEditBlock = ^(NSDictionary * _Nonnull dic) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:strongSelf->_personArr[num]];
            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if (dic[key]) {
                    
                    [tempDic setObject:dic[key] forKey:key];
                }
            }];
            [strongSelf->_personArr replaceObjectAtIndex:num withObject:tempDic];
            strongSelf->_addNumeralPersonView.dataArr = strongSelf->_personArr;
            strongSelf->_addNumeralPersonView.num = num;
            strongSelf->_num = num;
            if (strongSelf.modifyNumeralVCBlock) {
                
                strongSelf.modifyNumeralVCBlock();
            }
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_scrollView addSubview:_addNumeralPersonView];
    
    _infoHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _infoHeader.titleL.text = @"排号信息";
    _infoHeader.addBtn.hidden = YES;
    [_infoHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _infoHeader.backgroundColor = CLWhiteColor;
    _infoHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[1] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@0];
            [strongSelf->_infoHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralInfoView.hidden = YES;
            [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_infoHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@1];
            [strongSelf->_infoHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralInfoView.hidden = NO;
            [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralInfoView.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_infoHeader];
    
    _addNumeralInfoView = [[AddNumeralInfoView alloc] init];
    _addNumeralInfoView.nameTF.textField.text = self.projectName;
    _addNumeralInfoView.hidden = YES;
    _addNumeralInfoView.dataDic = _infoDic;
    _addNumeralInfoView.addNumeralInfoViewStrBlock = ^(NSString * _Nonnull str, NSInteger num) {
        
        if (num == 0) {
            
            
        }else if (num == 2){
            
            [strongSelf->_infoDic setObject:str forKey:@"row_code"];
        }else{
            
            [strongSelf->_infoDic setObject:str forKey:@"sincerity"];
        }
        strongSelf->_addNumeralInfoView.dataDic = strongSelf->_infoDic;
    };
    _addNumeralInfoView.addNumeralInfoViewDropBlock = ^{
        
        if (strongSelf->_typeArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:strongSelf->_typeArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                [strongSelf->_infoDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"config_id"];
                [strongSelf->_infoDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"config_name"];
                strongSelf->_addNumeralInfoView.dataDic = strongSelf->_infoDic;
            };
            [strongSelf.view addSubview:view];
        }else{
            
            [BaseRequest GET:ProjectRowGetRowList_URL parameters:@{@"project_id":strongSelf->_project_id} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [strongSelf->_typeArr removeAllObjects];
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        NSArray *arr = resposeObject[@"data"][i][@"list"];
                        for (int j = 0; j < arr.count; j++) {
                            
                            [strongSelf->_typeArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",resposeObject[@"data"][i][@"batch_name"],arr[j][@"row_name"]],@"id":arr[j][@"config_id"]}];
                        }
                    }
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height) WithData:strongSelf->_typeArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        strongSelf->_addNumeralInfoView.dataDic = strongSelf->_infoDic;
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
        
    };
    
    _addNumeralInfoView.addNumeralInfoViewInfoTimeBlock = ^{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
        [view.pickerView setMaximumDate:[NSDate date]];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:10];//设置最大时间为：当前时间推后10天
        [view.pickerView setMinimumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        view.dateblock = ^(NSDate *date) {
            
            [strongSelf->_infoDic setObject:[strongSelf->_formatter stringFromDate:date] forKey:@"row_time"];
            strongSelf->_addNumeralInfoView.dataDic = strongSelf->_infoDic;
        };
        [strongSelf.view addSubview:view];
    };
    
    _addNumeralInfoView.addNumeralInfoViewFailTimeBlock = ^{
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:strongSelf.view.bounds];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:30];//设置最大时间为：当前时间推后10天
        [view.pickerView setMaximumDate:[calendar dateByAddingComponents:comps toDate:[NSDate date] options:0]];
        [view.pickerView setMinimumDate:[NSDate date]];
        view.dateblock = ^(NSDate *date) {
            
            [strongSelf->_infoDic setObject:[strongSelf->_formatter stringFromDate:date] forKey:@"end_time"];
            strongSelf->_addNumeralInfoView.dataDic = strongSelf->_infoDic;
        };
        [strongSelf.view addSubview:view];
    };
    [_scrollView addSubview:_addNumeralInfoView];
    
    
    _processHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _processHeader.titleL.text = @"流程信息";
    _processHeader.addBtn.hidden = YES;
    [_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _processHeader.backgroundColor = CLWhiteColor;
    _processHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[2] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@0];
            [strongSelf->_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralProcessView.hidden = YES;
            [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@1];
            [strongSelf->_processHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralProcessView.hidden = NO;
            [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_processHeader];
    
    _addNumeralProcessView = [[AddNumeralProcessView alloc] init];
    _addNumeralProcessView.hidden = YES;
    _addNumeralProcessView.dataDic = _progressDic;
    _addNumeralProcessView.addNumeralProcessViewAuditBlock = ^{
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:@[@{@"param":@"自由流程",@"id":@"1"},@{@"param":@"固定流程",@"id":@"2"}]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"auditMC"];
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"auditID"];
            strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
        };
        [strongSelf.view addSubview:view];
    };
    _addNumeralProcessView.addNumeralProcessViewTypeBlock = ^{
        
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
                    [strongSelf->_rolePersonSelectArr removeAllObjects];
                    strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                    strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
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
                strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
            };
            [strongSelf.view addSubview:view];
        }else{
            
            [BaseRequest GET:ProjectProgressGet_URL parameters:@{@"project_id":strongSelf->_project_id,@"config_type":@"1",@"progress_defined_id":@"1"} success:^(id  _Nonnull resposeObject) {
                
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
                        strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                
            }];
        }
    };
    
    _addNumeralProcessView.addNumeralProcessViewRoleBlock = ^{
        
        if (strongSelf->_roleArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_roleArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                if (![MC isEqualToString:strongSelf->_progressDic[@"role_name"]]) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    [strongSelf->_rolePersonSelectArr removeAllObjects];
                    strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                    strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                }
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
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
                        strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
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
    
    _addNumeralProcessView.addNumeralProcessViewSelectBlock = ^(NSArray * _Nonnull arr) {
        
        strongSelf->_rolePersonSelectArr = [NSMutableArray arrayWithArray:arr];
    };
    
    [_scrollView addSubview:_addNumeralProcessView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    [_personHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_addNumeralPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(40 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_infoHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addNumeralPersonView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addNumeralInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_infoHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_processHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_infoHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addNumeralProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_processHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
}

@end
