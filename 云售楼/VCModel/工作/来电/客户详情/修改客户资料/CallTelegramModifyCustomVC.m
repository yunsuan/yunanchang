//
//  CallTelegramModifyCustomVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/5.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CallTelegramModifyCustomVC.h"

#import "BoxSelectCollCell.h"
#import "BaseHeader.h"

#import "SinglePickView.h"
//#import "AddressChooseView3.h"
#import "AdressChooseView.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface CallTelegramModifyCustomVC ()<UITextFieldDelegate>
{
    
    NSString *_project_id;
    NSString *_info_id;
    NSString *_proId;
    NSString *_cityId;
    NSString *_areaId;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_approachArr;
    NSMutableArray *_approachArr2;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *customSourceL;

@property (nonatomic, strong) DropBtn *customSourceBtn;

@property (nonatomic, strong) UILabel *approachL;

@property (nonatomic, strong) DropBtn *approachBtn;

@property (nonatomic, strong) DropBtn *approachBtn2;

@property (nonatomic, strong) UILabel *sourceTypeL;

@property (nonatomic, strong) DropBtn *sourceTypeBtn;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation CallTelegramModifyCustomVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic projectId:(NSString *)projectId info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _dataDic = [[NSMutableDictionary alloc] initWithDictionary:dataDic];
        [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [self->_dataDic setObject:@"" forKey:key];
            }else{
                
                [self->_dataDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        _project_id = projectId;
        _info_id = info_id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self PropertyRequestMethod];
}

- (void)initDataSource{
    
    _approachArr = [@[] mutableCopy];
    _approachArr2 = [@[] mutableCopy];
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][0] count]; i++) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"id":resposeObject[@"data"][0][i][@"config_id"],
                                                                                             @"param":resposeObject[@"data"][0][i][@"config_name"]
                                                                                             }];
                if (resposeObject[@"data"][0][i][@"child"]) {
                    
                    [dic setObject:resposeObject[@"data"][0][i][@"child"] forKey:@"child"];
                }
                [self->_approachArr addObject:dic];
                for (int i = 0; i < self->_approachArr.count; i++) {
                    
                    if ([self->_dataDic[@"listen_way_detail"] length]) {
                        
                        
                    }else if ([self->_dataDic[@"listen_way"] length]){
                        
                        if ([self->_dataDic[@"listen_way"] isEqualToString:self->_approachArr[i][@"param"]]) {
                            
                            self->_approachBtn->str = self->_approachArr[i][@"id"];
                        }
                    }
                }
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
//        AddressChooseView3 *addressChooseView = [[AddressChooseView3 alloc] initWithFrame:self.view.frame withdata:@[]];
//        WS(weakself);
//        addressChooseView.addressChooseView3ConfirmBlock = ^(NSString *city, NSString *area, NSString *cityid, NSString *areaid) {
        AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.bounds withdata:@[]];
        WS(weakself);
        addressChooseView.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {
        
            NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
            
            NSError *err;
            NSArray *proArr = [NSJSONSerialization JSONObjectWithData:JSONData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
            NSString *pro = [cityid substringToIndex:2];
            pro = [NSString stringWithFormat:@"%@0000",pro];
            NSString *proName;
            if ([pro isEqualToString:@"900000"]) {
                proName = @"海外";
            }
            else{
                for (NSDictionary *dic in proArr) {
                    
                    if([dic[@"code"] isEqualToString:pro]){
                        
                        proName = dic[@"name"];
                        break;
                    }
                }
            }
            self->_customSourceBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",proName,city,area];
            self->_customSourceBtn.placeL.text = @"";
            self->_proId = pro;
            self->_cityId = cityid;
            self->_areaId = areaid;
        };
        [self.view addSubview:addressChooseView];
    }else{
        
        if (btn.tag == 1) {
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:_approachArr];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_approachBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                self->_approachBtn->str = [NSString stringWithFormat:@"%@",ID];
                self->_approachBtn.placeL.text = @"";
                [self->_approachArr2 removeAllObjects];
                for (int j = 0; j < self->_approachArr.count; j++) {
                    
                    if ([ID integerValue] == [self->_approachArr[j][@"id"] integerValue]) {
                        
                        NSArray *arr = self->_approachArr[j][@"child"];
                        for (NSDictionary *dic in arr) {
                            
                            [self->_approachArr2 addObject:@{@"id":dic[@"config_id"],@"param":dic[@"config_name"]}];
                        }
                    }
                }
                if (self->_approachArr2.count) {
                    
                    self->_approachBtn2.hidden = NO;
                    [self->_sourceTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                        make.top.equalTo(self->_approachBtn2.mas_bottom).offset(31 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [self->_sourceTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                        make.top.equalTo(self->_approachBtn2.mas_bottom).offset(21 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }else{
                    
                    self->_approachBtn2.hidden = YES;
                    self->_approachBtn2.placeL.text = @"请选择认知途径";
                    self->_approachBtn2.content.text = @"";
                    self->_approachBtn2->str = @"";
                    [self->_sourceTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                        make.top.equalTo(self->_approachBtn.mas_bottom).offset(31 *SIZE);
                        make.width.mas_equalTo(70 *SIZE);
                    }];
                    
                    [self->_sourceTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
                        make.width.mas_equalTo(258 *SIZE);
                        make.height.mas_equalTo(33 *SIZE);
                    }];
                }
            };
            [self.view addSubview:view];
        }else{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:_approachArr2];
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                self->_approachBtn2.content.text = [NSString stringWithFormat:@"%@",MC];
                self->_approachBtn2->str = [NSString stringWithFormat:@"%@",ID];
                self->_approachBtn2.placeL.text = @"";
            };
            [self.view addSubview:view];
        }
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    
    if (![self.status isEqualToString:@"分配"]) {
       
        if (!_approachBtn.content.text.length) {
            
            [self alertControllerWithNsstring:@"必填信息" And:@"请选择认知途径"];
            return;
        }
    }
    
    if (_customSourceBtn.content.text.length) {
        
        [tempDic setObject:_proId forKey:@"province"];
        [tempDic setObject:_cityId forKey:@"city"];
        [tempDic setObject:_areaId forKey:@"district"];
    }
    
    [tempDic setObject:_dataDic[@"group_id"] forKey:@"group_id"];
    
    if (![self.status isEqualToString:@"分配"]) {
     
        if (!_approachBtn.content.text.length) {
            
            [tempDic setObject:_approachBtn->str forKey:@"listen_way"];
        }
    }
    
//    [tempDic setObject:@"1" forKey:@"source"];
    
    [BaseRequest POST:WorkClientAutoGroupUpdate_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.callTelegramModifyCustomVCBlock) {
                
                self.callTelegramModifyCustomVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)initUI{
    
    self.titleLabel.text = @"修改组信息";
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    BaseHeader *header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    header.titleL.text = @"组信息";
    [_scrollView addSubview:header];
    

    NSArray *titleArr = @[@"客户来源：",@"认知途径：",@"来源类型："];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
            case 0:
            {
                _customSourceL = label;
                [_scrollView addSubview:_customSourceL];
                break;
            }
            case 1:
            {
                _approachL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_approachL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _approachL.attributedText = attr;
                [_scrollView addSubview:_approachL];
                break;
            }
            case 2:
            {
                _sourceTypeL = label;
                [_scrollView addSubview:_sourceTypeL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < 4; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.placeL.text = @"请选择证件类型";
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                
                _customSourceBtn = btn;
                if ([_dataDic[@"province_name"] length]) {
                    
                    _customSourceBtn.content.text = [NSString stringWithFormat:@"%@%@%@",_dataDic[@"province_name"],_dataDic[@"city_name"],_dataDic[@"district_name"]];
                    _customSourceBtn.placeL.text = @"";
                }
                [_scrollView addSubview:_customSourceBtn];
                break;
            }
            case 1:
            {
                
                _approachBtn = btn;
                if ([_dataDic[@"listen_way"] length]){
                    
                    _approachBtn.content.text = _dataDic[@"listen_way"];
                    _approachBtn.placeL.text = @"";
                }
                [_scrollView addSubview:_approachBtn];
                if ([self.status isEqualToString:@"分配"]) {
                    
                    _approachBtn.userInteractionEnabled = NO;
                    _approachBtn.backgroundColor = CLLineColor;
                }
                break;
            }
            case 2:
            {
                
                _approachBtn2 = btn;
                if ([[NSString stringWithFormat:@"%@",_dataDic[@"listen_way_detail"]] length]) {
                    
                    _approachBtn2.content.text = [NSString stringWithFormat:@"%@",_dataDic[@"listen_way_detail"]];
                    _approachBtn2.placeL.text = @"";
                }else{
                    
                    _approachBtn2.hidden = YES;
                }
                if ([self.status isEqualToString:@"分配"]) {
                    
                    _approachBtn2.userInteractionEnabled = NO;
                    _approachBtn2.backgroundColor = CLLineColor;
                }
                [_scrollView addSubview:_approachBtn2];
                break;
            }
            case 3:
            {
                
                _sourceTypeBtn = btn;
                _sourceTypeBtn.dropimg.hidden = YES;
                _sourceTypeBtn.content.text = _dataDic[@"source"];
                _sourceTypeBtn.placeL.text = @"";
//                if ([self.status isEqualToString:@"分配"]) {
                
                    _sourceTypeBtn.userInteractionEnabled = NO;
                    _sourceTypeBtn.backgroundColor = CLLineColor;
//                }
                [_scrollView addSubview:_sourceTypeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 43 *SIZE - TAB_BAR_MORE, SCREEN_Width, 43 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:CLBlueTagColor];
    //    _nextBtn.layer.cornerRadius = 5 *SIZE;
    //    _nextBtn.clipsToBounds = YES;
    [self.view addSubview:_nextBtn];
    
    [self MasonryUI];
    
    if ([[NSString stringWithFormat:@"%@",_dataDic[@"listen_way_detail"]] integerValue] != 0) {
        
        if ([[NSString stringWithFormat:@"%@",_dataDic[@"listen_way_detail"]] length]) {
            
            [_sourceTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_scrollView).offset(9 *SIZE);
                make.top.equalTo(self->_approachBtn2.mas_bottom).offset(31 *SIZE);
                make.width.mas_equalTo(70 *SIZE);
            }];
            
            [_sourceTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_scrollView).offset(80 *SIZE);
                make.top.equalTo(self->_approachBtn2.mas_bottom).offset(21 *SIZE);
                make.width.mas_equalTo(258 *SIZE);
                make.height.mas_equalTo(33 *SIZE);
                make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
            }];
        }
    }
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SCREEN_Height - NAVIGATION_BAR_HEIGHT - 43 *SIZE - TAB_BAR_MORE);
    }];
    
    
    [_customSourceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(56 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_customSourceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(46 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_approachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_customSourceBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_approachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_customSourceBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_approachBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
//        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];
    
    [_sourceTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_sourceTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];
}

@end
