//
//  CompanyAuthingVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/11.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CompanyAuthingVC.h"

#import "BaseHeader.h"
#import "CompanyAuthingCell.h"

@interface CompanyAuthingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_data;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation CompanyAuthingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    
    
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"温馨提示" And:@"你确认要取消当前公司认证？" WithCancelBlack:^{
        
    } WithDefaultBlack:^{
        
    }];
    
}

#pragma mark    -----  delegate   ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CompanyAuthingCell";
    
    CompanyAuthingCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CompanyAuthingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"审核状态";
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 150 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 2 *SIZE;
    _cancelBtn.backgroundColor = CLBlueBtnColor;
    [_cancelBtn setTitle:@"取消认证" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
}
@end
