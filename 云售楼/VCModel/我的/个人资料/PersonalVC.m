//
//  PersonalVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "PersonalVC.h"

#import "ChangeNameVC.h"
#import "PersonalIntroVC.h"
#import "DateChooseView.h"

#import "TitleContentRightBaseCell.h"
#import "PersonalHeader.h"

@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) UITableView *personTable;

@property (nonatomic, strong) UIButton *exitBtn;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    
    _titleArr = @[@"云算号：",@"手机号：",@"姓名：",@"性别：",@"生日：",@"所在地：",@"个人说明："];
    _contentArr = [NSMutableArray arrayWithArray:@[[UserModel defaultModel].account,[UserModel defaultModel].tel,[UserModel defaultModel].name,[[UserModel defaultModel].sex integerValue] == 1?@"男":[[UserModel defaultModel].sex integerValue] == 2?@"女":@"",[UserModel defaultModel].birth,[UserModel defaultModel].absolute_address,[UserModel defaultModel].slef_desc]];
}


#pragma mark -- action

- (void)ActionExitBtn:(UIButton *)btn{
    
    
}


#pragma mark -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    PersonalHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PersonalHeader"];
    if (!header) {
        
        header = [[PersonalHeader alloc] initWithReuseIdentifier:@"PersonalHeader"];
    }
    
    header.personalHeaderBlock = ^{
      
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传头像"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            //            [self selectPhotoAlbumPhotos];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            //            [self takingPictures];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        }]];
        [self presentViewController:alertController animated:YES completion:^{
        
        }];
    };
    
    return header;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 51 *SIZE;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TitleContentRightBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentRightBaseCell"];
    if (!cell) {
        
        cell = [[TitleContentRightBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalTableCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
//    cell.contentL.text = @"333333";
    cell.contentL.text = _contentArr[indexPath.row];
    if (indexPath.row > 3) {
        
        cell.rightImg.hidden = NO;
    }else{
        
        cell.rightImg.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        
        ChangeNameVC *nextVC = [[ChangeNameVC alloc] initWithName:@""];
        nextVC.changeNameVCBlock = ^(NSString *str) {
            
            [self->_contentArr replaceObjectAtIndex:2 withObject:[UserModel defaultModel].name];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 3){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSDictionary *dic = @{@"sex":@"1"};
            [BaseRequest POST:UserPersonalChangeAgentInfo_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [UserModel defaultModel].sex = @"1";
                    [UserModelArchiver archive];
                    [tableView reloadData];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }];
        
        UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSDictionary *dic = @{@"sex":@"2"};
            [BaseRequest POST:UserPersonalChangeAgentInfo_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [UserModel defaultModel].sex = @"2";
                    [UserModelArchiver archive];
                    [tableView reloadData];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:male];
        [alert addAction:female];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 4){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        view.dateblock = ^(NSDate *date) {
            
            NSDictionary *dic = @{@"birth":[self->_formatter stringFromDate:date]};
            [BaseRequest POST:UserPersonalChangeAgentInfo_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [UserModel defaultModel].birth = [self->_formatter stringFromDate:date];
                    [UserModelArchiver archive];
                    [tableView reloadData];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        };
        [self.view addSubview:view];
    }else if (indexPath.row == 5){
        
        
    }else if (indexPath.row == 6){
        
        PersonalIntroVC *nextVC = [[PersonalIntroVC alloc] initWithIntro:@""];
        nextVC.personalIntroVCBlock = ^(NSString *str) {
            
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"个人信息";
    
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _personTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _personTable.estimatedSectionHeaderHeight = 100 *SIZE;
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.bounces = NO;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
    
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.frame = CGRectMake(0, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, SCREEN_Width, 50 *SIZE + TAB_BAR_MORE);
    _exitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_exitBtn addTarget:self action:@selector(ActionExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_exitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:CLBlueBtnColor];
//    [_exitBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [self.view addSubview:_exitBtn];
}

@end
