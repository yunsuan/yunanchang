//
//  AddStoreVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/10/30.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "AddStoreVC.h"

#import "BorderTextField.h"
#import "DropBtn.h"

@interface AddStoreVC ()<UITextFieldDelegate>
{
    
    NSString *_info_id;
    NSString *_project_id;
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

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) DropBtn *regionBtn;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) DropBtn *addressBtn;
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
 
    [self initUI];
}

- (void)ActionDropBtn:(UIButton *)btn{

    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    for (BorderTextField *tf in _scrollView.subviews) {
        
        if ([tf isKindOfClass:[BorderTextField class]]) {
            
            [tf.textField endEditing:YES];
        }
    }
}
    
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    if (textField == _phoneTF.textField) {
//
//        return [self validateNumber:string];
//    }else if (textField == _phoneTF2.textField){
//
//        return [self validateNumber:string];
//    }else if (textField == _phoneTF3.textField){
//
//        return [self validateNumber:string];
//    }else if (textField == _mailCodeTF.textField){
//
//        return [self validateNumber:string];
//    }else{
//
//        return YES;
//    }
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
                
//                [BaseRequest GET:TelRepeatCheck_URL parameters:@{@"project_id":_project_id,@"tel":textField.text} success:^(id  _Nonnull resposeObject) {
//
//                    if ([resposeObject[@"code"] integerValue] == 400) {
//
//                        [self alertControllerWithNsstring:@"号码重复" And:resposeObject[@"msg"] WithDefaultBlack:^{
//
//    //                        textField.text = @"";
//                        }];
//                    }else{
//
//
//                    }
//                } failure:^(NSError * _Nonnull error) {
//
//                    //            self
//                }];
    }
}

- (void)initUI{

    self.titleLabel.text = @"新增商家";

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = CLWhiteColor;
    [self.view addSubview:_scrollView];
    
    NSArray *titleArr = @[@"商家名称：",@"商家简称：",@"联系人：",@"联系号码：",@"联系号码：",@"联系号码：",@"承租面积：",@"承租价格：",@"经营关系：",@"经营业态：",@"认知途径：",@"所属区域：",@"通讯地址："];
    for (int i = 0; i < 13; i++) {
        
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
                [_scrollView addSubview:_contractL];
                break;
            }
            case 3:
            {
                _phoneL1 = label;
                [_scrollView addSubview:_phoneL1];
                break;
            }
            case 4:
            {
                _phoneL2 = label;
                [_scrollView addSubview:_phoneL2];
                break;
            }
            case 5:
            {
                _phoneL3 = label;
                [_scrollView addSubview:_phoneL3];
                break;
            }
            case 6:
            {
                _areaL = label;
                [_scrollView addSubview:_areaL];
                break;
            }
            case 7:
            {
                _priceL = label;
                [_scrollView addSubview:_priceL];
                break;
            }
            case 8:
            {
                _statusL = label;
                [_scrollView addSubview:_statusL];
                break;
            }
            case 9:
            {
                _formatL = label;
                [_scrollView addSubview:_formatL];
                break;
            }
            case 10:
            {
                _approachL = label;
                [_scrollView addSubview:_approachL];
                break;
            }
            case 11:
            {
                _regionL = label;
                [_scrollView addSubview:_regionL];
                break;
            }
            case 12:
            {
                _addressL = label;
                [_scrollView addSubview:_addressL];
                break;
            }

            default:
                break;
        }
    }
}

@end
