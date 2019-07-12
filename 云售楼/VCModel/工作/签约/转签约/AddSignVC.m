//
//  AddSignVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/7/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddSignVC.h"

#import "RoomVC.h"
#import "SelectSpePerferVC.h"

#import "AddNemeralHeader.h"

#import "AddNumeralPersonView.h"
#import "AddOrderRoomView.h"
#import "AddOrderView.h"
#import "AddNumeralProcessView.h"

#import "SinglePickView.h"

@interface AddSignVC ()<UIScrollViewDelegate>
{
    
    NSInteger _num;
    
    NSString *_project_id;
    NSString *_info_id;
    NSString *_group_id;
    
    NSArray *_titleArr;
    
    NSMutableDictionary *_roomDic;
    NSMutableDictionary *_ordDic;
    
    NSMutableArray *_certArr;
    NSMutableArray *_personArr;
    NSMutableArray *_proportionArr;
    NSMutableArray *_selectArr;
    NSMutableArray *_typeArr;
    NSMutableArray *_disCountArr;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) AddNemeralHeader *personHeader;

@property (nonatomic, strong) AddNumeralPersonView *addNumeralPersonView;

@property (nonatomic, strong) AddNemeralHeader *roomHeader;

@property (nonatomic, strong) AddOrderRoomView *addOrderRoomView;

@property (nonatomic, strong) AddNemeralHeader *orderHeader;

@property (nonatomic, strong) AddOrderView *addOrderView;

@property (nonatomic, strong) AddNemeralHeader *processHeader;

@property (nonatomic, strong) AddNumeralProcessView *addNumeralProcessView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation AddSignVC

- (instancetype)initWithRow_id:(NSString *)row_id personArr:(NSArray *)personArr
{
    self = [super init];
    if (self) {
        
        //        _project_id = project_id;
        _personArr = [[NSMutableArray alloc] initWithArray:personArr];
        for (int i = 0; i < _personArr.count; i++) {
            
            [_proportionArr addObject:@""];
        }
        //        _info_id = info_id;
        _roomDic = [@{} mutableCopy];
        _ordDic = [@{} mutableCopy];
        //        _group_id = group_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    //    [self PropertyRequestMethod];
}

- (void)initDataSource{
    
    _num = 0;
    _titleArr = @[@"权益人信息",@"房源信息",@"定单信息"];
    _certArr = [@[] mutableCopy];
    _selectArr = [[NSMutableArray alloc] initWithArray:@[@1,@0,@0,@0]];
    _disCountArr = [@[] mutableCopy];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][2] count]; i++) {
                
                NSDictionary *dic = @{@"id":resposeObject[@"data"][2][i][@"config_id"],
                                      @"param":resposeObject[@"data"][2][i][@"config_name"]};
                [self->_certArr addObject:dic];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
    
    [BaseRequest GET:ProjectRowGetRowList_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            self->_typeArr = [[NSMutableArray alloc] initWithArray:resposeObject[@"data"]];
            //            [self->_table reloadData];
        }else{
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    BOOL isFull = YES;
    for (NSString *str in _proportionArr) {
        
        if (!str.length) {
            
            isFull = NO;
            [self showContent:@"请填写权益人比例"];
            break;
        }
    }
    if (!isFull) {
        
        return;
    }
    
    NSDictionary *dic = @{@"project_id":_project_id};
    
    [BaseRequest POST:ProjectRowAddRow_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)initUI{
    
    self.titleLabel.text = @"转签约";
    
    _scrollView = [[UIScrollView alloc] init];//WithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE)];
    _scrollView.backgroundColor = CLBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    SS(strongSelf);
    _personHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _personHeader.backgroundColor = CLWhiteColor;
    _personHeader.titleL.text = @"权益人信息";
    _personHeader.addBtn.hidden = YES;
    [_personHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
    _personHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[0] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@0];
            [strongSelf->_personHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addNumeralPersonView.hidden = YES;
            [strongSelf->_roomHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_personHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:0 withObject:@1];
            [strongSelf->_personHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addNumeralPersonView.hidden = NO;
            [strongSelf->_roomHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addNumeralPersonView.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_personHeader];
    
    _addNumeralPersonView = [[AddNumeralPersonView alloc] init];
    _addNumeralPersonView.dataArr = _personArr;
    _addNumeralPersonView.num = _num;
    
    _addNumeralPersonView.addNumeralPersonViewCollBlock = ^(NSInteger num) {
        
        self->_num = num;
    };
    _addNumeralPersonView.addNumeralPersonViewAddBlock = ^(NSInteger num) {
        
        //        AddCallTelegramGroupMemberVC *nextVC = [[AddCallTelegramGroupMemberVC alloc] initWithProjectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        //        nextVC.group_id = [NSString stringWithFormat:@"%@",strongSelf->_group_id];
        //        nextVC.addCallTelegramGroupMemberVCBlock = ^(NSString * _Nonnull group, NSDictionary * _Nonnull dic) {
        //
        //            [strongSelf->_personArr addObject:dic];
        //            strongSelf->_addNumeralPersonView.dataArr = strongSelf->_personArr;
        //            strongSelf->_addNumeralPersonView.num = strongSelf->_personArr.count;
        //        };
        //        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    _addNumeralPersonView.addNumeralPersonViewEditBlock = ^(NSInteger num) {
        
        //        CallTelegramSimpleCustomVC *nextVC = [[CallTelegramSimpleCustomVC alloc] initWithDataDic:strongSelf->_personArr[strongSelf->_num] projectId:strongSelf->_project_id info_id:strongSelf->_info_id];
        //        nextVC.callTelegramSimpleCustomVCEditBlock = ^(NSDictionary * _Nonnull dic) {
        //
        //            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:strongSelf->_personArr[strongSelf->_num]];
        //            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //
        //                if (dic[key]) {
        //
        //                    [tempDic setObject:dic[key] forKey:key];
        //                }
        //            }];
        //            [strongSelf->_personArr replaceObjectAtIndex:strongSelf->_num withObject:tempDic];
        //        };
        //        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_scrollView addSubview:_addNumeralPersonView];
    
    _roomHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _roomHeader.titleL.text = @"房源信息";
    _roomHeader.addBtn.hidden = YES;
    [_roomHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _roomHeader.backgroundColor = CLWhiteColor;
    _roomHeader.addNemeralHeaderAllBlock = ^{
        
        if ([strongSelf->_selectArr[1] integerValue]){
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@0];
            [strongSelf->_roomHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
            strongSelf->_addOrderRoomView.hidden = YES;
            [strongSelf->_orderHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_roomHeader.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                //                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }else{
            
            [strongSelf->_selectArr replaceObjectAtIndex:1 withObject:@1];
            [strongSelf->_roomHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
            strongSelf->_addOrderRoomView.hidden = NO;
            [strongSelf->_orderHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(strongSelf->_scrollView).offset(0);
                make.top.equalTo(strongSelf->_addOrderRoomView.mas_bottom).offset(0 *SIZE);
                make.width.mas_equalTo(SCREEN_Width);
                make.height.mas_equalTo(40 *SIZE);
                make.right.equalTo(strongSelf->_scrollView).offset(0);
                //                make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
            }];
        }
    };
    [_scrollView addSubview:_roomHeader];
    
    _addOrderRoomView = [[AddOrderRoomView alloc] init];
    _addOrderRoomView.hidden = YES;
    _addOrderRoomView.dataDic = _roomDic;
    _addOrderRoomView.addOrderRoomViewEditBlock = ^{
        
        RoomVC *nextVC = [[RoomVC alloc] init];
        nextVC.status = @"select";
        nextVC.roomVCBlock = ^(NSDictionary * dic) {
            
            strongSelf->_roomDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            strongSelf->_addOrderRoomView.dataDic = strongSelf->_roomDic;
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",dic[@"total_price"]] forKey:@"total_price"];
            strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
        };
        [strongSelf.navigationController pushViewController:nextVC animated:YES];
    };
    [_scrollView addSubview:_addOrderRoomView];
    
    _orderHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _orderHeader.titleL.text = @"定单信息";
    _orderHeader.addBtn.hidden = YES;
    [_orderHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _orderHeader.backgroundColor = CLWhiteColor;
    _orderHeader.addNemeralHeaderAllBlock = ^{
        
        if (strongSelf->_roomDic.count) {
            
            if ([strongSelf->_selectArr[2] integerValue]){
                
                [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@0];
                [strongSelf->_orderHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
                strongSelf->_addOrderView.hidden = YES;
                
                if (!strongSelf->_addNumeralProcessView.hidden) {
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        //                    make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }else{
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }
            }else{
                
                [strongSelf->_selectArr replaceObjectAtIndex:2 withObject:@1];
                [strongSelf->_orderHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
                strongSelf->_addOrderView.hidden = NO;
                if (!strongSelf->_addNumeralProcessView.hidden) {
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        //                    make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }else{
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }
            }
        }else{
            
            [strongSelf showContent:@"请先选择房源"];
        }
    };
    [_scrollView addSubview:_orderHeader];
    
    
    _addOrderView = [[AddOrderView alloc] init];
    _addOrderView.hidden = YES;
    _addOrderView.dataArr = _disCountArr;
    _addOrderView.dataDic = _ordDic;
    _addOrderView.addOrderViewAddBlock = ^{
        
        if (strongSelf->_roomDic.count) {
            
            SelectSpePerferVC *nextVC = [[SelectSpePerferVC alloc] init];
            nextVC.dic = strongSelf->_roomDic;
            nextVC.selectSpePerferVCBlock = ^(NSDictionary * _Nonnull dic) {
                
                [strongSelf->_disCountArr addObject:dic];
                strongSelf->_addOrderView.dataArr = strongSelf->_disCountArr;
            };
            [strongSelf.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [strongSelf showContent:@"请选择房源"];
        }
    };
    
    _addOrderView.addOrderViewStrBlock = ^(NSString * _Nonnull str, NSInteger index) {
        
        if (index == 0) {
            
            [strongSelf->_ordDic setObject:str forKey:@"sub_code"];
        }else if (index == 1){
            
            [strongSelf->_ordDic setObject:str forKey:@"down_pay"];
        }else if (index == 3){
            
            [strongSelf->_ordDic setObject:str forKey:@"down_pay"];
        }else if (index == 7){
            
            [strongSelf->_ordDic setObject:str forKey:@"down_pay"];
        }
    };
    
    _addOrderView.addOrderViewDropBlock = ^(NSInteger index) {
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:strongSelf.view.bounds WithData:[strongSelf getDetailConfigArrByConfigState:PAY_WAY]];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",MC] forKey:@"payWay_Name"];
            [strongSelf->_ordDic setObject:[NSString stringWithFormat:@"%@",ID] forKey:@"payWay_id"];
            strongSelf->_addOrderView.dataDic = strongSelf->_ordDic;
        };
        [strongSelf.view addSubview:view];
    };
    
    _addOrderView.addOrderViewDeleteBlock = ^(NSInteger index) {
        
        [strongSelf->_disCountArr removeObjectAtIndex:index];
    };
    
    [_scrollView addSubview:_addOrderView];
    
    _processHeader = [[AddNemeralHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _processHeader.titleL.text = @"流程信息";
    _processHeader.addBtn.hidden = YES;
    [_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
    _processHeader.backgroundColor = CLWhiteColor;
    _processHeader.addNemeralHeaderAllBlock = ^{
        
        if (strongSelf->_roomDic.count) {
            
            if ([strongSelf->_selectArr[3] integerValue]){
                
                [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@0];
                [strongSelf->_processHeader.moreBtn setTitle:@"展开" forState:UIControlStateNormal];
                strongSelf->_addNumeralProcessView.hidden = YES;
                if (strongSelf->_addOrderView.hidden) {
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }else{
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                        make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                    }];
                }
                
                
                [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(strongSelf->_scrollView).offset(0);
                    make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
                    make.width.mas_equalTo(SCREEN_Width);
                    make.height.mas_equalTo(0);
                    make.right.equalTo(strongSelf->_scrollView).offset(0);
                    make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                }];
                
            }else{
                
                [strongSelf->_selectArr replaceObjectAtIndex:3 withObject:@1];
                [strongSelf->_processHeader.moreBtn setTitle:@"关闭" forState:UIControlStateNormal];
                strongSelf->_addNumeralProcessView.hidden = NO;
                
                if (strongSelf->_addOrderView.hidden) {
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_orderHeader.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                    }];
                }else{
                    
                    [strongSelf->_processHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(strongSelf->_scrollView).offset(0);
                        make.top.equalTo(strongSelf->_addOrderView.mas_bottom).offset(0 *SIZE);
                        make.width.mas_equalTo(SCREEN_Width);
                        make.height.mas_equalTo(40 *SIZE);
                        make.right.equalTo(strongSelf->_scrollView).offset(0);
                    }];
                }
                
                
                [strongSelf->_addNumeralProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(strongSelf->_scrollView).offset(0);
                    make.top.equalTo(strongSelf->_processHeader.mas_bottom).offset(0 *SIZE);
                    make.width.mas_equalTo(SCREEN_Width);
                    make.height.mas_equalTo(0);
                    make.right.equalTo(strongSelf->_scrollView).offset(0);
                    make.bottom.equalTo(strongSelf->_scrollView.mas_bottom).offset(0);
                }];
                
            }
        }else{
            
            [strongSelf showContent:@"请先选择房源"];
        }
    };
    [_scrollView addSubview:_processHeader];
    
    _addNumeralProcessView = [[AddNumeralProcessView alloc] init];
    _addNumeralProcessView.hidden = YES;
    [_scrollView addSubview:_addNumeralProcessView];
    
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
    
    [_personHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        //        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addNumeralPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(40 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_roomHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_addNumeralPersonView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addOrderRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_roomHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_orderHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_roomHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_addOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_orderHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.right.equalTo(self->_scrollView).offset(0);
    }];
    
    [_processHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_orderHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
        make.right.equalTo(self->_scrollView).offset(0);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
    
    [_addNumeralProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_processHeader.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(0);
        make.right.equalTo(self->_scrollView).offset(0);
        //        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(0);
    }];
}

@end
