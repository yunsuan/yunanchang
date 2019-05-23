//
//  PushSettingVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/20.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "PushSettingVC.h"

#import "PushSettingCell.h"

@interface PushSettingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
}
@property (nonatomic, strong) UITableView *personTable;

@end

@implementation PushSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"全部提醒",@"客户跟进提醒",@"移动审核提醒",@"渠道客户到访确认提醒",@"项目数据统计提醒"];
//    _contentArr = [[NSMutableArray alloc] initWithArray:@[@"云算号",@"",@"姓名",@"电话号码",@"性别",@"出生年月",@"住址",@"******",@""]];
    
}



#pragma mark -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __strong PushSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushSettingCell"];
    if (!cell) {
        
        cell = [[PushSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PushSettingCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
    
    cell.contentL.hidden = YES;
    cell.headImg.hidden = YES;
    cell.OnOff.hidden = NO;
    cell.rightView.hidden = YES;
    cell.pushSettingCellSwitchBlock = ^{
        
        if (cell.OnOff.on) {
            
            [cell.OnOff setOn:NO];
        }else{
            
            [cell.OnOff setOn:YES];
        }
//        switch (indexPath.row) {
//            case 0:
//            {
//                if (cell.OnOff.on) {
//
//                    [cell.OnOff setOn:NO];
//                }else{
//
//                    [cell.OnOff setOn:YES];
//                }
//                break;
//            }
//            default:
//                break;
//        }
    };

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"推送设置";
    
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
    
}

@end
