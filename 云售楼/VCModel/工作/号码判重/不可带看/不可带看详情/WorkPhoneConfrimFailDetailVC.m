//
//  WorkPhoneConfrimFailDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkPhoneConfrimFailDetailVC.h"

#import "ContentBaseCell.h"
#import "BaseHeader.h"

@interface WorkPhoneConfrimFailDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSString *_clientId;
    NSDictionary *_dataDic;
    //    NSString *_phone;
}

@property (nonatomic, strong) UITableView *detailTable;

@end

@implementation WorkPhoneConfrimFailDetailVC

- (instancetype)initWithClientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        
        _clientId = clientId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self RequestMethod];
}

-(void)refresh{
    
    //    [BaseRequest GET:HouseSurveyTimeOut_URL parameters:nil success:^(id resposeObject) {
    //
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"secReload" object:nil];
    //        [self.navigationController popViewControllerAnimated:YES];
    //    } failure:^(NSError *error) {
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }];
}

- (void)RequestMethod{
    
    [BaseRequest GET:DisabledDetail_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self SetData:resposeObject[@"data"]];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _dataDic = data;
    if ([data[@"disabled_reason"] isEqualToString:@"号码重复"]) {
        
        _titleArr = @[@[[NSString stringWithFormat:@"失效原因：%@",data[@"disabled_reason"]],[NSString stringWithFormat:@"失效时间：%@",data[@"disabled_time"]]],@[[NSString stringWithFormat:@"确认人：%@",data[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",data[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",data[@"tel_check_info"][@"confirmed_time"]],@"判重结果：不可带看"],@[[NSString stringWithFormat:@"推荐编号：%@",data[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",data[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",data[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",data[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",data[@"project_name"]],[NSString stringWithFormat:@"项目地址：%@",data[@"absolute_address"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"sex"] integerValue] == 1 ? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"tel"]],[NSString stringWithFormat:@"备注：%@",data[@"client_comment"]]]];
    }else{
        
        _titleArr = @[@[[NSString stringWithFormat:@"失效原因：%@",data[@"disabled_reason"]],[NSString stringWithFormat:@"失效时间：%@",data[@"disabled_time"]]],@[[NSString stringWithFormat:@"确认人：%@",data[@"tel_check_info"][@"confirmed_agent_name"]],[NSString stringWithFormat:@"联系方式：%@",data[@"tel_check_info"][@"confirmed_agent_tel"]],[NSString stringWithFormat:@"确认时间：%@",data[@"tel_check_info"][@"confirmed_time"]],@"判重结果：可带看"],@[[NSString stringWithFormat:@"推荐编号：%@",data[@"client_id"]],[NSString stringWithFormat:@"推荐时间：%@",data[@"create_time"]],[NSString stringWithFormat:@"推荐类别：%@",data[@"recommend_type"]],[NSString stringWithFormat:@"推荐人：%@",data[@"broker_name"]],[NSString stringWithFormat:@"联系方式：%@",data[@"broker_tel"]],[NSString stringWithFormat:@"项目名称：%@",data[@"project_name"]],[NSString stringWithFormat:@"项目地址：%@",data[@"absolute_address"]],[NSString stringWithFormat:@"客户姓名：%@",data[@"name"]],[NSString stringWithFormat:@"客户性别：%@",[data[@"sex"] integerValue] == 1 ? @"男":@"女"],[NSString stringWithFormat:@"联系方式：%@",data[@"tel"]],[NSString stringWithFormat:@"备注：%@",data[@"client_comment"]]]];
    }
    
    [_detailTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
    if (!header) {
        
        header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
    }
    
    if (section == 2) {
        
        header.titleL.text = @"推荐信息";
    }else if(section == 1){
        
        header.titleL.text = @"判重信息";
    }else{
        
        header.titleL.text = @"失效信息";
    }
    header.lineView.hidden = YES;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentBaseCell"];
    if (!cell) {
        
        cell = [[ContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentBaseCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lineView.hidden = YES;
    
    cell.contentL.text = _titleArr[indexPath.section][indexPath.row];
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"已失效详情";
    self.navBackgroundView.hidden = NO;
    
    _detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    
    _detailTable.rowHeight = UITableViewAutomaticDimension;
    _detailTable.estimatedRowHeight = 31 *SIZE;
    _detailTable.backgroundColor = self.view.backgroundColor;
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_detailTable];
    
}

@end
