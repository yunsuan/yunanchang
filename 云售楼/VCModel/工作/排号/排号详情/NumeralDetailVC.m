//
//  NumeralDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/1.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralDetailVC.h"

#import "AddEncumbrancerVC.h"

#import "NumeralDetailHeader.h"
#import "BaseHeader.h"

#import "CallTelegramCustomDetailInfoCell.h"

@interface NumeralDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation NumeralDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataArr = @[@[],@[@"姓名：李翠花",@"手机：183333333",@"证件类型：身份证",@"证件号码：123123123123",@"出生日期：2019.01.01",@"通讯地址：四川成都市",@"邮政编码：232323",@"产权比例：50",@"类型：附权益人"],@[@"f登记时间：2019-03-19",@"登记人：李强",@"归属时间：2019-03-10"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        NumeralDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NumeralDetailHeader"];
        if (!header) {
            
            header = [[NumeralDetailHeader alloc] initWithReuseIdentifier:@"NumeralDetailHeader"];
        }
        
        header.dataDic = @{};
        
        header.numeralDetailHeaderAddBlock = ^{
            
            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.numeralDetailHeaderEditBlock = ^{
            
        };
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        if (section == 1) {
            
            header.titleL.text = @"权益人信息";
        }else{
            
            header.titleL.text = @"审核信息";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
    if (!cell) {
        
        cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = _dataArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"排号详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
