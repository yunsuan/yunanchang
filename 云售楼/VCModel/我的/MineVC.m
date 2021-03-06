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
#import "CompanyAuthingVC.h"
#import "FeedbackVC.h"
#import "ChangePassWordVC.h"
#import "PushSettingVC.h"

#import "CodeScanVC.h"
#import "WorkRecommendWaitDetailVC.h"

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
    if (![UserInfoModel defaultModel].account.length) {
        
        [self RequestMethod];
    }
}

- (void)RequestMethod{
    
    [BaseRequest GET:UserPersonalGetAgentInfo_URL parameters:@{} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }
    }];
    [UserInfoModel defaultModel].absolute_address = tempDic[@"absolute_address"];
    [UserInfoModel defaultModel].account = tempDic[@"account"];
    [UserInfoModel defaultModel].birth = tempDic[@"birth"];
    [UserInfoModel defaultModel].city = tempDic[@"city"];
    [UserInfoModel defaultModel].district = tempDic[@"district"];
    [UserInfoModel defaultModel].head_img = tempDic[@"head_img"];
    [UserInfoModel defaultModel].name = tempDic[@"name"];
    [UserInfoModel defaultModel].province = tempDic[@"province"];
    [UserInfoModel defaultModel].sex = [NSString stringWithFormat:@"%@",tempDic[@"sex"]];
    [UserInfoModel defaultModel].tel = tempDic[@"tel"];
//    [UserInfoModel defaultModel].slef_desc = tempDic[@"self_desc"];
    [UserInfoModel defaultModel].self_desc = [NSString stringWithFormat:@"%@",tempDic[@"self_desc"]];
    [UserInfoModel defaultModel].slef_desc = [NSString stringWithFormat:@"%@",tempDic[@"slef_desc"]];
    [UserInfoModel defaultModel].wx_code = [NSString stringWithFormat:@"%@",tempDic[@"wx_code"]];
    [UserModelArchiver infoArchive];
    [_table reloadData];
}

- (void)initDataSource{
    
    _imgArr = @[@[@"addressbook",@"scan",@"company_2",@"work"],@[@"Modifythe",@"version",@"Setupthe",@"about"]];
    _titleArr = @[@[@"通讯录",@"扫一扫",@"我的公司",@"意见反馈"],@[@"修改密码",@"版本信息",@"推送设置",@"安全退出"]];
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
        
        header.dataDic = [[UserInfoModel defaultModel] modeltodic];
        
        header.mineHeaderImgBlock = ^{
            
            PersonalVC *nextVC = [[PersonalVC alloc] init];
            nextVC.personalVCBlock = ^{
              
                [tableView reloadData];
            };
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
    if (indexPath.section ==1&&indexPath.row ==1) {
        cell.contentL.text = YACversion;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            AddressBookVC *nextVC = [[AddressBookVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 2){
            
            [BaseRequest GET:CompanyAuthInfo_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if ([resposeObject[@"data"] count]) {
                        
                        if ([resposeObject[@"data"][0][@"state"] integerValue] == 0) {
                            
//                            CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
//                            [self.navigationController pushViewController:nextVC animated:YES];
                            CompanyInfoVC *nextVC = [[CompanyInfoVC alloc] initWithDataArr:resposeObject[@"data"]];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }else if ([resposeObject[@"data"][0][@"state"] integerValue] == 1){
                            
                            CompanyInfoVC *nextVC = [[CompanyInfoVC alloc] initWithDataArr:resposeObject[@"data"]];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }else{
                            
                            CompanyAuthingVC *nextVC = [[CompanyAuthingVC alloc] initWithDataArr:resposeObject[@"data"]];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }
                    }else{
                        
                        CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
            
        }else if(indexPath.row == 3){
            
            FeedbackVC *nextVC = [[FeedbackVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            CodeScanVC *nextVC = [[CodeScanVC alloc] init];
            nextVC.codeScanVCBlock = ^(NSString * _Nonnull str) {
              
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    WorkRecommendWaitDetailVC *nextVC = [[WorkRecommendWaitDetailVC alloc] initWithString:str];
//                    nextVC.needConfirm = @"1";
                    [self.navigationController pushViewController:nextVC animated:YES];
                });
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }else{
        
        if (indexPath.row == 0) {
            
            ChangePassWordVC *nextVC = [[ChangePassWordVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 1){
            
            
        }else if (indexPath.row == 2){
            
            PushSettingVC *nextVC = [[PushSettingVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            
        }else if (indexPath.row == 3){
            
            [self alertControllerWithNsstring:@"退出" And:@"你确认要退出登录吗？" WithCancelBlack:^{
                
            } WithDefaultBlack:^{
                
                [BaseRequest GET:UserPersonalLogOut_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                    [UserModelArchiver ClearModel];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goLoginVC" object:nil];
                } failure:^(NSError * _Nonnull error) {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
                    [UserModelArchiver ClearModel];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goLoginVC" object:nil];
                }];
            }];
        }
    }
    
}

- (void)initUI{
    
    self.line.hidden = YES;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.bounces = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
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
