//
//  CompanyAuthVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyAuthVC.h"

#import "SelectCompanyVC.h"
#import "ProjectRoleVC.h"

#import "SinglePickView.h"
@interface CompanyAuthVC ()
{
    
    NSString *_companyId;
    NSString *_departId;
    NSString *_posiId;
    NSString *_roleId;
    NSMutableArray *_departArr;
    NSMutableArray *_posiArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *companyTL;

@property (nonatomic, strong) UIView *compantLine;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UIButton *companyBtn;

@property (nonatomic, strong) UILabel *roleTL;

@property (nonatomic, strong) UIView *roleLine;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) UIButton *roleBtn;

@property (nonatomic, strong) UILabel *departTL;

@property (nonatomic, strong) UILabel *departL;

@property (nonatomic, strong) UIView *departLine;

@property (nonatomic, strong) UIButton *departTextField;

@property (nonatomic, strong) UILabel *positionTL;

@property (nonatomic, strong) UILabel *positionL;

@property (nonatomic, strong) UIView *positionLine;

@property (nonatomic, strong) UIButton *positionTextField;

@property (nonatomic, strong) UIButton *commitBtn;
@end

@implementation CompanyAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _posiArr = [@[] mutableCopy];
    _departArr = [@[] mutableCopy];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
        nextVC.selectCompanyVCBlock = ^(NSString * _Nonnull companyId, NSString * _Nonnull name) {
            
            self->_companyL.text = name;
            self->_companyId = [NSString stringWithFormat:@"%@",companyId];
            self->_departL.text = @"";
            self->_departId = @"";
            self->_positionL.text = @"";
            self->_posiId = @"";
            self->_roleL.text = @"";
            self->_roleId = @"";
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(btn.tag == 1){
        
        if (!_companyId.length) {
            
            [self showContent:@"请先选择公司"];
            return;
        }
//        _departTextField.userInteractionEnabled = NO;
        [BaseRequest GET:CompanyPersonOrganizeList_URL parameters:@{@"company_id":_companyId} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self->_departArr removeAllObjects];
                self->_departArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                [self->_departArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSDictionary *dic = @{@"id":obj[@"department_id"],
                                          @"param":obj[@"department_name"]
                                          };
                    [self->_departArr replaceObjectAtIndex:idx withObject:dic];
                }];
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_departArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_departL.text = MC;
                    self->_departId = [NSString stringWithFormat:@"%@",ID];
                    self->_positionL.text = @"";
                    self->_posiId = @"";
                    self->_roleL.text = @"";
                    self->_roleId = @"";
                };
                [self.view addSubview:view];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else if(btn.tag == 2){
        
        if (!_departId.length) {
            
            [self showContent:@"请先选择部门"];
            return;
        }
        //        _departTextField.userInteractionEnabled = NO;
        [BaseRequest GET:CompanyPersonOrganizePostList_URL parameters:@{@"department_id":_departId} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self->_posiArr removeAllObjects];
                self->_posiArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                [self->_posiArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSDictionary *dic = @{@"id":obj[@"post_id"],
                                          @"param":obj[@"post_name"]
                                          };
                    [self->_posiArr replaceObjectAtIndex:idx withObject:dic];
                }];
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_posiArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_positionL.text = MC;
                    self->_posiId = [NSString stringWithFormat:@"%@",ID];
                    self->_roleL.text = @"";
                    self->_roleId = @"";
                };
                [self.view addSubview:view];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        if (!_companyId.length) {
            
            [self showContent:@"请先选择公司"];
            return;
        }
        ProjectRoleVC *nextVC = [[ProjectRoleVC alloc] initWithCompanyId:_companyId];
        nextVC.projectRoleVCBlock = ^(NSString * _Nonnull roleId, NSString * _Nonnull name) {
          
            self->_roleId = roleId;
            self->_roleL.text = name;
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if ([self.status isEqualToString:@"reApply"]) {
        
        if ([self.status isEqualToString:@"reApply"]) {
            
            if (!_companyId.length) {
                
                return;
            }
            if (!_departId.length) {
                
                return;
            }
            if (!_posiId.length) {
                
                return;
            }
            NSDictionary *dic = @{@"before_auth_id":self.authId,
                                  @"company_id":_companyId,
                                  @"department_id":_departId,
                                  @"post_id":_posiId,
                                  @"role":_roleId
                                  };
            //    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            //    if (_roleId.length) {
            //
            //        [tempDic setObject:_roleId forKey:@"role"];
            //    }
            [BaseRequest POST:CompanyAuth_URL parameters:dic success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [self alertControllerWithNsstring:@"申请成功" And:@"请等待审核或者联系审核人" WithDefaultBlack:^{
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
                        if (self.companyAuthVCBlock) {
                            
                            self.companyAuthVCBlock();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }
    }else{
        
        if (!_companyId.length) {
            
            return;
        }
        if (!_departId.length) {
            
            return;
        }
        if (!_posiId.length) {
            
            return;
        }
        NSDictionary *dic = @{@"company_id":_companyId,
                              @"department_id":_departId,
                              @"post_id":_posiId,
                              @"role":_roleId
                              };
        //    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        //    if (_roleId.length) {
        //
        //        [tempDic setObject:_roleId forKey:@"role"];
        //    }
        [BaseRequest POST:CompanyAuth_URL parameters:dic success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"申请成功" And:@"请等待审核或者联系审核人" WithDefaultBlack:^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goHome" object:nil];
                    
                    [self.navigationController popViewControllerAnimated:YES];
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
    
    self.titleLabel.text = @"公司申请";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(37 *SIZE, 14 *SIZE, 200 *SIZE, 13 *SIZE)];
    label.textColor = CLTitleLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"⚠️认证需要审核 请仔细填写信息";
    [_scrollView addSubview:label];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_whiteView];
    
    NSArray *titleArr = @[@"所属公司",@"所属部门",@"所属岗位",@"项目角色"];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = titleArr[i];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = CLLineColor;
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.textColor = CLTitleLabColor;
        label1.textAlignment = NSTextAlignmentRight;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
    
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        switch (i) {
            case 0:
            {
                _companyTL = label;
                [_whiteView addSubview:_companyTL];
                _compantLine = line;
                [_whiteView addSubview:_compantLine];
                
                _companyL = label1;
                [_whiteView addSubview:_companyL];
                _companyBtn = button;
                [_whiteView addSubview:_companyBtn];
                break;
            }
            case 1:
            {

                _departL = label1;
                [_whiteView addSubview:_departL];
                _departTextField = button;
                [_whiteView addSubview:_departTextField];
                
                _departTL = label;
                [_whiteView addSubview:_departTL];
                _departLine = line;
                [_whiteView addSubview:_departLine];
                
                break;
            }
            case 2:
            {
                _positionL = label1;
                [_whiteView addSubview:_positionL];
                _positionTextField = button;
                [_whiteView addSubview:_positionTextField];
                
                _positionTL = label;
                [_whiteView addSubview:_positionTL];
                _positionLine = line;
                [_whiteView addSubview:_positionLine];
                break;
            }
            case 3:
            {
                _roleTL = label;
                [_whiteView addSubview:_roleTL];
                _roleLine = line;
                [_whiteView addSubview:_roleLine];
                
                _roleL = label1;
                [_whiteView addSubview:_roleL];
                
                _roleBtn = button;
                [_whiteView addSubview:_roleBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(0, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, 360 *SIZE, 50 *SIZE + TAB_BAR_MORE);
    _commitBtn.backgroundColor = CLBlueBtnColor;
    [_commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitBtn];

    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE);
    }];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
        make.top.equalTo(self->_scrollView).offset(40 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
    }];
    
    [_companyTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_whiteView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_whiteView).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_companyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_compantLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_companyBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_departTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_compantLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_departL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_compantLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_departTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->_compantLine.mas_bottom).offset(0 *SIZE);
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_departLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_departTextField.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_positionTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_departLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_positionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_departLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_positionTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->_departLine.mas_bottom).offset(0 *SIZE);
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_positionLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_positionTextField.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    
    [_roleTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_roleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->_positionLine.mas_bottom).offset(0 *SIZE);
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_roleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_roleBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self->_whiteView.mas_bottom).offset(0 *SIZE);
    }];
    
}
@end
