
//
//  PaymentInfoVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/13.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PaymentInfoVC.h"

#import "CallTelegramCustomDetailInfoCell.h"

#import "BaseHeader.h"

@interface PaymentInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@end

@implementation PaymentInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = [NSString stringWithFormat:@"%@",self.dataArr[section][@"bill_code"]];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
    if (!cell) {
        
        cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.contentL.text = [NSString stringWithFormat:@"费项名称：%@",self.dataArr[indexPath.section][@"type"]];
    }else if (indexPath.row == 1){
        
        cell.contentL.text = [NSString stringWithFormat:@"收款方式：%@",self.dataArr[indexPath.section][@"receive_type_list"]];
    }else if (indexPath.row == 2){
        
        cell.contentL.text = [NSString stringWithFormat:@"收款日期：%@",self.dataArr[indexPath.section][@"receive_time"]];
    }else if (indexPath.row == 3){
        
        cell.contentL.text = [NSString stringWithFormat:@"收款金额：%@元",self.dataArr[indexPath.section][@"receive_num_total"]];
    }else{
        
        cell.contentL.text = [NSString stringWithFormat:@"收款人：%@",self.dataArr[indexPath.section][@"sign_agent_name"]];
    }
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"付款信息";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
