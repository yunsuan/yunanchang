//
//  AddOrderRentalDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddOrderRentalDetailVC.h"

#import "ModifyAndAddRentalVC.h"

#import "BaseHeader.h"

#import "AddOrderRentalDetailCell.h"

@interface AddOrderRentalDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
 
    NSMutableArray *_dataArr;
    
    NSDateFormatter *_formatter;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation AddOrderRentalDetailVC

- (instancetype)initWithStageArr:(NSArray *)stageArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [[NSMutableArray alloc] initWithArray:stageArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    [self initUI];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    ModifyAndAddRentalVC *nextVC = [[ModifyAndAddRentalVC alloc] init];
    nextVC.area = self.area;
    nextVC.modifyAndAddRentalVCBlock = ^(NSDictionary * _Nonnull dic) {
      
        [self->_dataArr addObject:dic];
        [self->_table reloadData];
        if (self.addOrderRentalDetailVCBlock) {
            
            self.addOrderRentalDetailVCBlock(self->_dataArr);
        }
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.numberOfLines = 0;
    double money = 0;
    for (int i = 0; i < self->_dataArr.count; i++) {

       money = [self DecimalNumber:[self AddNumber:money num2:[self->_dataArr[i][@"total_rent"] doubleValue]] num2:[self->_dataArr[i][@"free_rent"] doubleValue]];
    }
    NSInteger day = 0;
    for (int i = 0; i < self->_dataArr.count; i++) {
        
        day = day + [self getDayFromDate:[self->_formatter dateFromString:self->_dataArr[i][@"free_start_time"]] withDate2:[self->_formatter dateFromString:self->_dataArr[i][@"free_end_time"]]];
    }
    header.titleL.text = [NSString stringWithFormat:@"合计总实付金额：%.2f元\n合计免租天数：%ld天",money,(long)day];
    [header.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(header.contentView).offset(0 *SIZE);
        make.top.equalTo(header.titleL.mas_bottom).offset(13 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(header.contentView).offset(0 *SIZE);
    }];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddOrderRentalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddOrderRentalDetailCell"];
    if (!cell) {
        
        cell = [[AddOrderRentalDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AddOrderRentalDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    cell.addOrderRentalDetailCellBlock = ^(NSInteger idx) {
      
        ModifyAndAddRentalVC *nextVC = [[ModifyAndAddRentalVC alloc] init];
        nextVC.dataDic = self->_dataArr[indexPath.row];
        nextVC.area = self.area;
        nextVC.modifyAndAddRentalVCBlock = ^(NSDictionary * _Nonnull dic) {
          
            [self->_dataArr replaceObjectAtIndex:idx withObject:dic];
            [tableView reloadData];
            if (self.addOrderRentalDetailVCBlock) {
                
                self.addOrderRentalDetailVCBlock(self->_dataArr);
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
    if (self.addOrderRentalDetailVCBlock) {
        
        self.addOrderRentalDetailVCBlock(self->_dataArr);
    }
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
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
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
