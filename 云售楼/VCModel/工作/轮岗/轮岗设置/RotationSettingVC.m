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
#import "BorderTextField.h"
#import "HMChooseView.h"
#import "AddCompanyView.h"
#import "AddCompanyVC.h"
#import "AddPeopleVC.h"
#import "RotationModel.h"


@interface RotationSettingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *companyArr;
}

@property (nonatomic , strong) UITableView *SettingTable;

@property (nonatomic , strong) UIButton *SureBtn;

@property (nonatomic , strong) UIView *TableHeader;

@property (nonatomic, strong) DropBtn *beginTime;

@property (nonatomic, strong) DropBtn *endTime;

@property (nonatomic , strong) BorderTextField *downTF;

@property (nonatomic , strong) BorderTextField *upTF;

@property (nonatomic , strong) AddCompanyView *addCompanyView;

@end

@implementation RotationSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    companyArr = [@[] mutableCopy];
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
    NSString *personjson;
    NSString *companyjson;
    
    [BaseRequest POST:Dutyadd_URL
           parameters:@{@"project_id":[UserModel defaultModel].projectinfo[@"project_id"],
                        @"exchange_time_min":_downTF.textField.text,
                        @"tip_time_min":_upTF.textField.text,
                        @"start_time":_beginTime.content.text,
                        @"end_time":_endTime.content.text,
                        @"person_list":personjson,
                        @"company_list":companyjson
                        }
              success:^(id  _Nonnull resposeObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)action_begin
{
    HMChooseView *picker = [[HMChooseView alloc] initDatePackerWithStartHour:@"00" endHour:@"24" period:15 selectedHour:@"08" selectedMin:@"13"];
    picker.dateblock = ^(NSString * _Nonnull date) {
        
        self->_beginTime.content.text = date;
    };
    [picker show];
}

-(void)action_end
{
    HMChooseView *picker = [[HMChooseView alloc] initDatePackerWithStartHour:@"00" endHour:@"24" period:1 selectedHour:@"08" selectedMin:@"13"];
    picker.dateblock = ^(NSString * _Nonnull date) {
        
        self->_endTime.content.text = date;
    };
    [picker show];
}

-(void)action_people:(UIButton *)sender
{
    AddPeopleVC *next_vc = [[AddPeopleVC alloc]init];
    next_vc.company_id = companyArr[sender.tag][@"company_id"];
    next_vc.selectPeople = [companyArr[sender.tag][@"list"] mutableCopy];
    next_vc.addBtnBlock = ^(NSDictionary * _Nonnull dic) {
        
        NSMutableArray *list = [[NSMutableArray alloc] initWithArray:self->companyArr[sender.tag][@"list"]];
        [list addObject:dic];
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->companyArr[sender.tag]];
        [tempDic setObject:list forKey:@"list"];
        [self->companyArr replaceObjectAtIndex:sender.tag withObject:tempDic];
        [self->_SettingTable reloadData];
    };
    [self.navigationController pushViewController:next_vc animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleNone;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return companyArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.indexPathsForSelectedRows.count>1) {
        [tableView deselectRowAtIndexPath:tableView.indexPathsForSelectedRows[0] animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *list = companyArr[section][@"list"];
    return list.count;
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
    header.companyL.text = companyArr[section][@"company_name"];
    header.addBtn.tag = section;
    [header.addBtn addTarget:self action:@selector(action_people:) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RotationSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RotationSettingCell"];
    if (!cell) {
        
        cell = [[RotationSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RotationSettingCell"];
    }
    
    cell.nameL.text = companyArr[indexPath.section][@"list"][indexPath.row][@"name"];
    cell.phoneL.text = companyArr[indexPath.section][@"list"][indexPath.row][@"tel"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.rotationSettingCellDeleleBtnBlock = ^{
      
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self->companyArr[indexPath.section][@"list"]];
        [tempArr removeObjectAtIndex:indexPath.row];
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:self->companyArr[indexPath.section]];
        [tempDic setObject:tempArr forKey:@"list"];
        [self->companyArr replaceObjectAtIndex:indexPath.section withObject:tempDic];
        [tableView reloadData];
    };
    
    cell.rotationSettingCellSleepBtnBlock = ^{
        
    };
    
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
        NSArray *arr = @[@"每日轮岗开始时间：",@"每日轮岗结束时间：",@"自然下位时间(分):",@"上位提醒时间(分):"];
        for (int i = 0; i<4; i++) {
            UILabel *lab =  [[UILabel alloc]initWithFrame:CGRectMake(8*SIZE, 25*SIZE+55*SIZE*i, 110*SIZE, 13*SIZE)];
            lab.text =arr[i];
            lab.textColor = CLTitleLabColor;
            lab.font = FONT(12);
            [_TableHeader addSubview:lab];
        }
        [_TableHeader addSubview:self.beginTime];
        [_TableHeader addSubview:self.endTime];
        [_TableHeader addSubview:self.downTF];
        [_TableHeader addSubview:self.upTF];
        
        UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, 230*SIZE, 360*SIZE, 7*SIZE)];
        view.backgroundColor = COLOR(240, 240, 240, 1);
        [_TableHeader addSubview:view];
        [_TableHeader addSubview:self.addCompanyView];
    } 
    return _TableHeader;
}


-(DropBtn *)beginTime
{
    if (!_beginTime) {
        _beginTime = [[DropBtn alloc]initWithFrame:CGRectMake(121*SIZE, 13*SIZE, 216*SIZE, 33*SIZE)];
        [_beginTime addTarget:self action:@selector(action_begin) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _beginTime;
}

-(DropBtn *)endTime
{
    if (!_endTime) {
        _endTime = [[DropBtn alloc]initWithFrame:CGRectMake(121*SIZE, 68*SIZE, 216*SIZE, 33*SIZE)];
        [_endTime addTarget:self action:@selector(action_end) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _endTime;
}

-(BorderTextField *)downTF
{
    if (!_downTF) {
        _downTF = [[BorderTextField alloc]initWithFrame:CGRectMake(121*SIZE, 123*SIZE, 216*SIZE, 33*SIZE)];
        _downTF.textField.placeholder = @"设置为0则无自然下岗";
    }
    return _downTF;
}


-(BorderTextField *)upTF
{
    if (!_upTF) {
        _upTF = [[BorderTextField alloc]initWithFrame:CGRectMake(121*SIZE, 178*SIZE, 216*SIZE, 33*SIZE)];
    }
    return _upTF;
}


-(AddCompanyView *)addCompanyView
{
    if(!_addCompanyView)
    {
        _addCompanyView = [[AddCompanyView alloc]initWithFrame:CGRectMake(0, 240*SIZE, 360*SIZE, 103*SIZE)];
        _addCompanyView.dataArr = companyArr;
        
        SS(strongSelf);
        _addCompanyView.deletBtnBlock = ^{
            self->companyArr = self->_addCompanyView.dataArr;
            [strongSelf->_SettingTable reloadData];
        };
        
        _addCompanyView.addBtnBlock = ^{
            
            AddCompanyVC *next_vc = [[AddCompanyVC alloc]init];
            next_vc.selectCompany = strongSelf->companyArr;
            next_vc.addBtnBlock = ^(NSMutableDictionary * _Nonnull dic) {
 
                [strongSelf->companyArr addObject:dic];
                strongSelf->_addCompanyView.dataArr = strongSelf->companyArr;
                [strongSelf->_addCompanyView.tagColl reloadData];
                [strongSelf->_SettingTable reloadData];
            };
            [strongSelf.navigationController pushViewController:next_vc animated:YES];
            
        };
    }
    return _addCompanyView;
}

@end
