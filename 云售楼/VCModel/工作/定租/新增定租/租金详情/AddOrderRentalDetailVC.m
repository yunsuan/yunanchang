//
//  AddOrderRentalDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRentalDetailVC.h"

#import "ModifyAndAddRentalVC.h"

#import "AddOrderRentalDetailCell.h"

@interface AddOrderRentalDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
 
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation AddOrderRentalDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    ModifyAndAddRentalVC *nextVC = [[ModifyAndAddRentalVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddOrderRentalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddOrderRentalDetailCell"];
    if (!cell) {
        
        cell = [[AddOrderRentalDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddOrderRentalDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = @{};
    
    cell.addOrderRentalDetailCellBlock = ^(NSInteger idx) {
      
        ModifyAndAddRentalVC *nextVC = [[ModifyAndAddRentalVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"租金详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setTitle:@"新 增" forState:UIControlStateNormal];
    [_addBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_addBtn];
}
@end
