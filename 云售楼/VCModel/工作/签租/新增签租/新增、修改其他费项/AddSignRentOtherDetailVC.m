//
//  AddSignRentOtherDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/7.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentOtherDetailVC.h"

#import "AddSignRentOtherVC.h"

#import "AddSignRentOtherCell.h"

@interface AddSignRentOtherDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
 
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation AddSignRentOtherDetailVC

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
    
    AddSignRentOtherVC *nextVC = [[AddSignRentOtherVC alloc] init];
    nextVC.excuteArr = self.excuteArr;
    nextVC.addSignRentOtherVCBlock = ^(NSDictionary * _Nonnull dic) {
      
        [self->_dataArr addObject:dic];
        [self->_table reloadData];
        if (self.addSignRentOtherDetailVCBlock) {
            
            self.addSignRentOtherDetailVCBlock(self->_dataArr);
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddSignRentOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddSignRentOtherCell"];
    if (!cell) {
        
        cell = [[AddSignRentOtherCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddSignRentOtherCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.addSignRentOtherCellBlock = ^(NSInteger idx) {
      
        AddSignRentOtherVC *nextVC = [[AddSignRentOtherVC alloc] init];
        nextVC.dataDic = self->_dataArr[indexPath.row];
        nextVC.excuteArr = self.excuteArr;
        nextVC.addSignRentOtherVCBlock = ^(NSDictionary * _Nonnull dic) {
          
            [self->_dataArr replaceObjectAtIndex:indexPath.row withObject:dic];
            [tableView reloadData];
            if (self.addSignRentOtherDetailVCBlock) {
                
                self.addSignRentOtherDetailVCBlock(self->_dataArr);
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
    if (self.addSignRentOtherDetailVCBlock) {
        
        self.addSignRentOtherDetailVCBlock(self->_dataArr);
    }
}

- (void)initUI{
    
    self.titleLabel.text = @"费项详情";
    
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
