//
//  WorkVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkVC.h"

#import "CallTelegramVC.h"
#import "WorkPhoneConfirmVC.h"
#import "WorkRecommendVC.h"
#import "WorkPersonAuditVC.h"
#import "WorkReceiptDetailVC.h"
#import "AuditTaskVC.h"

#import "SinglePickView.h"

#import "WorkCell.h"

@interface WorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    NSMutableArray *_projectArr;
    NSString *_info_id;
    NSString *_project_id;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation WorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotificationProject:) name:@"projectSelect" object:nil];
    _imgArr = @[@"laidian",@"content_icon2",@"recommended",@"laifang",@"paihao",@"subscribe",@"signing_2",@"shoukuan_2",@"audit"];
    _titleArr = @[@"来电",@"带看确认",@"推荐客户",@"来访",@"排号",@"认购",@"签约",@"收款",@"人事审核"];
    _projectArr = [@[] mutableCopy];
    _info_id = [NSString stringWithFormat:@"%@",[UserModel defaultModel].company_info[@"project_list"][0][@"info_id"]];
    _project_id = [NSString stringWithFormat:@"%@",[UserModel defaultModel].company_info[@"project_list"][0][@"project_id"]];
}

- (void)NSNotificationProject:(NSNotification *)project{
    
    self->_project_id = project.userInfo[@"project_id"];
    self->_info_id = project.userInfo[@"info_id"];
    [self.rightBtn setTitle:project.userInfo[@"project_name"] forState:UIControlStateNormal];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    if (!_projectArr.count) {
        
        [_projectArr removeAllObjects];
        for (int i = 0; i < [[UserModel defaultModel].company_info[@"project_list"] count]; i++) {
            
            NSDictionary *dic = @{@"id":[UserModel defaultModel].company_info[@"project_list"][i][@"info_id"],
                                  @"param":[UserModel defaultModel].company_info[@"project_list"][i][@"project_name"]
                                  };
            [_projectArr addObject:dic];
        }
    }
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_projectArr];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        self->_info_id = [NSString stringWithFormat:@"%@",ID];
        [self.rightBtn setTitle:MC forState:UIControlStateNormal];
        for (int i = 0; i < [[UserModel defaultModel].company_info[@"project_list"] count]; i++) {
            
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultModel].company_info[@"project_list"][i][@"info_id"]] isEqualToString:self->_info_id]) {
                
                self->_project_id = [UserModel defaultModel].company_info[@"project_list"][i][@"project_id"];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"projectSelect" object:nil userInfo:@{@"info_id":self->_info_id,@"project_name":MC,@"project_id":self->_project_id}];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkCell"];
    if (!cell) {
        
        cell = [[WorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell SetImg:_imgArr[indexPath.row] title:_titleArr[indexPath.row] content:@""];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        CallTelegramVC * nextVC = [[CallTelegramVC alloc] initWithProjectId:_project_id];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 1){
        
        WorkPhoneConfirmVC *nextVC = [[WorkPhoneConfirmVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 2){
        
        WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 7){
        
        WorkReceiptDetailVC *nextVC = [[WorkReceiptDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 8){
        
        WorkPersonAuditVC *nextVC = [[WorkPersonAuditVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        AuditTaskVC *nextVC = [[AuditTaskVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"推荐客户";
    
    self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    if ([UserModel defaultModel].company_info
        .count) {
        
        if ([[UserModel defaultModel].company_info[@"project_list"] count]) {
            
            self.rightBtn.hidden = NO;
            [self.rightBtn setTitle:[UserModel defaultModel].company_info[@"project_list"][0][@"project_name"] forState:UIControlStateNormal];
        }else{
            
            self.rightBtn.hidden = YES;
        }
    }
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
