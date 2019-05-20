//
//  RotationSettingVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/18.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "RotationSettingVC.h"
#import "RotationSettingCell.h"
#import "CompanyHeader.h"

#import "DropBtn.h"
#import "DateChooseView.h"




@interface RotationSettingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *SettingTable;

@property (nonatomic , strong) UIButton *SureBtn;

@property (nonatomic , strong) UIView *TableHeader;

@property (nonatomic, strong) DropBtn *beginTime;

@property (nonatomic, strong) DropBtn *endTime;


@end

@implementation RotationSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI{
    
    self.titleLabel.text = @"轮岗设置";
    self.leftButton.hidden = NO;
    [self.view addSubview:self.SettingTable];
    [self.view addSubview:self.SureBtn];
    
    
}

-(void)action_sure
{
//    NSLog(@"%@",_AbdicateTable.indexPathsForSelectedRows);
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleNone;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.indexPathsForSelectedRows.count>1) {
        [tableView deselectRowAtIndexPath:tableView.indexPathsForSelectedRows[0] animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 37*SIZE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73*SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CompanyHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CompanyHeader"];
    if (!header) {
        header = [[CompanyHeader alloc]initWithReuseIdentifier: @"CompanyHeader"];
    }

    return header;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RotationSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RotationSettingCell"];
    if (!cell) {
        
        cell = [[RotationSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RotationSettingCell"];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}




-(UITableView *)SettingTable
{
    if (!_SettingTable) {
        _SettingTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _SettingTable.delegate = self;
        _SettingTable.dataSource = self;
        _SettingTable.backgroundColor = CLWhiteColor;
        _SettingTable.tableHeaderView = self.TableHeader;
//        _SettingTable.editing = YES;
        [_SettingTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _SettingTable;
}

-(UIButton *)SureBtn
{
    if (!_SureBtn) {
        _SureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _SureBtn.frame = CGRectMake(0, SCREEN_Height-TAB_BAR_HEIGHT, 360*SIZE, TAB_BAR_HEIGHT);
        _SureBtn.backgroundColor = CLBlueBtnColor;
        _SureBtn.titleLabel.font = FONT(15);
        [_SureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_SureBtn setTitleColor:CLWhiteColor forState:UIControlStateNormal];
        [_SureBtn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SureBtn;
}

-(UIView *)TableHeader{
    if (!_TableHeader) {
        _TableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 350*SIZE)];
        
    
    }
    return _TableHeader;
}


   





@end
