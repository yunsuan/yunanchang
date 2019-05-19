//
//  AbdicateVC.m
//  云售楼
//
//  Created by xiaoq on 2019/5/19.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AbdicateVC.h"
#import "AbdicateCell.h"
#import "AbdicateHeaderView.h"

@interface AbdicateVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *AbdicateTable;

@property (nonatomic , strong) UIButton *SureBtn;

@end

@implementation AbdicateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)initUI{
    
    self.titleLabel.text = @"选择让位人员";
    
    self.leftButton.hidden = NO;
    [self.view addSubview:self.AbdicateTable];
    [self.view addSubview:self.SureBtn];

    
}

-(void)action_sure
{
    NSLog(@"%@",_AbdicateTable.indexPathsForSelectedRows);
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
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

    AbdicateHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AbdicateHeaderView"];
    if (!header) {
        header = [[AbdicateHeaderView alloc]initWithReuseIdentifier: @"AbdicateHeaderView"];
    }


    return header;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AbdicateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AbdicateCell"];
    if (!cell) {
        
        cell = [[AbdicateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AbdicateCell"];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}




-(UITableView *)AbdicateTable
{
    if (!_AbdicateTable) {
        _AbdicateTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _AbdicateTable.delegate = self;
        _AbdicateTable.dataSource = self;
        _AbdicateTable.backgroundColor = CLWhiteColor;
        _AbdicateTable.editing = YES;
        [_AbdicateTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _AbdicateTable;
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

@end
