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

#import "WorkCell.h"

@interface WorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
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
    
    _imgArr = @[@"content_icon1",@"content_icon2",@"recommended",@"content_icon4",@"subscribe",@"content_icon6",@"signing_2",@"content_icon1",@"audit"];
    _titleArr = @[@"来电",@"带看确认",@"推荐客户",@"来访",@"排号",@"认购",@"签约",@"收款",@"人事审核"];
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
        
        CallTelegramVC * nextVC = [[CallTelegramVC alloc] init];
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
