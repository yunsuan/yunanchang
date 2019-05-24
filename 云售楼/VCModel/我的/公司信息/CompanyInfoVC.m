//
//  CompanyInfoVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyInfoVC.h"

#import "CompanyAuthVC.h"
#import "ProjectRoleVC.h"

#import "CompanyInfoCell.h"

@interface CompanyInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation CompanyInfoVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [@[] mutableCopy];
        _dataArr = [NSMutableArray arrayWithArray:dataArr];
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"离职确认" And:@"离职后，在没有认证公司的情况下，将不能使用任何功能" WithCancelBlack:^{
        
        
    } WithDefaultBlack:^{
       
        [BaseRequest POST:CompanyAuthQuit_URL parameters:@{@"auth_id":self->_dataArr[0][@"auth_id"]} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"离职成功" And:@"你已离职" WithDefaultBlack:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyInfoCell"];
    if (!cell) {
        
        cell = [[CompanyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    cell.dataDic = _dataArr[indexPath.row];
    if (indexPath.row == 0) {
        
        cell.backView.backgroundColor = CLBlueBtnColor;
        cell.companyL.textColor = CLWhiteColor;
        cell.departL.textColor = CLWhiteColor;
        cell.positionL.textColor = CLWhiteColor;
        cell.roleL.textColor = CLWhiteColor;
        cell.timeL.textColor = CLWhiteColor;
        cell.upLine.hidden = YES;
    }else{
        
        cell.upLine.hidden = NO;
        cell.backView.backgroundColor = CLWhiteColor;
        cell.companyL.textColor = CLTitleLabColor;
        cell.departL.textColor = CL86Color;
        cell.positionL.textColor = CL86Color;
        cell.roleL.textColor = CL86Color;
        cell.timeL.textColor = CL86Color;
    }
    
    if (indexPath.row == _dataArr.count - 1) {
        
        cell.downLine.hidden = YES;
    }else{
        
        cell.downLine.hidden = NO;
    }
    
    cell.companyInfoCellBlock = ^(NSInteger index) {
      
        ProjectRoleVC *nextVC = [[ProjectRoleVC alloc] initWithCompanyId:[NSString stringWithFormat:@"%@",self->_dataArr[index][@"company_id"]]];
        nextVC.roleId = @"";
        nextVC.status = @"modify";
        nextVC.projectRoleVCBlock = ^(NSString * _Nonnull roleId, NSString * _Nonnull name) {
            
            [BaseRequest GET:CompanyAuthInfo_URL parameters:nil success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if ([resposeObject[@"data"] count]) {
                        
                        self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                        [tableView reloadData];
                    }else{
                        
                        //                        CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
                        //                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];

        };
        [self.navigationController pushViewController:nextVC animated:YES];
//        CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
//        nextVC.status = @"reApply";
//        nextVC.authId = self->_dataArr[indexPath.row][@"auth_id"];
//        nextVC.companyAuthVCBlock = ^{
//
//            [BaseRequest GET:CompanyAuthInfo_URL parameters:nil success:^(id  _Nonnull resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    if ([resposeObject[@"data"] count]) {
//
//                        self->_dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
//                        [tableView reloadData];
//                    }else{
//
////                        CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
////                        [self.navigationController pushViewController:nextVC animated:YES];
//                    }
//                }else{
//
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError * _Nonnull error) {
//
//                [self showContent:@"网络错误"];
//            }];
//        };
    };
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"我的公司";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE - 43 *SIZE) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"离职" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_cancelBtn];
}
@end
