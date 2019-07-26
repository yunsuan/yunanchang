//
//  InstallMentDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/26.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "InstallMentDetailVC.h"

#import "InstallMentDetailCell.h"

@interface InstallMentDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;;
}

@property (nonatomic, strong) UITableView *table;


@end

@implementation InstallMentDetailVC

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InstallMentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstallMentDetailCell"];
    if (!cell) {
        
        cell = [[InstallMentDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstallMentDetailCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.contentView.backgroundColor = CLBlueBtnColor;
        cell.numL.textColor = CLWhiteColor;
        cell.moneyL.textColor = CLWhiteColor;
        cell.timeL.textColor = CLWhiteColor;
        cell.remindTimeL.textColor = CLWhiteColor;
        
        cell.timeL.text = @"还款时间";
        cell.remindTimeL.text = @"提醒时间";
        cell.numL.text = @"期数";
        cell.moneyL.text = @"金额";
    }else{
        
        cell.contentView.backgroundColor = CLWhiteColor;
        cell.numL.textColor = CLTitleLabColor;
        cell.moneyL.textColor = CLTitleLabColor;
        cell.timeL.textColor = CLTitleLabColor;
        cell.remindTimeL.textColor = CLTitleLabColor;
        
        cell.dataDic = _dataArr[indexPath.row - 1];
    }
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"分期详情";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
