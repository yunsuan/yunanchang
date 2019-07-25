//
//  OrderDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "OrderDetailVC.h"

#import "AddSignVC.h"
#import "ModifyOrderVC.h"

#import "NumeralDetailHeader.h"
#import "BaseHeader.h"
#import "CallTelegramCustomDetailInfoCell.h"

@interface OrderDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_sub_id;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_dataArr;
    NSMutableArray *_personArr;
    NSString *_advicer_id;
    NSString *_advicer;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation OrderDetailVC

- (instancetype)initWithSubId:(NSString *)sub_id
{
    self = [super init];
    if (self) {
        
        _sub_id = sub_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    //    _dataArr = @[@[],@[@"姓名：李翠花",@"手机：183333333",@"证件类型：身份证",@"证件号码：123123123123",@"出生日期：2019.01.01",@"通讯地址：四川成都市",@"邮政编码：232323",@"产权比例：50",@"类型：附权益人"],@[@"f登记时间：2019-03-19",@"登记人：李强",@"归属时间：2019-03-10"]];
    _personArr = [@[] mutableCopy];
    _dataArr = [@[] mutableCopy];
    _dataDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectHouseGetProjectSubDetail_URL parameters:@{@"sub_id":_sub_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_personArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"beneficiary"]];
            self->_advicer = resposeObject[@"data"][@"advicer"][0][@"name"];
            self->_advicer_id = resposeObject[@"data"][@"advicer"][0][@"advicer_id"];
            self->_dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            self->_dataArr = [NSMutableArray arrayWithArray:
                              @[
                                @[],
                                @[[NSString stringWithFormat:@"姓名：%@",self->_dataDic[@"beneficiary"][0][@"name"]],[NSString stringWithFormat:@"手机：%@",self->_dataDic[@"beneficiary"][0][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",self->_dataDic[@"beneficiary"][0][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",self->_dataDic[@"beneficiary"][0][@"card_num"]],[NSString stringWithFormat:@"出生日期：%@",self->_dataDic[@"beneficiary"][0][@"birth"]],[NSString stringWithFormat:@"通讯地址：%@",self->_dataDic[@"beneficiary"][0][@"address"]],[NSString stringWithFormat:@"邮政编码：%@",self->_dataDic[@"beneficiary"][0][@"mail_code"]],[NSString stringWithFormat:@"产权比例：%@%@",self->_dataDic[@"beneficiary"][0][@"property"],@"%"],[NSString stringWithFormat:@"类型：%@",[self->_dataDic[@"beneficiary"][0][@"beneficiary_type"] integerValue] == 1? @"主权益人":@"附权益人"]],
                                @[[NSString stringWithFormat:@"房间号码：%@",self->_dataDic[@"house_name"]],[NSString stringWithFormat:@"公示总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"物业类型：%@",self->_dataDic[@"property_type"]],[NSString stringWithFormat:@"建筑面积：%@㎡",self->_dataDic[@"estimated_build_size"]],[NSString stringWithFormat:@"套内面积：%@㎡",self->_dataDic[@"indoor_size"]],[NSString stringWithFormat:@"公摊面积：%@㎡",self->_dataDic[@"public_size"]]],
                                @[[NSString stringWithFormat:@"登记时间：%@",self->_dataDic[@"sub_time"]],[NSString stringWithFormat:@"登记人：%@",self->_dataDic[@"sign_agent_name"]],[NSString stringWithFormat:@"归属时间：%@",self->_dataDic[@"own_time"]]]]];
            if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"一次性付款"]) {
                
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"sub_code"]],[NSString stringWithFormat:@"房屋总价：%@元",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@元",self->_dataDic[@"sub_total_price"]],[NSString stringWithFormat:@"套内单价：%@元/㎡",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@元/㎡",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@元",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]]]];
                if ([self->_dataDic[@"discount"] count]) {
                    
                    float discount = 0;
                    for (int i = 0; i < [self->_dataDic[@"discount"] count]; i++) {
                        
                        discount += [self->_dataDic[@"discount"][i][@"num"] doubleValue];
                    }
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f",discount] atIndex:2];
                }else{
                    
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%@",@"0"] atIndex:2];
                }
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"分期付款"]){
                
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"公积金贷款"]){
                
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"sub_code"]],[NSString stringWithFormat:@"房屋总价：%@",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@",self->_dataDic[@"sub_total_price"]],[NSString stringWithFormat:@"套内单价：%@",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]],[NSString stringWithFormat:@"首付金额：%@",self->_dataDic[@"back"][0][@"name"]],[NSString stringWithFormat:@"贷款金额：%@",self->_dataDic[@"back"][0][@"loan_money"]],[NSString stringWithFormat:@"按揭银行：%@",self->_dataDic[@"back"][0][@"bank_id"]],[NSString stringWithFormat:@"按揭年限：%@",self->_dataDic[@"back"][0][@"loan_limit"]]]];
                if ([self->_dataDic[@"discount"] count]) {
                    
                    float discount = 0;
                    for (int i = 0; i < [self->_dataDic[@"discount"] count]; i++) {
                        
                        discount += [self->_dataDic[@"discount"][i][@"num"] doubleValue];
                    }
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f",discount] atIndex:2];
                }else{
                    
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%@",@"0"] atIndex:2];
                }
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"综合贷款"]){
                
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"sub_code"]],[NSString stringWithFormat:@"房屋总价：%@",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@",self->_dataDic[@"sub_total_price"]],[NSString stringWithFormat:@"套内单价：%@",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]],[NSString stringWithFormat:@"首付金额：%@",self->_dataDic[@"back"][0][@"name"]],[NSString stringWithFormat:@"商业贷款金额：%@",self->_dataDic[@"back"][0][@"bank_loan_money"]],[NSString stringWithFormat:@"商业按揭银行：%@",self->_dataDic[@"back"][0][@"bank_bank_id"]],[NSString stringWithFormat:@"商业按揭年限：%@",self->_dataDic[@"back"][0][@"bank_loan_limit"]],[NSString stringWithFormat:@"公积金贷款金额：%@",self->_dataDic[@"back"][0][@"fund_loan_money"]],[NSString stringWithFormat:@"公积金按揭银行：%@",self->_dataDic[@"back"][0][@"fund_bank_id"]],[NSString stringWithFormat:@"公积金按揭年限：%@",self->_dataDic[@"back"][0][@"fund_loan_limit"]]]];
                if ([self->_dataDic[@"discount"] count]) {
                    
                    float discount = 0;
                    for (int i = 0; i < [self->_dataDic[@"discount"] count]; i++) {
                        
                        discount += [self->_dataDic[@"discount"][i][@"num"] doubleValue];
                    }
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f",discount] atIndex:2];
                }else{
                    
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%@",@"0"] atIndex:2];
                }
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else if ([self->_dataDic[@"pay_way_name"] isEqualToString:@"银行按揭贷款"]){
                
                NSMutableArray *discountArr = [[NSMutableArray alloc] initWithArray:@[[NSString stringWithFormat:@"合同编号：%@",self->_dataDic[@"sub_code"]],[NSString stringWithFormat:@"房屋总价：%@",self->_dataDic[@"total_price"]],[NSString stringWithFormat:@"签约总价：%@",self->_dataDic[@"sub_total_price"]],[NSString stringWithFormat:@"套内单价：%@",self->_dataDic[@"inner_unit_price"]],[NSString stringWithFormat:@"建筑单价：%@",self->_dataDic[@"build_unit_price"]],[NSString stringWithFormat:@"付款金额：%@",self->_dataDic[@"down_pay"]],[NSString stringWithFormat:@"付款方式：%@",self->_dataDic[@"pay_way_name"]],[NSString stringWithFormat:@"首付金额：%@",self->_dataDic[@"back"][0][@"name"]],[NSString stringWithFormat:@"贷款金额：%@",self->_dataDic[@"back"][0][@"loan_money"]],[NSString stringWithFormat:@"按揭银行：%@",self->_dataDic[@"back"][0][@"bank_id"]],[NSString stringWithFormat:@"按揭年限：%@",self->_dataDic[@"back"][0][@"loan_limit"]]]];
                if ([self->_dataDic[@"discount"] count]) {
                    
                    float discount = 0;
                    for (int i = 0; i < [self->_dataDic[@"discount"] count]; i++) {
                        
                        discount += [self->_dataDic[@"discount"][i][@"num"] doubleValue];
                    }
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%.2f",discount] atIndex:2];
                }else{
                    
                    [discountArr insertObject:[NSString stringWithFormat:@"优惠金额：%@",@"0"] atIndex:2];
                }
                [self->_dataArr insertObject:discountArr atIndex:3];
            }else{
                
                
            }
            [self->_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *sign = [UIAlertAction actionWithTitle:@"转签约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddSignVC *nextVC = [[AddSignVC alloc] initWithRow_id:self->_sub_id personArr:self->_personArr project_id:self.project_id info_id:@""];
        nextVC.from_type = @"1";
        nextVC.advicer_id = [NSString stringWithFormat:@"%@",self->_advicer_id];
        nextVC.advicer_name = [NSString stringWithFormat:@"%@",self->_advicer];;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:sign];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{

    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        NumeralDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NumeralDetailHeader"];
        if (!header) {
            
            header = [[NumeralDetailHeader alloc] initWithReuseIdentifier:@"NumeralDetailHeader"];
        }
        
        //
        header.dataDic = self->_dataDic;
        header.moneyL.text = [NSString stringWithFormat:@"诚意金：%@",self->_dataDic[@"down_pay"]];
        header.num = _num;
        
        header.numeralDetailHeaderAddBlock = ^{
            
//            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.numeralDetailHeaderEditBlock = ^{
            
            ModifyOrderVC *nextVC = [[ModifyOrderVC alloc] initWithSubId:self->_sub_id projectId:self->_project_id info_Id:@"" dataDic:self->_dataDic];
            nextVC.from_type = @"1";
            nextVC.modifyOrderVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.numeralDetailHeaderCollBlock = ^(NSInteger index) {
            
            self->_num = index;
            NSArray *arr = @[[NSString stringWithFormat:@"姓名：%@",self->_dataDic[@"beneficiary"][index][@"name"]],[NSString stringWithFormat:@"手机：%@",self->_dataDic[@"beneficiary"][index][@"tel"]],[NSString stringWithFormat:@"证件类型：%@",self->_dataDic[@"beneficiary"][index][@"card_type"]],[NSString stringWithFormat:@"证件号码：%@",self->_dataDic[@"beneficiary"][index][@"card_num"]],[NSString stringWithFormat:@"出生日期：%@",self->_dataDic[@"beneficiary"][index][@"birth"]],[NSString stringWithFormat:@"通讯地址：%@",self->_dataDic[@"beneficiary"][index][@"address"]],[NSString stringWithFormat:@"邮政编码：%@",self->_dataDic[@"beneficiary"][index][@"name"]],[NSString stringWithFormat:@"产权比例：%@",self->_dataDic[@"beneficiary"][index][@"property"]],[NSString stringWithFormat:@"类型：%@",[self->_dataDic[@"beneficiary"][index][@"beneficiary_type"] integerValue] == 1? @"主权益人":@"附权益人"]];
            [self->_dataArr replaceObjectAtIndex:1 withObject:arr];
            [tableView reloadData];
        };
        
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        if (section == 1) {
            
            header.titleL.text = @"权益人信息";
        }else if (section == 2) {
            
            header.titleL.text = @"房屋概况";
        }else if (section == 3) {
            
            header.titleL.text = @"订单信息";
        }else{
            
            header.titleL.text = @"审核信息";
        }
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
    if (!cell) {
        
        cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.contentL.text = _dataArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)initUI{
    
    self.titleLabel.text = @"认购详情";
    self.navBackgroundView.backgroundColor = CLBlueBtnColor;
    self.line.hidden = YES;
    self.titleLabel.textColor = CLWhiteColor;
    
    [self.leftButton setImage:[UIImage imageNamed:@"leftarrow_white"] forState:UIControlStateNormal];
    self.rightBtn.hidden = NO;
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add_2") forState:UIControlStateNormal];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSelectionStyleNone;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
}

@end
