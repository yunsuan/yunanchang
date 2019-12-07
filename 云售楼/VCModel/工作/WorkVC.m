//
//  WorkVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkVC.h"
#import "PowerMannerger.h"

#import "CallTelegramVC.h"
#import "WorkPhoneConfirmVC.h"
#import "WorkRecommendVC.h"
#import "VisitCustomVC.h"
#import "WorkPersonAuditVC.h"
#import "WorkReceiptDetailVC.h"
//#import "AuditTaskVC.h"
#import "RotationVC.h"
#import "CompanyAuthVC.h"
#import "NumeralVC.h"
#import "OrderVC.h"
#import "SignVC.h"
#import "QueryPhoneVC.h"
#import "StoreVC.h"
#import "IntentStoreVC.h"
#import "OrderRentVC.h"
#import "SignRentVC.h"

#import "SinglePickView.h"

#import "WorkCell.h"

@interface WorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    NSArray *_projectArr;
    
    NSArray *_showArr;
    NSMutableArray *_powerArr;
    
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation WorkVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[UserModel defaultModel].projectinfo count]) {
        
        _table.hidden = NO;
    }else{
        
        _table.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ActionNSNotificationMethod) name:@"reloadCompanyInfo" object:nil];
    
//    if ([UserModel defaultModel].agent_company_info_id) {
//
//        _imgArr = @[@"laidian",@"ys_find",@"recommended",@"laifang",@"paihao",@"subscribe",@"signing_2",@"shoukuan_2",@"audit",@"rotational",@"sjmerchant_1",@"sjmerchant_1",@"sjmerchant_1",@"sjmerchant_1",@"icon_phone"];
//        _titleArr = @[@"来电",@"带看",@"推荐",@"来访",@"排号",@"定单",@"签约",@"收款",@"人事",@"轮岗",@"商家",@"意向商家",@"定租",@"签租",@"号码查询"];
//    }
    _imgArr = @[@"laidian",@"ys_find",@"recommended",@"laifang",@"paihao",@"subscribe",@"signing_2",@"shoukuan_2",@"audit",@"rotational",@"sjmerchant_1",@"sjmerchant_1",@"sjmerchant_1",@"sjmerchant_1",@"icon_phone"];
    _titleArr = @[@"来电",@"带看",@"推荐",@"来访",@"排号",@"定单",@"签约",@"收款",@"人事",@"轮岗",@"商家",@"意向商家",@"定租",@"签租",@"号码查询"];
    
    _projectArr = [UserModel defaultModel].project_list;
    _showArr = [PowerModel defaultModel].WorkListPower;
    _powerArr = [@[] mutableCopy];
    for (int i = 0; i < _imgArr.count; i++) {
        
        [_powerArr addObject:@""];
    }
}

- (void)ActionNSNotificationMethod{
    
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];
    if ([[UserModel defaultModel].projectinfo count]) {
    
        _table.hidden = NO;
        self.rightBtn.hidden = NO;
        [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
            if ([result isEqualToString:@"获取权限成功"]) {
                self->_showArr = [PowerModel defaultModel].WorkListPower;
                [self->_table reloadData];
                [self RequestMethod];
            }
        } failure:^(NSString * _Nonnull error) {
            [self showContent:error];
        }];
    }else{
    
        _table.hidden = YES;
        self.rightBtn.hidden = YES;;
    }
}


- (void)RequestMethod{

    if ([[UserModel defaultModel].projectinfo count]) {
        
        [BaseRequest GET:WorkCount_URL parameters:@{@"project_id":[UserModel defaultModel].projectinfo[@"project_id"]} success:^(id  _Nonnull resposeObject) {
            
            [self->_table.mj_header endRefreshing];
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                //            [UserModel defaultModel].projectPowerDic = resposeObject[@"data"];
                [self SetData:resposeObject[@"data"]];
                
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self->_table.mj_header endRefreshing];
            [self showContent:@"网路错误"];
        }];
    }
    
}

- (void)SetData:(NSDictionary *)data{

    if (!_powerArr.count) {
        
        _powerArr = [@[] mutableCopy];
        for (int i = 0; i < _imgArr.count; i++) {
            
            [_powerArr addObject:@""];
        }
    }
    
//    [_powerArr removeAllObjects];
    [_powerArr replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,到访%@",data[@"telVisit"][@"today"],data[@"telVisit"][@"total"],data[@"telVisit"][@"visit"]]];
    [_powerArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"今日推荐%@,可带看%@",data[@"telCheck"][@"total"],data[@"telCheck"][@"value"]]];
    [_powerArr replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"今日推荐%@,到访%@,累计%@",data[@"recommend"][@"today"],data[@"recommend"][@"value"],data[@"recommend"][@"total"]]];
    [_powerArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"今日新增%@,回访%@,累计%@",data[@"visit"][@"today"],data[@"visit"][@"review"],data[@"visit"][@"total"]]];
    [_powerArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@",data[@"row"][@"today"],data[@"row"][@"total"]]];
//    [_powerArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"row"][@"today"],data[@"row"][@"total"],data[@"row"][@""]]];
    [_powerArr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"sub"][@"today"],data[@"sub"][@"total"],data[@"sub"][@"wait"]]];
//    [_powerArr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"sub"][@"today"],data[@"sub"][@"totol"],data[@"row"][@"wait"]]];
    [_powerArr replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"contract"][@"today"],data[@"contract"][@"total"],data[@"contract"][@"wait"]]];
//    [_powerArr replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"contract"][@"today"],data[@"contract"][@"totol"],data[@"sub"][@"wait"]]];
    [_powerArr replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"今日新增%@,换票%@",data[@"receive"][@"today"],data[@"receive"][@"wait"]]];
    [_powerArr replaceObjectAtIndex:8 withObject:[NSString stringWithFormat:@"待审核%@",data[@"matter"][@"wait"]]];
    if (data[@"duty"][@"current"]) {
        
        [_powerArr replaceObjectAtIndex:9 withObject:[NSString stringWithFormat:@"当前A位：%@",data[@"duty"][@"current"]]];
    }
    if ([_showArr[10] integerValue]) {
        
        [_powerArr replaceObjectAtIndex:10 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"business"][@"today"],data[@"business"][@"total"],data[@"business"][@"wait"]]];
    }
    if ([_showArr[11] integerValue]) {
        
        [_powerArr replaceObjectAtIndex:11 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@",data[@"trade_row"][@"today"],data[@"trade_row"][@"total"]]];
    }
    if ([_showArr[12] integerValue]) {
        
        [_powerArr replaceObjectAtIndex:12 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"trade_sub"][@"today"],data[@"trade_sub"][@"total"],data[@"trade_sub"][@"wait"]]];
    }
    if ([_showArr[13] integerValue]) {
        
        [_powerArr replaceObjectAtIndex:13 withObject:[NSString stringWithFormat:@"今日新增%@,累计%@,变更%@",data[@"trade_contact"][@"today"],data[@"trade_contact"][@"total"],data[@"trade_contact"][@"wait"]]];
    }
    [_table reloadData];
}

- (void)ActionGoBtn:(UIButton *)btn{
    
    CompanyAuthVC *nextVC = [[CompanyAuthVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    NSMutableArray *temparr = [@[] mutableCopy];
        for (int i = 0; i < [_projectArr count]; i++) {
            
            NSDictionary *dic = @{@"id":[NSString stringWithFormat:@"%d",i],
                                  @"param":_projectArr[i][@"project_name"]
                                  };
            [temparr addObject:dic];
        
    }
    
    SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:temparr];
    view.selectedBlock = ^(NSString *MC, NSString *ID) {
        
        [self.rightBtn setTitle:MC forState:UIControlStateNormal];
        [UserModel defaultModel].projectinfo =  [UserModel defaultModel].project_list[[ID integerValue]];
        [UserModelArchiver archive];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCompanyInfo" object:nil];
        [PowerMannerger RequestPowerByprojectID:[UserModel defaultModel].projectinfo[@"project_id"] success:^(NSString * _Nonnull result) {
            if ([result isEqualToString:@"获取权限成功"]) {
                self->_showArr = [PowerModel defaultModel].WorkListPower;
                [self->_table reloadData];
            }
        } failure:^(NSString * _Nonnull error) {
            [self showContent:error];
        }];
    };

    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_showArr[indexPath.row] integerValue] == 1) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkCell"];
    if (!cell) {
        
        cell = [[WorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell SetImg:_imgArr[indexPath.row] title:_titleArr[indexPath.row] content:_powerArr[indexPath.row]];
    if ([_showArr[indexPath.row] integerValue] == 1) {
        
        cell.hidden = NO;
    }else{
        
        cell.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        CallTelegramVC * nextVC = [[CallTelegramVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.powerDic = [PowerModel defaultModel].telCallPower;
        nextVC.callTelegramVCBlock = ^{
          
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 1){
        
        WorkPhoneConfirmVC *nextVC = [[WorkPhoneConfirmVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 2){
        
        WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 3){
        
        VisitCustomVC *nextVC = [[VisitCustomVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.powerDic = [PowerModel defaultModel].visitPower;//_powerArr[3];
        nextVC.projectName = [UserModel defaultModel].projectinfo[@"project_name"];
        nextVC.visitCustomVCBlock = ^{
          
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 4){
        
        NumeralVC *nextVC = [[NumeralVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.projectName = [UserModel defaultModel].projectinfo[@"project_name"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 5){
        
        OrderVC *nextVC = [[OrderVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.projectName = [UserModel defaultModel].projectinfo[@"project_name"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 6){
        
        SignVC *nextVC = [[SignVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.projectName = [UserModel defaultModel].projectinfo[@"project_name"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 7){
        
        WorkReceiptDetailVC *nextVC = [[WorkReceiptDetailVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 8){
        
        
        WorkPersonAuditVC *nextVC = [[WorkPersonAuditVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 9){
        
        RotationVC *nextVC = [[RotationVC alloc]initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"]];
        nextVC.status = [[PowerModel defaultModel].WorkListPower[9] integerValue];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 10){
        
        StoreVC *nextVC = [[StoreVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.powerDic = [PowerModel defaultModel].storePower;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 11){
        
        IntentStoreVC *nextVC = [[IntentStoreVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.powerDic = [PowerModel defaultModel].intentStorePower;
        nextVC.projectName = [UserModel defaultModel].projectinfo[@"project_name"];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 12){
        
        OrderRentVC *nextVC = [[OrderRentVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.powerDic = [PowerModel defaultModel].orderStorePower;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 13){
        
        SignRentVC *nextVC = [[SignRentVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        nextVC.powerDic = [PowerModel defaultModel].signStorePower;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        QueryPhoneVC *nextVC = [[QueryPhoneVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
        [self.navigationController pushViewController:nextVC animated:YES];
//        NumeralVC *nextVC = [[NumeralVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
//        AuditTaskVC *nextVC = [[AuditTaskVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"工作";
    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 45 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:[UserModel defaultModel].projectinfo[@"project_name"] forState:UIControlStateNormal];

    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(3 *SIZE, 7 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width - 6 *SIZE, 167 *SIZE)];
    whiteView.backgroundColor = CLWhiteColor;
    whiteView.layer.cornerRadius = 7 *SIZE;
    whiteView.clipsToBounds = YES;
    [self.view addSubview:whiteView];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(151 *SIZE, 36 *SIZE, 57 *SIZE, 57 *SIZE)];
    img.image = IMAGE_WITH_NAME(@"company");
    [whiteView addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110 *SIZE, SCREEN_Width - 6 *SIZE, 13 *SIZE)];
    label.textColor = CL86Color;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"您目前没有进行公司认证，请先认证公司！";
    [whiteView addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(97 *SIZE, 31 *SIZE + CGRectGetMaxY(whiteView.frame), 167 *SIZE, 40 *SIZE);
    btn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [btn addTarget:self action:@selector(ActionGoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"去认证" forState:UIControlStateNormal];
    [btn setBackgroundColor:CLBlueBtnColor];
    btn.layer.cornerRadius = 3 *SIZE;
    btn.clipsToBounds = YES;
    [self.view addSubview:btn];
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        
        [self RequestMethod];
    }];
    
    if ([UserModel defaultModel].projectinfo) {
        
        _table.hidden = NO;
    }else{
        
        _table.hidden = YES;
    }
}

@end
