//
//  StageDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/25.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "StageDetailVC.h"

#import "BaseHeader.h"
#import "StageDetailCell.h"

@interface StageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    
    NSDateFormatter *_formatter;
}

@property (nonatomic, strong) UITableView *table;;

@end

@implementation StageDetailVC

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
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    [self initUI];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.numberOfLines = 0;
    double money = 0;
    for (int i = 0; i < self->_dataArr.count; i++) {

        money = [self AddNumber:money num2:[self->_dataArr[i][@"total_rent"] doubleValue]];
    }
    NSInteger day = 0;
    for (int i = 0; i < self->_dataArr.count; i++) {
        
        if (self->_dataArr[i][@"free_start_time"] && ![self->_dataArr[i][@"free_start_time"] isKindOfClass:[NSNull class]]) {
            
            if (self->_dataArr[i][@"free_end_time"] && ![self->_dataArr[i][@"free_end_time"] isKindOfClass:[NSNull class]]) {
                
                day = day + [self getDayFromDate:[self->_formatter dateFromString:self->_dataArr[i][@"free_start_time"]] withDate2:[self->_formatter dateFromString:self->_dataArr[i][@"free_end_time"]]];
            }
        }
        
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StageDetailCell"];
    if (!cell) {
        
        cell = [[StageDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"StageDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = _dataArr[indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"租金详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
