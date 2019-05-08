//
//  CompanyInfoVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/9.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyInfoVC.h"

#import "CompanyInfoCell.h"

@interface CompanyInfoVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation CompanyInfoVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompanyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyInfoCell"];
    if (!cell) {
        
        cell = [[CompanyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CompanyInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataDic = @{};
    if (indexPath.row == 0) {
        
        cell.backView.backgroundColor = CLBlueBtnColor;
        cell.upLine.hidden = YES;
    }else{
        
        cell.upLine.hidden = NO;
        cell.backView.backgroundColor = CLWhiteColor;
    }
    
    if (indexPath.row ==2) {
        
        cell.downLine.hidden = YES;
    }else{
        
        cell.downLine.hidden = NO;
    }
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"我的公司";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE - 43 *SIZE) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"离职" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundColor:CLBlueBtnColor];
    [self.view addSubview:_cancelBtn];
}
@end
