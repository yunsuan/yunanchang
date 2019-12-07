//
//  StoreDetailVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "StoreDetailVC.h"

#import "AddStoreVC.h"
#import "AddStoreNeedVC.h"
#import "AddStoreFollowRecordVC.h"
#import "AddOrderRentVC.h"
#import "AddSignRentVC.h"

#import "AddIntentStoreVC.h"

#import "StoreDetailHeader.h"
#import "CallTelegramCustomDetailInfoCell.h"
#import "ContentBaseCell.h"
#import "BaseAddCell.h"
#import "StoreDetailFollowCell.h"

@interface StoreDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSInteger _index;
//    NSInteger _num;
    NSString *_businessId;
    
    NSMutableDictionary *_storeDic;
    
    NSMutableArray *_infoDataArr;
    NSMutableArray *_brandArr;
    NSMutableArray *_followArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation StoreDetailVC

- (instancetype)initWithBusinessId:(NSString *)businessId
{
    self = [super init];
    if (self) {
        
        _businessId = businessId;
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
    
//    _groupInfoDic = [@{} mutableCopy];
    
//    _propertyArr = [@[] mutableCopy];
    _infoDataArr = [@[] mutableCopy];
//    _peopleArr = [@[] mutableCopy];
    _brandArr = [@[] mutableCopy];
    _followArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectBusinessDetail_URL parameters:@{@"business_id":_businessId} success:^(id  _Nonnull resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            self->_storeDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            self->_followArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"follow_list"]];
            [self->_infoDataArr removeAllObjects];
            self->_infoDataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][@"need_list"]];
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

    UIAlertAction *intent = [UIAlertAction actionWithTitle:@"添加意向" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddIntentStoreVC *nextVC = [[AddIntentStoreVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
        nextVC.dataDic = self->_storeDic;
        nextVC.addIntentStoreVCBlock = ^{

            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *sign = [UIAlertAction actionWithTitle:@"转签租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddSignRentVC *nextVC = [[AddSignRentVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
        nextVC.from_type = @"1";
        nextVC.dataDic = self->_storeDic;
        nextVC.addSignRentVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    UIAlertAction *order = [UIAlertAction actionWithTitle:@"转定租" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
//        if ([self->_storeDic[@"receive_state"] integerValue] == 1) {

        AddOrderRentVC *nextVC = [[AddOrderRentVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
            nextVC.from_type = @"2";
            nextVC.dataDic = self->_storeDic;
            nextVC.addOrderRentVCBlock = ^{

                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//    
//            [self showContent:@"未收款不能转定单"];
//        }
    }];
    
//    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"作废" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//        [self alertControllerWithNsstring:@"温馨提示" And:@"" WithCancelBlack:^{
//
//        } WithDefaultBlack:^{
//
//            [BaseRequest POST:ShopRowTradeRowDel_URL parameters:@{@"row_id":self->_businessId} success:^(id  _Nonnull resposeObject) {
//
//                if ([resposeObject[@"code"] integerValue] == 200) {
//
//                    [self showContent:@"作废成功"];
//
//                    [self.navigationController popViewControllerAnimated:YES];
//                }else{
//
//                    [self showContent:resposeObject[@"msg"]];
//                }
//            } failure:^(NSError * _Nonnull error) {
//
//                [self showContent:@"网络错误"];
//            }];
//        }];
//    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alert addAction:intent];
//    if ([self->_dataDic[@"disabled_state"] integerValue] == 0 && [self->_dataDic[@"check_state"] integerValue] == 1 && [self->_dataDic[@"receive_state"] integerValue] == 1) {
    //
        [alert addAction:order];
//    }
    [alert addAction:sign];

    
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark -- delegate --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_index == 0) {
        
        return _infoDataArr.count ? 2:1;
    }else{
        
        return _followArr.count ? 2 : 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        if (_index == 0) {
            
            return 0;
        }else{
            
            if ([self.powerDic[@"update"] boolValue]) {
            
                return 1;
            }
            return 0;
        }
    }else{
        
        if (_index == 0) {
            
            return _infoDataArr.count;
        }else{
            
            return _followArr.count;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        if (_index == 0) {
            
            return 0;
        }else if (_index == 1){
            
            return UITableViewAutomaticDimension;
        }else{
            
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGFLOAT_MIN;
    }else{
        
        if (_index == 0) {
            
            return CGFLOAT_MIN;
        }else if (_index == 1){
            
            return 10 *SIZE;
        }else{
            
            return 10 *SIZE;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        StoreDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreDetailHeader"];
        if (!header) {
            
            header = [[StoreDetailHeader alloc] initWithReuseIdentifier:@"StoreDetailHeader"];
        }
        
        if ([self.powerDic[@"update"] boolValue]) {

            header.editBtn.hidden = NO;
            
        }else{

            header.editBtn.hidden = YES;
        }
        
        
        header.dataDic = _storeDic;

        [header.infoBtn setBackgroundColor:CL248Color];
        [header.infoBtn setTitleColor:CL178Color forState:UIControlStateNormal];
        [header.followBtn setBackgroundColor:CL248Color];
        [header.followBtn setTitleColor:CL178Color forState:UIControlStateNormal];
        
        if (_index == 0) {
            
            [header.infoBtn setBackgroundColor:CLBlueBtnColor];
            [header.infoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            [header.followBtn setBackgroundColor:CLBlueBtnColor];
            [header.followBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        header.storeDetailHeaderEditBlock  = ^(NSInteger index) {

            AddStoreVC *vc = [[AddStoreVC alloc] initWithProjectId:self->_project_id info_id:self->_info_id];
            vc.storeDic = self->_storeDic;
            vc.business_id = [NSString stringWithFormat:@"%@",self->_storeDic[@"business_id"]];
            vc.addStoreVCBlock = ^{

                [self RequestMethod];
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        header.storeDetailHeaderTagBlock = ^(NSInteger index) {

            self->_index = index;
            if (index == 0) {


            }else{


            }
            [tableView reloadData];
        };
        
        return header;
    }else{
        
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
        
        CallTelegramCustomDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CallTelegramCustomDetailInfoCell"];
        if (!cell) {
            
            cell = [[CallTelegramCustomDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CallTelegramCustomDetailInfoCell"];
        }
        
        if (indexPath.row == 0) {
            
            if ([self.powerDic[@"update"] boolValue]) {

                cell.editBtn.hidden = NO;

            }else{

                cell.editBtn.hidden = YES;
            }
        }else{

            cell.editBtn.hidden = YES;
            cell.deleteBtn.hidden = YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:@""];
        cell.contentL.attributedText = attribtStr;
        cell.contentL.text = [NSString stringWithFormat:@"%@：%@",_infoDataArr[indexPath.row][@"defined_name"],_infoDataArr[indexPath.row][@"value"]];

        
        cell.callTelegramCustomDetailInfoCellEditBlock = ^{

            AddStoreNeedVC *nextVC = [[AddStoreNeedVC alloc] initWithData:self->_infoDataArr];
            nextVC.business_id = [NSString stringWithFormat:@"%@",self->_storeDic[@"business_id"]];
            nextVC.project_id = self->_project_id;
            nextVC.addStoreNeedVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        return cell;
    }else{
        
        if (indexPath.section == 0) {
            
            BaseAddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseAddCell"];
            if (!cell) {
                
                cell = [[BaseAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseAddCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.titleL.text = @"添加跟进";
            return cell;
        }
        StoreDetailFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreDetailFollowCell"];
        if (!cell) {
            
            cell = [[StoreDetailFollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreDetailFollowCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = _followArr[indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_index == 0) {
        
    }else{
        
        if (indexPath.section == 0) {

            AddStoreFollowRecordVC *vc = [[AddStoreFollowRecordVC alloc] init];
            if (_followArr.count) {

                vc.followDic = [[NSMutableDictionary alloc] initWithDictionary:_followArr[0]];
            }else{

                vc.followDic = [@{} mutableCopy];
            }
            vc.project_id = self.project_id;
            vc.business_id = [NSString stringWithFormat:@"%@",self->_storeDic[@"business_id"]];
            vc.status = @"direct";
            vc.addStoreFollowRecordVCBlock = ^{

                [self RequestMethod];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.backgroundColor = CLBlueBtnColor;
    self.titleLabel.text = @"商家详情";
    self.titleLabel.textColor = CLWhiteColor;
    [self.leftButton setImage:[UIImage imageNamed:@"leftarrow_white"] forState:UIControlStateNormal];
    
    
    if ([self.powerDic[@"contract"] boolValue] || [self.powerDic[@"row"] boolValue] || [self.powerDic[@"contract"] boolValue] || [self.powerDic[@"update"] boolValue]) {

        self.rightBtn.hidden = NO;
    }else{

        self.rightBtn.hidden = YES;
    }

    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:IMAGE_WITH_NAME(@"add_2") forState:UIControlStateNormal];
    self.line.hidden = YES;
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _table.estimatedRowHeight = 367 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 320 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
}

@end
