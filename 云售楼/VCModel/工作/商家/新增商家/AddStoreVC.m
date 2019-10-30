//
//  AddStoreVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddStoreVC.h"

#import "AddStoreNeedVC.h"

#import "SinglePickView.h"
#import "AdressChooseView.h"
#import "ThirdPickView.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface AddStoreVC ()<UITextFieldDelegate>
{
    
    NSString *_info_id;
    NSString *_project_id;
    NSString *_proId;
    NSString *_cityId;
    NSString *_areaId;
    
    NSMutableArray *_formatArr;
    NSMutableArray *_statusArr;
    NSMutableArray *_approachArr;
    NSMutableArray *_brandArr;;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UILabel *nickL;

@property (nonatomic, strong) BorderTextField *nickTF;

@property (nonatomic, strong) UILabel *contractL;

@property (nonatomic, strong) BorderTextField *contractTF;

@property (nonatomic, strong) UILabel *phoneL1;

@property (nonatomic, strong) BorderTextField *phoneTF1;

@property (nonatomic, strong) UILabel *phoneL2;

@property (nonatomic, strong) BorderTextField *phoneTF2;

@property (nonatomic, strong) UILabel *phoneL3;

@property (nonatomic, strong) BorderTextField *phoneTF3;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) BorderTextField *areaTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTextField *priceTF;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) DropBtn *statusBtn;

@property (nonatomic, strong) UILabel *formatL;

@property (nonatomic, strong) DropBtn *formatBtn;

@property (nonatomic, strong) UILabel *approachL;

@property (nonatomic, strong) DropBtn *approachBtn;

@property (nonatomic, strong) UILabel *brandL;

@property (nonatomic, strong) DropBtn *brandBtn;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) DropBtn *regionBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) BorderTextField *addressTF;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation AddStoreVC

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
    
    _approachArr = [@[] mutableCopy];
    _statusArr = [@[] mutableCopy];
    _formatArr = [@[] mutableCopy];
    _brandArr = [@[] mutableCopy];
}


- (void)ActionDropBtn:(UIButton *)btn{

    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    
    switch (btn.tag) {
            
        case 0:{
            
            if (!_statusArr.count) {
                
                [BaseRequest GET:ProjectBusinessGetBasicsList_URL parameters:@{@"project_id":_project_id,@"type":@"1"} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                            
                            if ([resposeObject[@"data"][i][@"basics_name"] isEqualToString:@"经营业态"]) {
                                
                                self->_formatArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][i][@"children"]];
                            }
                            if ([resposeObject[@"data"][i][@"basics_name"] isEqualToString:@"经营关系"]) {
                                
                                self->_statusArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][i][@"children"]];
                            }
                            if ([resposeObject[@"data"][i][@"basics_name"] isEqualToString:@"认知途径"]) {
                                
                                self->_approachArr = [NSMutableArray arrayWithArray:resposeObject[@"data"][i][@"children"]];
                            }
                        }
                        ThirdPickView *view = [[ThirdPickView alloc] initWithFrame:self.view.bounds withdata:self->_statusArr unitName:@"" unitId:@""];
                        view.thirdPickViewBlock = ^(NSString * _Nonnull first, NSString * _Nonnull second, NSString * _Nonnull third, NSString * _Nonnull firstId, NSString * _Nonnull secondId, NSString * _Nonnull thirdId) {
                            
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }else{
                
                ThirdPickView *view = [[ThirdPickView alloc] initWithFrame:self.view.bounds withdata:_statusArr unitName:@"" unitId:@""];
                view.thirdPickViewBlock = ^(NSString * _Nonnull first, NSString * _Nonnull second, NSString * _Nonnull third, NSString * _Nonnull firstId, NSString * _Nonnull secondId, NSString * _Nonnull thirdId) {
                    
                };
                [self.view addSubview:view];
            }
            break;
        }case 1:{
            
            if (!_formatArr.count) {
                
                [BaseRequest GET:ProjectBusinessGetFormatList_URL parameters:nil success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        self->_formatArr = [[NSMutableArray alloc] initWithArray:resposeObject[@"data"]];
                        ThirdPickView *view = [[ThirdPickView alloc] initWithFrame:self.view.bounds withdata:self->_formatArr unitName:@"format_name" unitId:@"format_id"];
                        view.thirdPickViewBlock = ^(NSString * _Nonnull first, NSString * _Nonnull second, NSString * _Nonnull third, NSString * _Nonnull firstId, NSString * _Nonnull secondId, NSString * _Nonnull thirdId) {
                            
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }else{
                
                ThirdPickView *view = [[ThirdPickView alloc] initWithFrame:self.view.bounds withdata:_formatArr unitName:@"format_name" unitId:@"format_id"];
                view.thirdPickViewBlock = ^(NSString * _Nonnull first, NSString * _Nonnull second, NSString * _Nonnull third, NSString * _Nonnull firstId, NSString * _Nonnull secondId, NSString * _Nonnull thirdId) {
                    
                };
                [self.view addSubview:view];
            }
            break;
        }case 2:{
            if (!_approachArr.count) {
                
                [BaseRequest GET:ProjectBusinessGetSourceList_URL parameters:@{@"project_id":_project_id} success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        self->_approachArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                        ThirdPickView *view = [[ThirdPickView alloc] initWithFrame:self.view.bounds withdata:self->_approachArr unitName:@"source_name" unitId:@"source_id"];
                        view.thirdPickViewBlock = ^(NSString * _Nonnull first, NSString * _Nonnull second, NSString * _Nonnull third, NSString * _Nonnull firstId, NSString * _Nonnull secondId, NSString * _Nonnull thirdId) {
                            
                        };
                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }else{
                
                ThirdPickView *view = [[ThirdPickView alloc] initWithFrame:self.view.bounds withdata:_approachArr unitName:@"source_name" unitId:@"source_id"];
                view.thirdPickViewBlock = ^(NSString * _Nonnull first, NSString * _Nonnull second, NSString * _Nonnull third, NSString * _Nonnull firstId, NSString * _Nonnull secondId, NSString * _Nonnull thirdId) {
                    
                };
                [self.view addSubview:view];
            }
            break;
        }case 3:{
            
            if (!_brandArr.count) {
                
                [BaseRequest GET:ProjectBusinessGetBrandList_URL parameters:nil success:^(id  _Nonnull resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        [self->_brandArr removeAllObjects];
                        for (int i = 0; i < [resposeObject[@"data"] count]; i++) {
                            
                            NSDictionary *dic = resposeObject[@"data"][i];
                            [self->_brandArr addObject:@{@"param":[NSString stringWithFormat:@"%@-%@",dic[@"resource_name"],dic[@"format_name"]],
                                                         @"id":[NSString stringWithFormat:@"%@",dic[@"resource_id"]]}];
                        }
                        SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_brandArr];
                        view.selectedBlock = ^(NSString *MC, NSString *ID) {
                            
                            self->_brandBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                            self->_brandBtn->str = [NSString stringWithFormat:@"%@",ID];
                            self->_brandBtn.placeL.text = @"";
                        };
                        [self.view addSubview:view];
//                        self->_brandArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
//                        ThirdPickView *view = [[ThirdPickView alloc] initWithFrame:self.view.bounds withdata:self->_brandArr];
//                        view.thirdPickViewBlock = ^(NSString * _Nonnull first, NSString * _Nonnull second, NSString * _Nonnull third, NSString * _Nonnull firstId, NSString * _Nonnull secondId, NSString * _Nonnull thirdId) {
//
//                        };
//                        [self.view addSubview:view];
                    }else{
                        
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                    [self showContent:@"网络错误"];
                }];
            }else{
                
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:self->_brandArr];
                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    self->_brandBtn.content.text = [NSString stringWithFormat:@"%@",MC];
                    self->_brandBtn->str = [NSString stringWithFormat:@"%@",ID];
                    self->_brandBtn.placeL.text = @"";
                };
                [self.view addSubview:view];
            }
            break;
        }case 4:{
            
            AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.bounds withdata:@[]];
//            WS(weakself);
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
                self->_regionBtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",proName,city,area];
                self->_regionBtn.placeL.text = @"";
                self->_proId = pro;
                self->_cityId = cityid;
                self->_areaId = areaid;
            };
            [self.view addSubview:addressChooseView];
            break;
        }
        default:
            break;
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
    if ([self isEmpty:_nameTF.textField.text]) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请填写商家名称"];
        return;
    }
    if ([self isEmpty:_contractTF.textField.text]) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请填写联系人"];
        return;
    }
    if ([self isEmpty:_phoneTF1.textField.text]) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请填写联系电话"];
        return;
    }
    if ([self isEmpty:_areaTF.textField.text]) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请填写承租面积"];
        return;
    }
    if ([self isEmpty:_priceTF.textField.text]) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请填写承租价格"];
        return;
    }
    if (!_statusBtn.content.text.length) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请选择经营关系"];
        return;
    }
    if (!_formatBtn.content.text.length) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请选择经营业态"];
        return;
    }
    
    if (!_approachBtn.content.text.length) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请选择认知途径"];
        return;
    }
    
    if (!_regionBtn.content.text.length) {

        [self alertControllerWithNsstring:@"必填信息" And:@"请选择所属区域"];
        return;
    }
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    
    [tempDic setValue:_project_id forKey:@"project_id"];
    
    AddStoreNeedVC *nextVC = [[AddStoreNeedVC alloc] initWithDataDic:tempDic];
    [self.navigationController pushViewController:nextVC animated:YES];
}
    
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _phoneTF1.textField) {

        return [self validateNumber:string];
    }else if (textField == _phoneTF2.textField){

        return [self validateNumber:string];
    }else if (textField == _phoneTF3.textField){

        return [self validateNumber:string];
    }else if (textField == _areaTF.textField) {
        
        BOOL isHaveDian;
        
        //判断是否有小数点
        if ([textField.text containsString:@"."]) {
            isHaveDian = YES;
        }else{
            isHaveDian = NO;
        }
        
        if (string.length > 0) {
            
            //当前输入的字符
            unichar single = [string characterAtIndex:0];
            NSLog(@"single = %c",single);
            
            //不能输入.0~9以外的字符
            if (!((single >= '0' && single <= '9') || single == '.')){
                NSLog(@"您输入的格式不正确");
                return NO;
            }
            
            //只能有一个小数点
            if (isHaveDian && single == '.') {
                NSLog(@"只能输入一个小数点");
                return NO;
            }
            
            //如果第一位是.则前面加上0
            if ((textField.text.length == 0) && (single == '.')) {
                textField.text = @"0";
            }
            
            //如果第一位是0则后面必须输入.
            if ([textField.text hasPrefix:@"0"]) {
                if (textField.text.length > 1) {
                    NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                    if (![secondStr isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }else{
                    if (![string isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }
            }
            
            //小数点后最多能输入两位
            if (isHaveDian) {
                NSRange ran = [textField.text rangeOfString:@"."];
                //由于range.location是NSUInteger类型的，所以不能通过(range.location - ran.location) > 2来判断
                if (range.location > ran.location) {
                    if ([textField.text pathExtension].length > 3) {
                        NSLog(@"小数点后最多有两位小数");
                        return NO;
                    }
                }
            }
            
        }
        
        return YES;
    }else if (textField == _priceTF.textField) {
        
        BOOL isHaveDian;
        
        //判断是否有小数点
        if ([textField.text containsString:@"."]) {
            isHaveDian = YES;
        }else{
            isHaveDian = NO;
        }
        
        if (string.length > 0) {
            
            //当前输入的字符
            unichar single = [string characterAtIndex:0];
            NSLog(@"single = %c",single);
            
            //不能输入.0~9以外的字符
            if (!((single >= '0' && single <= '9') || single == '.')){
                NSLog(@"您输入的格式不正确");
                return NO;
            }
            
            //只能有一个小数点
            if (isHaveDian && single == '.') {
                NSLog(@"只能输入一个小数点");
                return NO;
            }
            
            //如果第一位是.则前面加上0
            if ((textField.text.length == 0) && (single == '.')) {
                textField.text = @"0";
            }
            
            //如果第一位是0则后面必须输入.
            if ([textField.text hasPrefix:@"0"]) {
                if (textField.text.length > 1) {
                    NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                    if (![secondStr isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }else{
                    if (![string isEqualToString:@"."]) {
                        NSLog(@"第二个字符必须是小数点");
                        return NO;
                    }
                }
            }
            
            //小数点后最多能输入两位
            if (isHaveDian) {
                NSRange ran = [textField.text rangeOfString:@"."];
                //由于range.location是NSUInteger类型的，所以不能通过(range.location - ran.location) > 2来判断
                if (range.location > ran.location) {
                    if ([textField.text pathExtension].length > 1) {
                        NSLog(@"小数点后最多有两位小数");
                        return NO;
                    }
                }
            }
            
        }
        
        return YES;
    }else{

        return YES;
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == _phoneTF1.textField || textField == _phoneTF2.textField || textField == _phoneTF3.textField) {

        if (textField.text.length > 11) {
            
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
    
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (([_phoneTF1.textField.text isEqualToString:_phoneTF2.textField.text] && _phoneTF1.textField.text.length && _phoneTF2.textField.text.length)) {
                
        [self alertControllerWithNsstring:@"号码重复" And:@"请检查号码" WithDefaultBlack:^{
                    
            self->_phoneTF2.textField.text = @"";
        }];
        return;
    }else if (([_phoneTF1.textField.text isEqualToString:_phoneTF3.textField.text] && _phoneTF1.textField.text.length && _phoneTF3.textField.text.length)){
                
        [self alertControllerWithNsstring:@"号码重复" And:@"请检查号码" WithDefaultBlack:^{
                    
            self->_phoneTF3.textField.text = @"";
        }];
        return;
    }else if (([_phoneTF3.textField.text isEqualToString:_phoneTF2.textField.text] && _phoneTF3.textField.text.length && _phoneTF2.textField.text.length)){
                
        [self alertControllerWithNsstring:@"号码重复" And:@"请检查号码" WithDefaultBlack:^{
                    
            self->_phoneTF3.textField.text = @"";
        }];
        return;
    }
            
    if (textField == _phoneTF1.textField || textField == _phoneTF2.textField || textField == _phoneTF3.textField) {
                
        [BaseRequest GET:ProjectBusinessContactTelCheck_URL parameters:@{@"project_id":_project_id,@"tel":textField.text} success:^(id  _Nonnull resposeObject) {

            if ([resposeObject[@"code"] integerValue] == 400) {

                [self alertControllerWithNsstring:@"号码重复" And:resposeObject[@"msg"] WithDefaultBlack:^{


                }];
            }else{


            }
        } failure:^(NSError * _Nonnull error) {


        }];
    }
}

- (void)initUI{

    self.titleLabel.text = @"新增商家";

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    NSArray *titleArr = @[@"商家名称：",@"商家简称：",@"联系人：",@"联系号码：",@"联系号码：",@"联系号码：",@"承租面积：",@"承租价格：",@"经营关系：",@"经营业态：",@"认知途径：",@"品牌信息：",@"所属区域：",@"通讯地址："];
    for (int i = 0; i < 14; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        
        switch (i) {
            case 0:
            {
                _nameL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_nameL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _nameL.attributedText = attr;
                [_scrollView addSubview:_nameL];
                
                _nameTF = tf;
                _nameTF.textField.delegate = self;
                _nameTF.textField.placeholder = @"商家名称";
                [_scrollView addSubview:_nameTF];
                break;
            }
            case 1:
            {
                _nickL = label;
                [_scrollView addSubview:_nickL];
                
                _nickTF = tf;
                _nickTF.textField.delegate = self;
                _nickTF.textField.placeholder = @"商家昵称";
                [_scrollView addSubview:_nickTF];
                break;
            }
            case 2:
            {
                _contractL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_contractL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _contractL.attributedText = attr;
                [_scrollView addSubview:_contractL];
                
                _contractTF = tf;
                _contractTF.textField.delegate = self;
                _contractTF.textField.placeholder = @"联系人";
                [_scrollView addSubview:_contractTF];
                break;
            }
            case 3:
            {
                _phoneL1 = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_phoneL1.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _phoneL1.attributedText = attr;
                [_scrollView addSubview:_phoneL1];
                
                _phoneTF1 = tf;
                _phoneTF1.textField.delegate = self;
                _phoneTF1.textField.placeholder = @"联系电话";
                _phoneTF1.textField.keyboardType = UIKeyboardTypePhonePad;
                [_scrollView addSubview:_phoneTF1];
                break;
            }
            case 4:
            {
                _phoneL2 = label;
                [_scrollView addSubview:_phoneL2];
                
                _phoneTF2 = tf;
                _phoneTF2.textField.delegate = self;
                _phoneTF2.textField.placeholder = @"联系电话";
                _phoneTF2.textField.keyboardType = UIKeyboardTypePhonePad;
                [_scrollView addSubview:_phoneTF2];
                break;
            }
            case 5:
            {
                _phoneL3 = label;
                [_scrollView addSubview:_phoneL3];
                
                _phoneTF3 = tf;
                _phoneTF3.textField.delegate = self;
                _phoneTF3.textField.placeholder = @"联系电话";
                _phoneTF3.textField.keyboardType = UIKeyboardTypePhonePad;
                [_scrollView addSubview:_phoneTF3];
                break;
            }
            case 6:
            {
                _areaL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_areaL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _areaL.attributedText = attr;
                [_scrollView addSubview:_areaL];
                
                _areaTF = tf;
                _areaTF.textField.delegate = self;
                _areaTF.textField.placeholder = @"承租面积";
                _areaTF.unitL.text = @"㎡";
                _areaTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_areaTF];
                break;
            }
            case 7:
            {
                _priceL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_priceL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _priceL.attributedText = attr;
                [_scrollView addSubview:_priceL];
                
                _priceTF = tf;
                _priceTF.textField.delegate = self;
                _priceTF.textField.placeholder = @"承租价格";
                _priceTF.unitL.text = @"元/月/㎡";
                _priceTF.unitL.adjustsFontSizeToFitWidth = YES;
                _priceTF.textField.keyboardType = UIKeyboardTypeNumberPad;
                [_scrollView addSubview:_priceTF];
                break;
            }
            case 8:
            {
                _statusL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_statusL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _statusL.attributedText = attr;
                [_scrollView addSubview:_statusL];
                
                break;
            }
            case 9:
            {
                _formatL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_formatL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _formatL.attributedText = attr;
                [_scrollView addSubview:_formatL];
                break;
            }
            case 10:
            {
                _approachL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_approachL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _approachL.attributedText = attr;
                [_scrollView addSubview:_approachL];
                
                break;
            }
            case 11:
            {
                _brandL = label;
                [_scrollView addSubview:_brandL];
                break;
            }
            case 12:
            {
                _regionL = label;
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"*%@",_regionL.text]];
                [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
                _regionL.attributedText = attr;
                [_scrollView addSubview:_regionL];
                break;
            }
            case 13:
            {
                _addressL = label;
                [_scrollView addSubview:_addressL];
                
                _addressTF = tf;
                _addressTF.textField.delegate = self;
                _addressTF.textField.placeholder = @"请填写通讯地址";
                [_scrollView addSubview:_addressTF];
                break;
            }

            default:
                break;
        }
    }
    
    for (int i = 0; i < 5; i++) {
        
        DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionDropBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                
                _statusBtn = btn;
                _statusBtn.placeL.text = @"请选择经营关系";
                [_scrollView addSubview:_statusBtn];
                break;
            }
            case 1:
            {
                
                _formatBtn = btn;
                _formatBtn.placeL.text = @"请选择经营业态";
                [_scrollView addSubview:_formatBtn];
                break;
            }
            case 2:
            {
                
                _approachBtn = btn;
                _approachBtn.placeL.text = @"请选择认知途径";
                [_scrollView addSubview:_approachBtn];
                break;
            }
            case 3:
            {
                
                _brandBtn = btn;
                _regionBtn.placeL.text = @"请选择品牌信息";
                [_scrollView addSubview:_brandBtn];
                break;
            }
            case 4:
            {
                
                _regionBtn = btn;
                _regionBtn.placeL.text = @"请选择所属区域";
                [_scrollView addSubview:_regionBtn];
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
    [_nextBtn setTitle:@"下一步 需求调查" forState:UIControlStateNormal];
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
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_scrollView).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_scrollView).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    
    [_nickL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_nickTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_contractL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_nickTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_contractTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_nickTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_contractTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_contractTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF1.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF1.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_phoneL3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF2.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF2.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_phoneTF3.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneTF3.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_areaTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_areaTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_priceTF.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_formatL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_statusBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_formatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_statusBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_approachL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_formatBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_approachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_formatBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_brandL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_brandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_approachBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_regionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_brandBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_regionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_brandBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(9 *SIZE);
        make.top.equalTo(self->_regionBtn.mas_bottom).offset(31 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_addressTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(80 *SIZE);
        make.top.equalTo(self->_regionBtn.mas_bottom).offset(21 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
        make.bottom.equalTo(self->_scrollView).offset(-20 *SIZE);
    }];
}
@end
