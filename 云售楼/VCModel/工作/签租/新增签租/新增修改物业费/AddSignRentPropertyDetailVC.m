//
//  AddSignRentPropertyDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentPropertyDetailVC.h"

#import "AddSignRentPropertyVC.h"

#import "AddSignRentPropertyDetailCell.h"

@interface AddSignRentPropertyDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
 
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation AddSignRentPropertyDetailVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [[NSMutableArray alloc] initWithArray:dataArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    AddSignRentPropertyVC *nextVC = [[AddSignRentPropertyVC alloc] init];
    nextVC.config = self.config;
    nextVC.addSignRentPropertyVCBlock = ^(NSDictionary * _Nonnull dic) {
        
        [self->_dataArr addObject:dic];
        [self->_table reloadData];
        if (self.addSignRentPropertyDetailVCBlock) {
            
            self.addSignRentPropertyDetailVCBlock(self->_dataArr);
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddSignRentPropertyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddSignRentPropertyDetailCell"];
    if (!cell) {
        
        cell = [[AddSignRentPropertyDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddSignRentPropertyDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.addSignRentPropertyDetailCellBlock = ^(NSInteger idx) {
      
        AddSignRentPropertyVC *nextVC = [[AddSignRentPropertyVC alloc] init];
        nextVC.dataDic = self->_dataArr[indexPath.row];
        nextVC.config = self.config;
        nextVC.area = self.area;
        nextVC.addSignRentPropertyVCBlock = ^(NSDictionary * _Nonnull dic) {
          
            [self->_dataArr replaceObjectAtIndex:idx withObject:dic];
            [tableView reloadData];
            if (self.addSignRentPropertyDetailVCBlock) {
                
                self.addSignRentPropertyDetailVCBlock(self->_dataArr);
            }
        };
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
    
    [_dataArr removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
    if (self.addSignRentPropertyDetailVCBlock) {
        
        self.addSignRentPropertyDetailVCBlock(self->_dataArr);
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"物业费详情";
    
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
