//
//  WorkRecommendValidDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkRecommendValidDetailVC.h"

#import "SignNeedInfoVC.h"
#import "SignListVC.h"

#import "BaseHeader.h"
#import "InfoDetailCell.h"
#import "ProcessCell.h"

@interface WorkRecommendValidDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _sign;
    NSArray *_signArr;
    NSArray *_arrArr;
    NSArray *_checkArr;
    NSArray *_data;
    NSArray *_titleArr;
    NSString *_clientid;
    //    NSString *_endtime;
    NSString *_name;
    NSArray *_Pace;
    NSMutableDictionary *_dataDic;
}
@property (nonatomic , strong) UITableView *validTable;

@property (nonatomic , strong) UIButton *printBtn;

@end

@implementation WorkRecommendValidDetailVC

-(instancetype)initWithClientId:(NSString *)ClientID
{
    self =[super init];
    if (self) {
        
        _clientid = ClientID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self post];
    [self initDataSouce];
    [self initUI];
}

-(void)initDataSouce
{
    _dataDic = [@{} mutableCopy];
}

-(void)post{
    [BaseRequest GET:ValueDetail_URL
          parameters:@{
                       @"client_id":_clientid
                       }
             success:^(id resposeObject) {

                 if ([resposeObject[@"code"] integerValue] ==200) {

                     self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];

                     [self->_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {

                         if ([obj isKindOfClass:[NSNull class]]) {

                             [self->_dataDic setObject:@"" forKey:key];
                         }
                     }];

                     NSString *sex = @"客户性别：";
                     if ([self->_dataDic[@"sex"] integerValue] == 1) {
                         sex = @"客户性别：男";
                     }
                     if([self->_dataDic[@"sex"] integerValue] == 2)
                     {
                         sex =@"客户性别：女";
                     }
                     self->_name = self->_dataDic[@"name"];
                     NSString *tel = self->_dataDic[@"tel"];
                     NSArray *arr = [tel componentsSeparatedByString:@","];
                     if (arr.count >0) {

                         tel = [NSString stringWithFormat:@"联系方式：%@",arr[0]];
                     }
                     else{
                         tel = @"联系方式：";
                     }
                     NSString *adress = self->_dataDic[@"absolute_address"];
                     adress = [NSString stringWithFormat:@"项目地址：%@-%@-%@ %@",self->_dataDic[@"province_name"],self->_dataDic[@"city_name"],self->_dataDic[@"district_name"],adress];

                     if ([self->_dataDic[@"tel_check_info"] isKindOfClass:[NSDictionary class]] && [self->_dataDic[@"tel_check_info"] count]) {

                         if ([self->_dataDic[@"disabled_reason"] isEqualToString:@"号码重复"]) {

                             self->_checkArr = @[[NSString stringWithFormat:@"确认人：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",self->_dataDic[@"tel_check_info"][@"confirmed_time"]],@"判重结果:不可带看"];
                         }else{

                             self->_checkArr = @[[NSString stringWithFormat:@"确认人：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",self->_dataDic[@"tel_check_info"][@"confirmed_time"]],@"判重结果:可带看"];
                         }

                     }

                     if (self->_dataDic[@"sign"]) {

                         self->_sign = YES;
                         self->_signArr = self->_dataDic[@"sign"];
                         self->_arrArr = @[[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],[NSString stringWithFormat:@"%@",tel],[NSString stringWithFormat:@"到访人数：%@人",self->_dataDic[@"visit_num"]],self->_signArr.count?[self->_signArr[0][@"state"] integerValue] == 1?[NSString stringWithFormat:@"到访时间：%@",self->_signArr[0][@"create_time"]]:@"到访时间：":[NSString stringWithFormat:@"到访时间：%@",self->_dataDic[@"visit_time"]],self->_signArr.count?[NSString stringWithFormat:@"置业顾问：%@",self->_signArr[0][@"sign_agent_name"]]:@"置业顾问：",self->_signArr.count?[NSString stringWithFormat:@"确认状态：%@",self->_signArr[self->_signArr.count - 1][@"state_name"]]:@"确认状态："];
                     }else{

                         self->_arrArr = @[[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"confirm_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"confirm_tel"]],[NSString stringWithFormat:@"到访人数：%@人",self->_dataDic[@"visit_num"]],[NSString stringWithFormat:@"到访时间：%@",self->_dataDic[@"process"][1][@"time"]],[NSString stringWithFormat:@"置业顾问：%@",self->_dataDic[@"property_advicer_wish"]],[NSString stringWithFormat:@"到访确认人：%@",self->_dataDic[@"butter_name"]],[NSString stringWithFormat:@"确认人电话：%@",self->_dataDic[@"butter_tel"]]];
                     }

                     if ([self->_dataDic[@"comsulatent_advicer"] isEqualToString:@""]) {

                         if (self->_checkArr.count) {

                             self->_titleArr = @[@"推荐信息",@"判重信息",@"到访信息"];
                             self->_data = @[@[[NSString stringWithFormat:@"推荐编号：%@",self->_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",self->_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",self->_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",self->_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",self->_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",self->_dataDic[@"client_comment"]]],self->_checkArr,self->_arrArr];
                         }else{

                             self->_titleArr = @[@"推荐信息",@"到访信息"];
                             self->_data = @[@[[NSString stringWithFormat:@"推荐编号：%@",self->_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",self->_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",self->_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",self->_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",self->_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"备注：%@",self->_dataDic[@"client_comment"]]],self->_arrArr];
                         }
                     }else{

                         if (self->_checkArr.count) {

                             self->_titleArr = @[@"推荐信息",@"判重信息",@"到访信息"];
                             self->_data = @[@[[NSString stringWithFormat:@"推荐编号：%@",self->_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",self->_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",self->_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",self->_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",self->_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",self->_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",self->_dataDic[@"client_comment"]]],self->_checkArr,self->_arrArr];
                         }else{

                             self->_titleArr = @[@"推荐信息",@"到访信息"];
                             self->_data = @[@[[NSString stringWithFormat:@"推荐编号：%@",self->_dataDic[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",self->_dataDic[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",self->_dataDic[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",self->_dataDic[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",self->_dataDic[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",self->_dataDic[@"project_name"]],adress,[NSString stringWithFormat:@"客户姓名：%@",self->_dataDic[@"name"]],sex,tel,[NSString stringWithFormat:@"置业顾问：%@",self->_dataDic[@"comsulatent_advicer"]],[NSString stringWithFormat:@"备注：%@",self->_dataDic[@"client_comment"]]],self->_arrArr];
                         }

                     }
                     //                     _endtime = _dataDic[@"timeLimit"];
                     self->_Pace = self->_dataDic[@"process"];
                     [self->_validTable reloadData];

                 }


             }
             failure:^(NSError *error) {
                 [self showContent:@"网络错误"];
             }];
}


#pragma mark    -----  delegate   ------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _data.count ? _Pace.count?_data.count + 1:_data.count:0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_checkArr.count) {
        
        if (section == 3) {
            
            return _Pace.count;
        }else{
            
            NSArray *arr = _data[section];
            return arr.count;
        }
    }else{
        
        if (section == 2) {
            
            return _Pace.count;
        }
        else
        {
            NSArray *arr = _data[section];
            return arr.count;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section < _titleArr.count) {
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        header.lineView.hidden = YES;
        
        if (section < _titleArr.count) {
            
            header.titleL.text = _titleArr[section];
        }else{
            
            header.titleL.text = @"";
        }
        
        return header;
    }else{
        
        return nil;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (_checkArr.count) {
        
        if (section == 3) {
            
            return 0 *SIZE;
        }else{
            
            return 40 *SIZE;
        }
    }else{
        
        if (section == 2) {
            
            return 0 *SIZE;
        }else{
        
            return 40 *SIZE;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 6 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_checkArr.count) {
        
        if(indexPath.section == 3){
            
            ProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessCell"];
            if (!cell) {
                cell = [[ProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProcessCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_Pace[indexPath.row][@"process_name"],_Pace[indexPath.row][@"time"]];
            if (indexPath.row == 0) {
                
                cell.upLine.hidden = YES;
            }else{
                
                cell.upLine.hidden = NO;
            }
            if (indexPath.row == _Pace.count - 1) {
                
                cell.downLine.hidden = YES;
            }else{
                
                cell.downLine.hidden = NO;
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.infoDetailCellBlock = ^{
                
                SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:self->_signArr];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            if (indexPath.section == 2) {
                
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:self->_clientid];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }
            }
            return cell;
        }
    }else{
        
        if(indexPath.section == 2){
            
            ProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProcessCell"];
            if (!cell) {
                cell = [[ProcessCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProcessCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = [NSString stringWithFormat:@"%@时间：%@",_Pace[indexPath.row][@"process_name"],_Pace[indexPath.row][@"time"]];
            if (indexPath.row == 0) {
                
                cell.upLine.hidden = YES;
            }else{
                
                cell.upLine.hidden = NO;
            }
            if (indexPath.row == _Pace.count - 1) {
                
                cell.downLine.hidden = YES;
            }else{
                
                cell.downLine.hidden = NO;
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"InfoDetailCell";
            InfoDetailCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[InfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            [cell SetCellContentbystring:_data[indexPath.section][indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.infoDetailCellBlock = ^{
                
                SignListVC *nextVC = [[SignListVC alloc] initWithDataArr:self->_signArr];
                [self.navigationController pushViewController:nextVC animated:YES];
            };
            
            if (indexPath.section == 1) {
                
                if (indexPath.row == 0) {
                    
                    if (_sign) {
                        
                        cell.moreBtn.hidden = NO;
                        [cell.moreBtn setTitle:@"查看需求信息" forState:UIControlStateNormal];
                        cell.infoDetailCellBlock = ^{
                            
                            SignNeedInfoVC *nextVC = [[SignNeedInfoVC alloc] initWithClientId:self->_clientid];
                            [self.navigationController pushViewController:nextVC animated:YES];
                        };
                    }
                }
            }
            return cell;
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"客户到访详情";
    
    _validTable = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _validTable.rowHeight = UITableViewAutomaticDimension;
    _validTable.estimatedRowHeight = 150 *SIZE;
    _validTable.backgroundColor = CLBackColor;
    _validTable.delegate = self;
    _validTable.dataSource = self;
    [_validTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_validTable];
    
}

@end
