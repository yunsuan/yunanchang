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
    
    _titleArr = @[@"云算号",@"我的二维码",@"姓名",@"电话号码",@"性别",@"出生年月",@"住址",@"修改密码",@"接收抢/派单消息"];
//    _contentArr = [[NSMutableArray alloc] initWithArray:@[@"云算号",@"",@"姓名",@"电话号码",@"性别",@"出生年月",@"住址",@"******",@""]];
    
}



#pragma mark -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
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
//    cell.contentL.text = _contentArr[(NSUInteger) indexPath.row];
    
    cell.contentL.hidden = YES;
    cell.headImg.hidden = YES;
    cell.OnOff.hidden = NO;
    cell.rightView.hidden = YES;
    cell.pushSettingCellSwitchBlock = ^{
        
//        if ([[UserInfoModel defaultModel].is_accept_grab integerValue] == 1) {
        
            [cell.OnOff setOn:NO];
//            [BaseRequest POST:UpdatePersonal_URL parameters:@{@"is_accept_grab":@"0",@"is_accept_msg":@"0"} success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//
//                    [UserInfoModel defaultModel].is_accept_grab = @"0";
//                    [UserInfoModel defaultModel].is_accept_msg = @"0";
//                    [UserModelArchiver infoArchive];
//                }else{
//
//                    [cell.OnOff setOn:YES];
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError *error) {
//
//                [cell.OnOff setOn:YES];
//                NSLog(@"%@",error);
//                [self showContent:@"网络错误"];
//            }];
//        }else{
        
            [cell.OnOff setOn:YES];
//            [BaseRequest POST:UpdatePersonal_URL parameters:@{@"is_accept_grab":@"1",@"is_accept_msg":@"1"} success:^(id resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    [UserInfoModel defaultModel].is_accept_grab = @"1";
//                    [UserInfoModel defaultModel].is_accept_msg = @"1";
//                    [UserModelArchiver infoArchive];
//                }else{
//
//                    [cell.OnOff setOn:NO];
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError *error) {
//
//                [cell.OnOff setOn:NO];
//                NSLog(@"%@",error);
//                [self showContent:@"网络错误"];
//            }];
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
