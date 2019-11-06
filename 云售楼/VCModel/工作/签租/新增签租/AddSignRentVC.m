//
//  AddSignRentVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/11/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignRentVC.h"

#import "AddIntentSelectStoreVC.h"
#import "AddStoreVC.h"

#import "AddNemeralHeader.h"
#import "AddIntentStoreRoomView.h"
#import "AddNumeralProcessView.h"
#import "AddIntentStoreInfoView.h"
#import "AddNumeralFileView.h"
#import "AddSignRentAreaView.h"
#import "AddOrderRentInfoView.h"
#import "AddOrderRentPriceView.h"

#import "SinglePickView.h"

@interface AddSignRentVC ()
{
    
    NSString *_info_id;
    NSString *_project_id;
    NSString *_role_id;
    
    NSArray *_titleArr;
    
    NSMutableDictionary *_progressDic;
    
    NSMutableArray *_roomArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_progressArr;
    NSMutableArray *_progressAllArr;
    NSMutableArray *_roleArr;
    NSMutableArray *_rolePersonArr;
    NSMutableArray *_rolePersonSelectArr;
    NSMutableArray *_imgArr;
    
    NSDateFormatter *_secondFormatter;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) AddNemeralHeader *roomHeader;

@property (nonatomic, strong) AddIntentStoreRoomView *addIntentStoreRoomView;

@property (nonatomic, strong) AddNemeralHeader *areaHeader;

@property (nonatomic, strong) AddSignRentAreaView *areaView;

@property (nonatomic, strong) AddNemeralHeader *storeHeader;

@property (nonatomic, strong) AddIntentStoreInfoView *addIntentStoreInfoView;

@property (nonatomic, strong) AddNemeralHeader *signHeader;

@property (nonatomic, strong) AddOrderRentInfoView *signView;

@property (nonatomic, strong) AddNemeralHeader *priceHeader;

@property (nonatomic, strong) AddOrderRentPriceView *priceView;

@property (nonatomic, strong) AddNemeralHeader *propertyHeader;

@property (nonatomic, strong) AddOrderRentPriceView *propertyView;

@property (nonatomic, strong) AddNemeralHeader *processHeader;

@property (nonatomic, strong) AddNumeralProcessView *addNumeralProcessView;

@property (nonatomic, strong) AddNemeralHeader *addNumeralFileHeader;

@property (nonatomic, strong) AddNumeralFileView *addNumeralFileView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddSignRentVC

- (instancetype)initWithProjectId:(NSString *)projectId info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _project_id = projectId;
        _info_id = info_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"房源信息",@"商家信息",@"意向信息",@"流程信息"];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0,@0,@0,@0,@0,@0]];
    
    _progressDic = [@{} mutableCopy];
    
    _roomArr = [@[] mutableCopy];
    
    _progressArr = [@[] mutableCopy];
    _progressAllArr = [@[] mutableCopy];
    
    _roleArr = [@[] mutableCopy];
    _rolePersonArr = [@[] mutableCopy];
    _rolePersonSelectArr = [@[] mutableCopy];
    _imgArr = [@[] mutableCopy];
    
    _secondFormatter = [[NSDateFormatter alloc] init];
    [_secondFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
}

- (void)RequestMethod{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"project_id":_project_id}];
    
    if (_role_id.length) {
        
        [dic setObject:_role_id forKey:@"role_id"];
    }
    
    [BaseRequest GET:ProjectRolePersonList_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_rolePersonArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0 ; i < [resposeObject[@"data"] count]; i++) {
                
                [self->_rolePersonSelectArr addObject:@0];
            }
            self->_addNumeralProcessView.personArr = self->_rolePersonArr;
            self->_addNumeralProcessView.personSelectArr = self->_rolePersonSelectArr;
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

-(void)updateheadimgbyimg:(UIImage *)img{
    
    NSData *data = [self resetSizeOfImageData:img maxSize:150];

    NSString *name = [self->_secondFormatter stringFromDate:[NSDate date]];
    [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
        
    } url:UploadFile_URL parameters:@{@"file_name":@"img"} success:^(id  _Nonnull resposeObject) {
        
       if ([resposeObject[@"code"] integerValue] == 200) {

           [self->_imgArr addObject:@{@"url":[NSString stringWithFormat:@"%@",resposeObject[@"data"]],@"name":name,@"create_time":name}];
           self->_addNumeralFileView.dataArr = self->_imgArr;
       }else{

           [self showContent:resposeObject[@"msg"]];
       }

    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
    }];
}

- (void)initUI{
    
    self.titleLabel.text = @"新增签租";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    SS(strongSelf);
    
#pragma mark -- 房源信息 --
    _roomHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _roomHeader.backgroundColor = CLWhiteColor;
    _roomHeader.titleL.text = @"房源信息";
    _roomHeader.addBtn.hidden = YES;
    [_roomHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    _roomHeader.addNemeralHeaderAllBlock = ^{
      
        if ([strongSelf->_selectArr[0] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@0];
            [strongSelf->_roomHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreRoomView.hidden = YES;
            [strongSelf->_addIntentStoreRoomView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_roomHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@1];
            [strongSelf->_roomHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreRoomView.hidden = NO;
            [strongSelf->_addIntentStoreRoomView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_roomHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_roomHeader];
    
    _addIntentStoreRoomView = [[AddIntentStoreRoomView alloc] init];
    _addIntentStoreRoomView.dataArr = self->_roomArr;
    _addIntentStoreRoomView.addIntentStoreRoomViewAddBlock = ^{
        
    };
    _addIntentStoreRoomView.addIntentStoreRoomViewDeleteBlock = ^(NSInteger idx) {
        
        [strongSelf->_roomArr removeObjectAtIndex:idx];
        strongSelf->_addIntentStoreRoomView.dataArr = strongSelf->_roomArr;
    };
    [_scrollView addSubview:_addIntentStoreRoomView];
    
#pragma mark -- 面积信息 --
    
    _areaHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _areaHeader.backgroundColor = CLWhiteColor;
    _areaHeader.titleL.text = @"面积信息";
    _areaHeader.addBtn.hidden = YES;
    [_areaHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _areaHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[1] integerValue]){
        
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@0];
            [strongSelf->_areaHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_areaView.hidden = YES;
            [strongSelf->_areaView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_areaHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@1];
            [strongSelf->_areaHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_areaView.hidden = NO;
            [strongSelf->_areaView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_areaHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_areaHeader];
    
    _areaView = [[AddSignRentAreaView alloc] init];
    _areaView.hidden = YES;
    [_scrollView addSubview:_areaView];
    
#pragma mark -- 商家信息 --
    
    _storeHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _storeHeader.backgroundColor = CLWhiteColor;
    _storeHeader.titleL.text = @"商家信息";
    _storeHeader.addBtn.hidden = YES;
    [_storeHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _storeHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[2] integerValue]){
        
            [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@0];
            [strongSelf->_storeHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreInfoView.hidden = YES;
            [strongSelf->_addIntentStoreInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_storeHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@1];
            [strongSelf->_storeHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addIntentStoreInfoView.hidden = NO;
            [strongSelf->_addIntentStoreInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_storeHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_storeHeader];
    
    _addIntentStoreInfoView = [[AddIntentStoreInfoView alloc] init];
    _addIntentStoreInfoView.dataArr = self->_roomArr;
    _addIntentStoreInfoView.hidden = YES;
    _addIntentStoreInfoView.addIntentStoreInfoViewAddBlock = ^{
        
        AddStoreVC *nextVC = [[AddStoreVC alloc] initWithProjectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.status = @"direct";
        nextVC.addStoreVCDicBlock = ^(NSDictionary * _Nonnull dic) {
          
            
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    _addIntentStoreInfoView.addIntentStoreInfoViewDeleteBlock = ^(NSInteger idx) {
        
        [strongSelf->_roomArr removeObjectAtIndex:idx];
        strongSelf->_addIntentStoreRoomView.dataArr = strongSelf->_roomArr;
    };
    _addIntentStoreInfoView.addIntentStoreInfoViewSelectBlock = ^{
        
        AddIntentSelectStoreVC *nextVC = [[AddIntentSelectStoreVC alloc] initWithProjectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        nextVC.addIntentSelectStoreVCBlock = ^(NSDictionary * _Nonnull dic) {
            
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_scrollView addSubview:_addIntentStoreInfoView];
    
#pragma mark -- 签租信息 --
    
    _signHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _signHeader.titleL.text = @"签租信息";
    _signHeader.addBtn.hidden = YES;
    [_signHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _signHeader.backgroundColor = CLWhiteColor;
    _signHeader.addNemeralHeaderAllBlock = ^{
            
        if ([strongSelf->_selectArr[3] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@0];
            [strongSelf->_signHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_signView.hidden = YES;
            [strongSelf->_signView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_signHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
                
            [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@1];
            [strongSelf->_signHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_signView.hidden = NO;
            [strongSelf->_signView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_signHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_signHeader];
    
    _signView = [[AddOrderRentInfoView alloc] init];
    _signView.hidden = YES;
    [_scrollView addSubview:_signView];
    
#pragma mark -- 租金信息 --
    
    _priceHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _priceHeader.titleL.text = @"租金信息";
    _priceHeader.addBtn.hidden = YES;
    [_priceHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _priceHeader.backgroundColor = CLWhiteColor;
    _priceHeader.addNemeralHeaderAllBlock = ^{
            
        if ([strongSelf->_selectArr[4] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:4 withObject:@0];
            [strongSelf->_priceHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_priceView.hidden = YES;
            [strongSelf->_priceView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_priceHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
                
            [strongSelf->_selectArr replaceObjectAtIndex:4 withObject:@1];
            [strongSelf->_priceHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_priceView.hidden = NO;
            [strongSelf->_priceView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_priceHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_priceHeader];
    
    _priceView = [[AddOrderRentPriceView alloc] init];
    _priceView.hidden = NO;
    [_scrollView addSubview:_priceView];
    
#pragma mark -- 物业费信息 --
    _propertyHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _propertyHeader.titleL.text = @"物业费信息";
    _propertyHeader.addBtn.hidden = YES;
    [_propertyHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _propertyHeader.backgroundColor = CLWhiteColor;
    _propertyHeader.addNemeralHeaderAllBlock = ^{
            
        if ([strongSelf->_selectArr[5] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:5 withObject:@0];
            [strongSelf->_propertyHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_propertyView.hidden = YES;
            [strongSelf->_propertyView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_propertyHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
                
            [strongSelf->_selectArr replaceObjectAtIndex:5 withObject:@1];
            [strongSelf->_propertyHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_propertyView.hidden = NO;
            [strongSelf->_propertyView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_propertyHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_propertyHeader];
    
    _propertyView = [[AddOrderRentPriceView alloc] init];
    _propertyView.hidden = NO;
    [_scrollView addSubview:_propertyView];
    
#pragma mark -- 流程信息 --
    
    _processHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _processHeader.titleL.text = @"流程信息";
    _processHeader.addBtn.hidden = YES;
    [_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _processHeader.backgroundColor = CLWhiteColor;
    _processHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[6] integerValue]){
        
            [strongSelf->_selectArr replaceObjectAtIndex:6 withObject:@0];
            [strongSelf->_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralProcessView.hidden = YES;
            [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
//                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:6 withObject:@1];
            [strongSelf->_processHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralProcessView.hidden = NO;
            [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
//                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_processHeader];
    
    _addNumeralProcessView = [[AddNumeralProcessView alloc] init];
    _addNumeralProcessView.hidden = YES;
    _addNumeralProcessView.dataDic = _progressDic;
    _addNumeralProcessView.addNumeralProcessViewAuditBlock = ^{
    
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:@[@{@"param":@"自由流程",@"id":@"1"},@{@"param":@"固定流程",@"id":@"2"}]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"auditMC"];
            [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"auditID"];
            strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
        };
        [strongSelf.view addSubview:view];
    };
    _addNumeralProcessView.addNumeralProcessViewTypeBlock = ^{
        
        if (strongSelf->_progressArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_progressArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                if ([MC containsString:@"自由"]) {
                    
                    [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                }else if ([MC containsString:@"固定"]){
                    
                    [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                }else{
                    
                    [strongSelf->_progressDic removeObjectForKey:@"auditMC"];
                    [strongSelf->_progressDic removeObjectForKey:@"auditID"];
                }
                if (![MC isEqualToString:strongSelf->_progressDic[@"progress_name"]]) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    [strongSelf->_rolePersonSelectArr removeAllObjects];
                    strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                    strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                    [strongSelf->_progressDic removeObjectForKey:@"role_name"];
                    [strongSelf->_progressDic removeObjectForKey:@"role_id"];
                }
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                for (int i = 0; i < strongSelf->_progressAllArr.count; i++) {
                    
                    if ([ID integerValue] == [strongSelf->_progressAllArr[i][@"progress_id"] integerValue]) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",strongSelf->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                    }
                }
                if ([strongSelf->_progressDic[@"check_type"] integerValue] == 1) {
                    
                    [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                }else if ([strongSelf->_progressDic[@"check_type"] integerValue] == 2) {
                    
                    [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                    [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                }
                strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
            };
            [strongSelf.view addSubview:view];
        }else{
            
            [BaseRequest GET:ProjectProgressGet_URL parameters:@{@"project_id":strongSelf->_project_id,@"config_type":@"1",@"progress_defined_id":@"1"} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    [strongSelf->_progressArr removeAllObjects];
                    [strongSelf->_progressAllArr removeAllObjects];
                    strongSelf->_progressAllArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                    for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                        
                        [strongSelf->_progressArr addObject:@{@"param":[NSString stringWithFormat:@"%@",resposeObject[@"data"][i][@"progress_name"]],@"id":resposeObject[@"data"][i][@"progress_id"]}];
                    }
                    
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_progressArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        if ([MC containsString:@"自由"]) {
                            
                            [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                        }else if ([MC containsString:@"固定"]){
                            
                            [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                        }else{
                            
                            [strongSelf->_progressDic removeObjectForKey:@"auditMC"];
                            [strongSelf->_progressDic removeObjectForKey:@"auditID"];
                        }
                        if (![MC isEqualToString:strongSelf->_progressDic[@"progress_name"]]) {
                            
                            [strongSelf->_rolePersonArr removeAllObjects];
                            [strongSelf->_rolePersonSelectArr removeAllObjects];
                            strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                            strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                            [strongSelf->_progressDic removeObjectForKey:@"role_name"];
                            [strongSelf->_progressDic removeObjectForKey:@"role_id"];
                        }
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"progress_name"];
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"progress_id"];
                        for (int i = 0; i < strongSelf->_progressAllArr.count; i++) {
                            
                            if ([ID integerValue] == [strongSelf->_progressAllArr[i][@"progress_id"] integerValue]) {
                                
                                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",strongSelf->_progressAllArr[i][@"check_type"]] forKey:@"check_type"];
                            }
                        }
                        if ([strongSelf->_progressDic[@"check_type"] integerValue] == 1) {
                            
                            [strongSelf->_progressDic setObject:@"自由流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"1" forKey:@"auditID"];
                        }else if ([strongSelf->_progressDic[@"check_type"] integerValue] == 2) {
                            
                            [strongSelf->_progressDic setObject:@"固定流程" forKey:@"auditMC"];
                            [strongSelf->_progressDic setObject:@"2" forKey:@"auditID"];
                        }
                        strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                
            }];
        }
    };
    
    _addNumeralProcessView.addNumeralProcessViewRoleBlock = ^{
      
        if (strongSelf->_roleArr.count) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_roleArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                if (![MC isEqualToString:strongSelf->_progressDic[@"role_name"]]) {
                    
                    [strongSelf->_rolePersonArr removeAllObjects];
                    [strongSelf->_rolePersonSelectArr removeAllObjects];
                    strongSelf->_addNumeralProcessView.personArr = strongSelf->_rolePersonArr;
                    strongSelf->_addNumeralProcessView.personSelectArr = strongSelf->_rolePersonSelectArr;
                }
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
                [strongSelf RequestMethod];
            };
            [strongSelf.view addSubview:view];
        }else{
            
            [BaseRequest GET:ProjectRoleListAll_URL parameters:@{@"project_id":strongSelf->_project_id} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    for (NSDictionary *dic in resposeObject[@"data"]) {
                        
                        [strongSelf->_roleArr addObject:@{@"param":[NSString stringWithFormat:@"%@/%@",dic[@"project_name"],dic[@"role_name"]],@"id":dic[@"role_id"]}];
                    }
                    SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:strongSelf->_roleArr];
                    view.selectedBlock = ^(NSString *MC, NSString *ID) {
                        
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"role_name"];
                        [strongSelf->_progressDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"role_id"];
                        strongSelf->_addNumeralProcessView.dataDic = strongSelf->_progressDic;
                        [strongSelf RequestMethod];
                    };
                    [strongSelf.view addSubview:view];
                }else{
                    
                    
                }
            } failure:^(NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
            }];
        }
    };
    
    _addNumeralProcessView.addNumeralProcessViewSelectBlock = ^(NSArray * _Nonnull arr) {
      
//        strongSelf->_coll.hidden = YES;
        strongSelf->_rolePersonSelectArr = [NSMutableArray arrayWithArray:arr];
    };
    [_scrollView addSubview:_addNumeralProcessView];
    
    
#pragma mark -- 附件信息 --
    _addNumeralFileHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _addNumeralFileHeader.titleL.text = @"附件文件";
    _addNumeralFileHeader.addBtn.hidden = YES;
    [_addNumeralFileHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _addNumeralFileHeader.backgroundColor = CLWhiteColor;
    _addNumeralFileHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[7] integerValue]){

            [strongSelf->_selectArr replaceObjectAtIndex:7 withObject:@0];
            [strongSelf->_addNumeralFileHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralFileView.hidden = YES;
            [strongSelf->_addNumeralFileView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralFileHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(0);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }else{

            [strongSelf->_selectArr replaceObjectAtIndex:7 withObject:@1];
            [strongSelf->_addNumeralFileHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralFileView.hidden = NO;
            [strongSelf->_addNumeralFileView mas_remakeConstraints:^(MASConstraintMaker *make) {

                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralFileHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_addNumeralFileHeader];

    _addNumeralFileView = [[AddNumeralFileView alloc] init];
    _addNumeralFileView.hidden = YES;
    _addNumeralFileView.addNumeralFileViewAddBlock = ^{

        [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {

            if (image) {

                [strongSelf updateheadimgbyimg:image];
            }
        }];
    };
    _addNumeralFileView.addNumeralFileViewDeleteBlock = ^(NSInteger idx) {

        [strongSelf->_imgArr removeObjectAtIndex:idx];
        strongSelf->_addNumeralFileView.dataArr = strongSelf->_imgArr;
    };
    _addNumeralFileView.addNumeralFileViewSelectBlock = ^(NSInteger idx) {
      
        ChangeFileNameView *view = [[ChangeFileNameView alloc] initWithFrame:strongSelf.view.bounds name:strongSelf->_imgArr[idx][@"name"]];
        view.changeFileNameViewBlock = ^(NSString * _Nonnull name) {
          
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:strongSelf->_imgArr[idx]];
            [tempDic setValue:name forKey:@"name"];
            [strongSelf->_imgArr replaceObjectAtIndex:idx withObject:tempDic];
            strongSelf->_addNumeralFileView.dataArr = strongSelf->_imgArr;
        };
        [strongSelf.view addSubview:view];
    };
    [_scrollView addSubview:_addNumeralFileView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    [_roomHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_addIntentStoreRoomView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_roomHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_areaHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addIntentStoreRoomView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
        
    [_areaView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_areaHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_storeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_areaView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
        
    [_addIntentStoreInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_storeHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_signHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addIntentStoreInfoView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
        
    [_signView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_signHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_priceHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_signView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
        
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_priceHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_propertyHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_priceView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
        
    [_propertyView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_propertyHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];

    [_processHeader mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_propertyView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
//        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
    
    [_addNumeralProcessView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_processHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
//        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
    
    [_addNumeralFileHeader mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addNumeralProcessView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];

    [_addNumeralFileView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addNumeralFileHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
}

@end
