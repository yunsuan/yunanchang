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
#import "VisitCustomVC.h"
#import "WorkPersonAuditVC.h"
#import "WorkReceiptDetailVC.h"
#import "AuditTaskVC.h"
#import "RotationVC.h"

#import "SinglePickView.h"

#import "WorkCell.h"

@interface WorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    NSArray *_projectArr;
//    NSString *_info_id;
//    NSString *_project_id;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation WorkVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    

    _imgArr = @[@"laidian",@"ys_find",@"recommended",@"laifang",@"paihao",@"subscribe",@"signing_2",@"shoukuan_2",@"audit",@""];
    _titleArr = @[@"来电",@"带看确认",@"推荐客户",@"来访",@"排号",@"认购",@"签约",@"收款",@"人事审核",@"轮岗"];
    _projectArr = [UserModel defaultModel].project_list;
//    _info_id = [UserModel defaultModel].projectinfo[@"info_id"];
//    _project_id =[UserModel defaultModel].projectinfo[@"project_id"];
}



- (void)ActionRightBtn:(UIButton *)btn{
    
    NSMutableArray *temparr = [@[] mutableCopy];
        for (int i = 0; i < [_projectArr count]; i++) {
            
            NSDictionary *dic = @{@"id":[NSString stringWithFormat:@"%d",i],
                                  @"param":_projectArr[i][@"project_name"]
                                  };
            [temparr addObject:dic];
        
    }
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:temparr];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        [self.rightBtn setTitle:MC forState:UIControlStateNormal];
        [UserModel defaultModel].projectinfo =  [UserModel defaultModel].project_list[[ID integerValue]];
        [UserModelArchiver archive];
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
        
        CallTelegramVC * nextVC = [[CallTelegramVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 1){
        
        WorkPhoneConfirmVC *nextVC = [[WorkPhoneConfirmVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 2){
        
        WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 3){
        
        VisitCustomVC *nextVC = [[VisitCustomVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 7){
        
        WorkReceiptDetailVC *nextVC = [[WorkReceiptDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 8){
        
        WorkPersonAuditVC *nextVC = [[WorkPersonAuditVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 9){
        RotationVC *nextVC = [[RotationVC alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else{
        
        AuditTaskVC *nextVC = [[AuditTaskVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"推荐客户";
    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];

    
    
    
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
