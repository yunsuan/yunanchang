//
//  NumeralAuditDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "NumeralAuditDetailVC.h"


#import "BaseHeader.h"
#import "NumeralAuditDetailCell.h"
#import "ContentBaseCell.h"

@interface NumeralAuditDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *auditBtn;

@end

@implementation NumeralAuditDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionAuditBtn:(UIButton *)btn{
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }else{
        
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.lineView.hidden = YES;
    if (section == 1) {
        
        header.titleL.text = @"权益人信息";
    }else{
        
        header.titleL.text = @"交易信息";
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NumeralAuditDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NumeralAuditDetailCell"];
        if (!cell) {
            
            cell = [[NumeralAuditDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NumeralAuditDetailCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = @{};
        
        return cell;
    }else{
        
        ContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentBaseCell"];
        if (!cell) {
            
            cell = [[ContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentBaseCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentL.text = @"1231231231";
        
        return cell;
    }
}


- (void)initUI{
    
    self.titleLabel.text = @"排号详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
    
    _auditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _auditBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    _auditBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_auditBtn addTarget:self action:@selector(ActionAuditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_auditBtn setTitle:@"审核" forState:UIControlStateNormal];
    [_auditBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_auditBtn];
}

@end
