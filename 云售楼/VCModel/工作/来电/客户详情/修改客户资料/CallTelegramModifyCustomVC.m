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

#import "BorderTextField.h"
#import "DropBtn.h"

@interface CallTelegramModifyCustomVC ()<UITextFieldDelegate>
{
    
    NSString *_project_id;
    NSString *_info_id;
    
    NSDictionary *_dataDic;
    
    NSMutableArray *_approachArr;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *customSourceL;

@property (nonatomic, strong) DropBtn *customSourceBtn;

@property (nonatomic, strong) UILabel *approachL;

@property (nonatomic, strong) DropBtn *approachBtn;

@property (nonatomic, strong) UILabel *sourceTypeL;

@property (nonatomic, strong) DropBtn *sourceTypeBtn;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation CallTelegramModifyCustomVC

- (instancetype)initWithDataDic:(NSDictionary *)dataDic projectId:(NSString *)projectId info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _dataDic = dataDic;
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
}

- (void)PropertyRequestMethod{
    
    [BaseRequest GET:WorkClientAutoBasicConfig_URL parameters:@{@"info_id":_info_id} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            for (int i = 0; i < [resposeObject[@"data"][0] count]; i++) {
                
                NSDictionary *dic = @{@"id":resposeObject[@"data"][0][i][@"config_id"],
                                      @"param":resposeObject[@"data"][0][i][@"config_name"]};
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
        
        
    }else{
        
        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.frame WithData:_approachArr];
        view.selectedBlock = ^(NSString *MC, NSString *ID) {
            
            self->_approachBtn.content.text = [NSString stringWithFormat:@"%@",MC];
            self->_approachBtn->str = [NSString stringWithFormat:@"%@",ID];
            self->_approachBtn.placeL.text = @"";
        };
        [self.view addSubview:view];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSMutableDictionary *tempDic = [@{} mutableCopy];
    
    
    if (!_approachBtn.content.text.length) {
        
        [self alertControllerWithNsstring:@"必填信息" And:@"请选择认知途径"];
        return;
    }
    
    if (_customSourceBtn.content.text.length) {
        
        
    }
    
    [tempDic setObject:_dataDic[@"group_id"] forKey:@"group_id"];
    [tempDic setObject:_approachBtn->str forKey:@"listen_way"];
    [tempDic setObject:@"1" forKey:@"source"];
    
    [BaseRequest GET:WorkClientAutoGroupUpdate_URL parameters:tempDic success:^(id  _Nonnull resposeObject) {
        
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
    
    for (int i = 0; i < 3; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.placeL.text = @"请选择证件类型";
        btn.tag = i;
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
                if ([_dataDic[@"listen_way_detail"] length]) {
                    
                    _approachBtn.content.text = _dataDic[@"listen_way_detail"];
                    _approachBtn.placeL.text = @"";
                }else if ([_dataDic[@"listen_way"] length]){
                    
                    _approachBtn.content.text = _dataDic[@"listen_way"];
                    _approachBtn.placeL.text = @"";
                }
                [_scrollView addSubview:_approachBtn];
                break;
            }
            case 2:
            {
                
                _sourceTypeBtn = btn;
                _sourceTypeBtn.dropimg.hidden = YES;
                _sourceTypeBtn.content.text = _dataDic[@"source"];
                _sourceTypeBtn.placeL.text = @"";
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
