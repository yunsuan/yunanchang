//
//  WorkPersonAuditDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkPersonAuditDetailVC.h"

#import "BaseHeader.h"
#import "ContentBaseCell.h"

@interface WorkPersonAuditDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_data;
}
@property (nonatomic , strong) UITableView *Maintableview;

@property (nonatomic, strong) UIButton *refuseBtn;

@property (nonatomic , strong) UIButton *confirmBtn;

@end

@implementation WorkPersonAuditDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)ActionRefuseBtn:(UIButton *)btn{
    
    
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

#pragma mark    -----  delegate   ------


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _data.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    header.titleL.text = @"审核信息";
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ContentBaseCell";
    ContentBaseCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[ContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = _data[indexPath.row];
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"确认中详情";
    
    _Maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT- 40 *SIZE - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _Maintableview.rowHeight = UITableViewAutomaticDimension;
    _Maintableview.estimatedRowHeight = 150 *SIZE;
    _Maintableview.backgroundColor = CLBackColor;
    _Maintableview.delegate = self;
    _Maintableview.dataSource = self;
    [_Maintableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
    //
    //        _Maintableview.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT);
    //    }
    
    [self.view addSubview:_Maintableview];
    
    _refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _refuseBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 120 *SIZE, 40 *SIZE + TAB_BAR_MORE);
    _refuseBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_refuseBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [_refuseBtn setBackgroundColor:COLOR(191, 191, 191, 1)];
    [self.view addSubview:_refuseBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 240 *SIZE, 40 *SIZE + TAB_BAR_MORE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
    
}

@end
