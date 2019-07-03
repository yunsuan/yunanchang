//
//  OrderDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/3.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "OrderDetailVC.h"

#import "NumeralDetailHeader.h"
#import "BaseHeader.h"
#import "CallTelegramCustomDetailInfoCell.h"

@interface OrderDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataArr = @[@[],@[@"姓名：李翠花",@"手机：183333333",@"证件类型：身份证",@"证件号码：123123123123",@"出生日期：2019.01.01",@"通讯地址：四川成都市",@"邮政编码：232323",@"产权比例：50",@"类型：附权益人"],@[@"房号：3-2701",@"公示总价：",@"计价规则：",@"物业类型：",@"户型：",@"建筑面积：",@"套内面积：",@"公摊面积："],@[@"订单编号",@"公示总价：",@"优惠金额：",@"认购总价：",@"套内单价：",@"建筑单价：",@"定金金额：",@"付款日期：",@"付款方式："],@[@"登记时间：2019-03-19",@"登记人：李强",@"归属时间：2019-03-10"]];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
//    UIAlertAction *numeral = [UIAlertAction actionWithTitle:@"作废" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        NumeralDetailInvalidView *view = [[NumeralDetailInvalidView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
//        [self.view addSubview:view];
//    }];
//
//    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"审核" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//        NumeralDetailAuditVC *nextVC = [[NumeralDetailAuditVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }];
//
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    [alert addAction:numeral];
//    [alert addAction:quit];
//    [alert addAction:cancel];
//    [self.navigationController presentViewController:alert animated:YES completion:^{
//
//    }];
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
        
        header.dataDic = @{};
        
        header.numeralDetailHeaderAddBlock = ^{
            
//            AddEncumbrancerVC *nextVC = [[AddEncumbrancerVC alloc] init];
//            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.numeralDetailHeaderEditBlock = ^{
            
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
    
    self.titleLabel.text = @"订单详情";
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
