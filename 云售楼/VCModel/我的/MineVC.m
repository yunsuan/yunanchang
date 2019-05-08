//
//  MineVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MineVC.h"

#import "PersonalVC.h"
#import "AddressBookVC.h"
#import "CompanyInfoVC.h"
#import "CompanyAuthVC.h"
#import "FeedbackVC.h"
#import "ChangePassWordVC.h"

#import "MineHeader.h"
#import "MineCell.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_imgArr;
    NSArray *_titleArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _imgArr = @[@[@"addressbook",@"company_2",@"work"],@[@"Modifythe",@"version",@"Setupthe",@"about"]];
    _titleArr = @[@[@"通讯录",@"我的公司",@"意见反馈"],@[@"修改密码",@"版本信息",@"推送设置",@"安全退出"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        return 5 *SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MineHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MineHeader"];
        if (!header) {
            
            header = [[MineHeader alloc] initWithReuseIdentifier:@"MineHeader"];
        }
        
        header.mineHeaderImgBlock = ^{
            
            PersonalVC *nextVC = [[PersonalVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        return header;
    }else{
        
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (!cell) {
        
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.section][indexPath.row];
    cell.titleImg.image = IMAGE_WITH_NAME(_imgArr[indexPath.section][indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        AddressBookVC *nextVC = [[AddressBookVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 1){
        
        CompanyInfoVC *nextVC = [[CompanyInfoVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 2){
        
        
    }else if (indexPath.row == 3){
        
        
    }
}

- (void)initUI{
    
    self.line.hidden = YES;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.bounces = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
//    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    if (@available(iOS 11.0,*)) {
        
        _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
