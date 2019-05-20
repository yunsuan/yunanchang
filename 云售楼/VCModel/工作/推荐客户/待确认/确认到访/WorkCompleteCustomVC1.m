//
//  WorkCompleteCustomVC1.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkCompleteCustomVC1.h"

#import "DropBtn.h"
#import "BorderTextField.h"
#import "WorkCompleteCustomVC2.h"
#import "SinglePickView.h"
#import "UITextField+ExtentRange.h"

@interface WorkCompleteCustomVC1 ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,YXTextFieldDelegate>
{
    
    NSInteger _num;
    NSString *_imgStr1;
    NSString *_imgStr2;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSInteger _index;
    NSString *_clientId;
    NSString *_cardType;
    NSString *_name;
    NSDictionary *_dataDic;
}

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UITextField *phoneTF1;

@property (nonatomic, strong) UITextField *phoneTF2;

@property (nonatomic, strong) UITextField *phoneTF3;

@property (nonatomic, strong) UITextField *phoneTF4;

@property (nonatomic, strong) UITextField *phoneTF5;

@property (nonatomic, strong) UITextField *phoneTF6;

@property (nonatomic, strong) UITextField *phoneTF7;

@property (nonatomic, strong) UITextField *phoneTF8;

@property (nonatomic, strong) UITextField *phoneTF9;

@property (nonatomic, strong) UITextField *phoneTF10;

@property (nonatomic, strong) UITextField *phoneTF11;

@property (nonatomic, strong) UILabel *hideL;

@property (nonatomic, strong) UIImageView *hideImg;

@property (nonatomic, strong) UILabel *hideReportL;

@property (nonatomic, strong) UILabel *identifyL;

@property (nonatomic, strong) DropBtn *identifyBtn;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTextField *codeTF;

@property (nonatomic, strong) UILabel *collL;

@property (nonatomic, strong) UIButton *posBtn;

@property (nonatomic, strong) UILabel *posL;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UILabel *backL;

@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation WorkCompleteCustomVC1

- (instancetype)initWithClientID:(NSString *)clientId name:(NSString *)name dataDic:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _name = name;
        _clientId = clientId;
        _dataDic = dataDic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _cardType = @"";
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == _phoneTF1) {
        
        if (_phoneTF1.text.length == 1) {
            
            
            [_phoneTF1 resignFirstResponder];
            [_phoneTF2 becomeFirstResponder];
            [_phoneTF2 setSelectedRange:NSMakeRange(0, 1)];
        }
        
    }
    if (textField == _phoneTF2) {
        
        if (_phoneTF2.text.length == 1) {
            
            [_phoneTF2 resignFirstResponder];
            [_phoneTF3 becomeFirstResponder];
            [_phoneTF3 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF2 .text.length == 0)
        {
            [_phoneTF2 resignFirstResponder];
            [_phoneTF1 becomeFirstResponder];
            [_phoneTF1 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF3) {
        
        if (_phoneTF3.text.length == 1) {
            
            [_phoneTF3 resignFirstResponder];
            [_phoneTF4 becomeFirstResponder];
            [_phoneTF4 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF3 .text.length == 0)
        {
            [_phoneTF3 resignFirstResponder];
            [_phoneTF2 becomeFirstResponder];
            [_phoneTF2 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF4) {
        
        if (_phoneTF4.text.length == 1) {
            
            [_phoneTF4 resignFirstResponder];
            [_phoneTF5 becomeFirstResponder];
            [_phoneTF5 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF4 .text.length == 0)
        {
            [_phoneTF4 resignFirstResponder];
            [_phoneTF3 becomeFirstResponder];
            [_phoneTF3 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF5) {
        
        if (_phoneTF5.text.length == 1) {
            
            [_phoneTF5 resignFirstResponder];
            [_phoneTF6 becomeFirstResponder];
            [_phoneTF6 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF5 .text.length == 0)
        {
            [_phoneTF5 resignFirstResponder];
            [_phoneTF4 becomeFirstResponder];
            [_phoneTF4 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF6) {
        
        if (_phoneTF6.text.length == 1) {
            
            [_phoneTF6 resignFirstResponder];
            [_phoneTF7 becomeFirstResponder];
            [_phoneTF7 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF6 .text.length == 0)
        {
            [_phoneTF6 resignFirstResponder];
            [_phoneTF5 becomeFirstResponder];
            [_phoneTF5 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF7) {
        
        if (_phoneTF7.text.length == 1) {
            
            [_phoneTF7 resignFirstResponder];
            [_phoneTF8 becomeFirstResponder];
            [_phoneTF8 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF7 .text.length == 0)
        {
            [_phoneTF7 resignFirstResponder];
            [_phoneTF6 becomeFirstResponder];
            [_phoneTF6 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF8) {
        
        if (_phoneTF8.text.length == 1) {
            
            [_phoneTF8 resignFirstResponder];
            [_phoneTF9 becomeFirstResponder];
            [_phoneTF9 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF8 .text.length == 0)
        {
            [_phoneTF8 resignFirstResponder];
            [_phoneTF7 becomeFirstResponder];
            [_phoneTF7 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF9) {
        
        if (_phoneTF9.text.length == 1) {
            
            [_phoneTF9 resignFirstResponder];
            [_phoneTF10 becomeFirstResponder];
            [_phoneTF10 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF9 .text.length == 0)
        {
            [_phoneTF9 resignFirstResponder];
            [_phoneTF8 becomeFirstResponder];
            [_phoneTF8 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF10) {
        
        if (_phoneTF10.text.length == 1) {
            
            [_phoneTF10 resignFirstResponder];
            [_phoneTF11 becomeFirstResponder];
            [_phoneTF11 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF10 .text.length == 0)
        {
            [_phoneTF10 resignFirstResponder];
            [_phoneTF9 becomeFirstResponder];
            [_phoneTF9 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField == _phoneTF11) {
        
        if (_phoneTF11.text.length == 1) {
            
            [_phoneTF11 resignFirstResponder];
            [_phoneTF11 setSelectedRange:NSMakeRange(0, 1)];
        }
        else if(_phoneTF11 .text.length == 0)
        {
            [_phoneTF11 resignFirstResponder];
            [_phoneTF10 becomeFirstResponder];
            [_phoneTF10 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    
    if (textField.text.length > 1) {
        
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 1)];
    }
}


- (void)ActionTagNumBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        
    }else{
        
        SinglePickView *view = [[SinglePickView alloc]initWithFrame:self.view.frame WithData:[self getDetailConfigArrByConfigState:CARD_TYPE]];

        view.selectedBlock = ^(NSString *MC, NSString *ID) {

            self->_identifyBtn.content.text = [NSString stringWithFormat:@"%@",MC];
            self->_cardType = [NSString stringWithFormat:@"%@",ID];
        };
        [self.view addSubview:view];
    }
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    NSString *tel;

    if ([_dataDic[@"tel_complete_state"] integerValue] == 2) {

        tel = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",_phoneTF1.text,_phoneTF2.text,_phoneTF3.text,_phoneTF4.text,_phoneTF5.text,_phoneTF6.text,_phoneTF7.text,_phoneTF8.text,_phoneTF9.text,_phoneTF10.text,_phoneTF11.text];
        if (![self checkTel:tel]) {

            [self alertControllerWithNsstring:@"温馨提示" And:@"请填写正确的电话号码"];
            return;
        }
    }else if ([_dataDic[@"tel_complete_state"] integerValue] == 0){

        tel = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",_phoneTF1.text,_phoneTF2.text,_phoneTF3.text,_phoneTF4.text,_phoneTF5.text,_phoneTF6.text,_phoneTF7.text,_phoneTF8.text,_phoneTF9.text,_phoneTF10.text,_phoneTF11.text];
        if (![self checkTel:tel]) {

            [self alertControllerWithNsstring:@"温馨提示" And:@"请填写正确的电话号码"];
            return;
        }
    }else{

        if (!_phoneTF1.text.length || !_phoneTF2.text.length || !_phoneTF3.text.length || !_phoneTF8.text.length || !_phoneTF9.text.length || !_phoneTF10.text.length || !_phoneTF11.text.length) {

            [self alertControllerWithNsstring:@"温馨提示" And:@"电话号码不完整"];
        }else{

            if (!_phoneTF4.text.length) {

                _phoneTF4.text = @"X";
            }
            if (!_phoneTF5.text.length){

                _phoneTF5.text = @"X";
            }
            if (!_phoneTF6.text.length){

                _phoneTF6.text = @"X";
            }
            if (!_phoneTF7.text.length){

                _phoneTF7.text = @"X";
            }

            if ([_phoneTF4.text isEqualToString:@"X"] || [_phoneTF5.text isEqualToString:@"X"] || [_phoneTF6.text isEqualToString:@"X"] || [_phoneTF7.text isEqualToString:@"X"]) {

                _phoneTF4.text = @"X";
                _phoneTF5.text = @"X";
                _phoneTF6.text = @"X";
                _phoneTF7.text = @"X";
            }

            tel = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@",_phoneTF1.text,_phoneTF2.text,_phoneTF3.text,_phoneTF4.text,_phoneTF5.text,_phoneTF6.text,_phoneTF7.text,_phoneTF8.text,_phoneTF9.text,_phoneTF10.text,_phoneTF11.text];
        }
    }

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

    [dic setObject:_clientId forKey:@"client_id"];
    [dic setObject:_nameTF.textField.text forKey:@"client_name"];
    if (tel) {
        [dic setObject:tel forKey:@"client_tel"];
    }
    else{
        [dic setObject:tel forKey:@""];
    }
    if (_cardType) {

        [dic setObject:_cardType forKey:@"card_type"];
    }
    if (_codeTF.textField.text) {

        [dic setObject:_codeTF.textField.text forKey:@"card_num"];
    }

    if (_imgStr1.length && _imgStr2.length) {

        [dic setObject:[NSString stringWithFormat:@"%@,%@",_imgStr1,_imgStr2] forKey:@"card_img_url"];
    }else if (_imgStr1.length && !_imgStr2.length){

        [dic setObject:_imgStr1 forKey:@"card_img_url"];
    }else if (!_imgStr1.length && _imgStr2.length){

        [dic setObject:_imgStr2 forKey:@"card_img_url"];
    }
    
    [BaseRequest GET:ClientNeedInfo_URL parameters:@{@"client_id":_clientId} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            WorkCompleteCustomVC2 *nextVC = [[WorkCompleteCustomVC2 alloc] initWithData:dic];
            nextVC.consulDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            nextVC.datadic = self->_dataDic;
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{

            WorkCompleteCustomVC2 *nextVC = [[WorkCompleteCustomVC2 alloc] initWithData:dic];
            nextVC.datadic = self->_dataDic;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    } failure:^(NSError *error) {

        WorkCompleteCustomVC2 *nextVC = [[WorkCompleteCustomVC2 alloc] initWithData:dic];

        nextVC.datadic = self->_dataDic;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
}


- (void)ActionTagBtn:(UIButton *)btn{
    
    _index = btn.tag;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectPhotoAlbumPhotos];
    }];
    UIAlertAction *takePic = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self takingPictures];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:takePic];
    [alertController addAction:photo];
    [alertController addAction:cancel];
    [self.navigationController presentViewController:alertController animated:YES completion:^{
        
    }];
}

#pragma mark - 选择头像

- (void)selectPhotoAlbumPhotos {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        _imagePickerController.allowsEditing = YES; // 如果设置为NO，当用户选择了图片之后不会进入图像编辑界面。
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

// 拍照
- (void)takingPictures {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        // 设置相机模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 设置摄像头：前置/后置
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置闪光模式
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    } else {
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                  message:@"当前设备不支持拍照"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              
                                                          }]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            
            _image = info[UIImagePickerControllerOriginalImage];;
            
            NSData *data = [self resetSizeOfImageData:_image maxSize:150];
            
            [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                [formData appendPartWithFileData:data name:@"id_card" fileName:@"id_card.jpg" mimeType:@"image/jpg"];
            } url:UploadFile_URL parameters:@{@"file_name":@"id_card"} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if (self->_index == 0) {
                        
                        [self->_posBtn setImage:self->_image forState:UIControlStateNormal];
                        self->_imgStr1 = resposeObject[@"data"];
                    }else{
                        
                        [self->_backBtn setImage:self->_image forState:UIControlStateNormal];
                        self->_imgStr2 = resposeObject[@"data"];
                    }
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                
                [self showContent:@"网络错误"];
            }];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
        _image = info[UIImagePickerControllerOriginalImage];
        
        NSData *data = [self resetSizeOfImageData:_image maxSize:150];
        
        [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:data name:@"id_card" fileName:@"id_card.jpg" mimeType:@"image/jpg"];
        } url:UploadFile_URL parameters:@{@"file_name":@"id_card"} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (self->_index == 0) {
                    
                    [self->_posBtn setImage:self->_image forState:UIControlStateNormal];
                    self->_imgStr1 = resposeObject[@"data"];
                }else{
                    
                    [self->_backBtn setImage:self->_image forState:UIControlStateNormal];
                    self->_imgStr2 = resposeObject[@"data"];
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
                                              
            [self showContent:@"网络错误"];
        }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        //        [self.authenColl reloadData];
        
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)initUI{
    
    self.titleLabel.text = @"确认到访信息";
    self.navBackgroundView.hidden = NO;
    
    _scrolleView = [[UIScrollView alloc] init];
    _scrolleView.backgroundColor = CLBackColor;
    _scrolleView.bounces = NO;
    [self.view addSubview:_scrolleView];
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = [UIColor whiteColor];
    [_scrolleView addSubview:_infoView];
    
    //    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _addBtn.frame = CGRectMake(313 *SIZE, 87 *SIZE, 25 *SIZE, 25 *SIZE);
    //    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    //    [_infoView addSubview:_addBtn];
    
    _hideImg = [[UIImageView alloc] init];
    _hideImg.image = [UIImage imageNamed:@"eye"];
    [_infoView addSubview:_hideImg];
    
    for(int i = 0; i < 7; i++){
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _nameL = label;
                _nameL.text = @"客户:";
                [_infoView addSubview:_nameL];
                break;
            }
            case 1:
            {
                
                _hideL = label;
                _hideL.font = [UIFont systemFontOfSize:11 *SIZE];
                _hideL.textColor = CL170Color;
                _hideL.text = @"只需输入手机号前三位后四位";
                [_infoView addSubview:_hideL];
                break;
            }
            case 2:
            {
                _hideReportL = label;
                _hideReportL.font = [UIFont systemFontOfSize:10 *SIZE];
                _hideReportL.textColor = COLOR(255, 165, 29, 1);
                _hideReportL.text = @"当前隐号报备";
                [_infoView addSubview:_hideReportL];
                break;
            }
            case 3:
            {
                _phoneL = label;
                _phoneL.text = @"联系号码:";
                [_infoView addSubview:_phoneL];
                break;
            }
            case 4:
            {
                _identifyL = label;
                _identifyL.text = @"证件类型:";
                [_infoView addSubview:_identifyL];
                break;
            }
            case 5:
            {
                _codeL = label;
                _codeL.text = @"证件号:";
                [_infoView addSubview:_codeL];
                break;
            }
            case 6:
            {
                _collL = label;
                _collL.text = @"身份证照片:";
                [_infoView addSubview:_collL];
                break;
            }
            default:
                break;
        }
        
        if (i < 2) {
            
            DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            btn.tag = i;
            [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                {
                    BorderTextField *TF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
                    TF.textField.text = _name;
                    _nameTF = TF;
                    [_infoView addSubview:_nameTF];
                    break;
                }
                case 1:
                {
                    _identifyBtn = btn;
                    [_infoView addSubview:_identifyBtn];
                    break;
                }
                default:
                    break;
            }
        }
        
        if (i < 1) {
            
            BorderTextField *TF = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
            _codeTF = TF;
            _codeTF.textField.keyboardType = UIKeyboardTypeNumberPad;
            [_infoView addSubview:_codeTF];
        }
    }
    
    for (int i = 0; i < 11; i++) {
        
        UITextField *borderTF = [[UITextField alloc] initWithFrame:CGRectMake(80 *SIZE, 75 *SIZE, 19 *SIZE, 24 *SIZE)];
        borderTF.textColor = CLContentLabColor;
        borderTF.keyboardType = UIKeyboardTypePhonePad;
        borderTF.font = [UIFont systemFontOfSize:13.3*SIZE];
        borderTF.layer.cornerRadius = 5*SIZE;
        borderTF.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
        borderTF.layer.borderWidth = 1*SIZE;
        borderTF.delegate = self;
        [borderTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        borderTF.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
            {
                _phoneTF1 = borderTF;
                _phoneTF1.delegate = self;
                _phoneTF1.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(0, 1)];
                [_infoView addSubview:_phoneTF1];
                break;
            }
            case 1:
            {
                _phoneTF2 = borderTF;
                _phoneTF2.delegate = self;
                _phoneTF2.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(1, 1)];
                [_infoView addSubview:_phoneTF2];
                break;
            }
            case 2:
            {
                _phoneTF3 = borderTF;
                _phoneTF3.delegate = self;
                _phoneTF3.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(2, 1)];
                [_infoView addSubview:_phoneTF3];
                break;
            }
            case 3:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF4 = borderTF;
                _phoneTF4.delegate = self;
                _phoneTF4.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(3, 1)];
                [_infoView addSubview:_phoneTF4];
                break;
            }
            case 4:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF5 = borderTF;
                _phoneTF5.delegate = self;
                _phoneTF5.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(4, 1)];
                [_infoView addSubview:_phoneTF5];
                break;
            }
            case 5:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF6 = borderTF;
                _phoneTF6.delegate = self;
                _phoneTF6.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(5, 1)];
                [_infoView addSubview:_phoneTF6];
                break;
            }
            case 6:
            {
                borderTF.layer.borderColor = COLOR(169, 219, 255, 1).CGColor;
                _phoneTF7 = borderTF;
                _phoneTF7.delegate = self;
                _phoneTF7.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(6, 1)];
                [_infoView addSubview:_phoneTF7];
                break;
            }
            case 7:
            {
                _phoneTF8 = borderTF;
                _phoneTF8.delegate = self;
                _phoneTF8.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(7, 1)];
                [_infoView addSubview:_phoneTF8];
                break;
            }
            case 8:
            {
                _phoneTF9 = borderTF;
                _phoneTF9.delegate = self;
                _phoneTF9.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(8, 1)];
                [_infoView addSubview:_phoneTF9];
                break;
            }
            case 9:
            {
                _phoneTF10 = borderTF;
                _phoneTF10.delegate = self;
                _phoneTF10.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(9, 1)];
                [_infoView addSubview:_phoneTF10];
                break;
            }
            case 10:
            {
                _phoneTF11 = borderTF;
                _phoneTF11.delegate = self;
                _phoneTF11.text = [[_dataDic[@"tel"] componentsSeparatedByString:@","][0] substringWithRange:NSMakeRange(10, 1)];
                [_infoView addSubview:_phoneTF11];
                break;
            }
            default:
                break;
        }
    }
    
    if ([_dataDic[@"tel_complete_state"] integerValue] == 2) {
        
        _phoneTF4.text = @"X";
        _phoneTF5.text = @"X";
        _phoneTF6.text = @"X";
        _phoneTF7.text = @"X";
        
        _hideReportL.hidden = YES;
        _hideL.hidden = YES;
        _hideImg.hidden = YES;
        
    }else if ([_dataDic[@"tel_complete_state"] integerValue] == 5){
        
        _phoneTF4.text = @"X";
        _phoneTF5.text = @"X";
        _phoneTF6.text = @"X";
        _phoneTF7.text = @"X";
        
        _hideReportL.hidden = NO;
        _hideL.hidden = NO;
        _hideImg.hidden = NO;
        
    }else{
        
        _hideReportL.hidden = YES;
        _hideL.hidden = YES;
        _hideImg.hidden = YES;
    }
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 *SIZE + i * 123 *SIZE, 50 *SIZE, 83 *SIZE, 83 *SIZE);
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CL170Color;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        if (i == 0) {
            
            [btn setImage:[UIImage imageNamed:@"positive"] forState:UIControlStateNormal];
            _posBtn = btn;
            [_infoView addSubview:_posBtn];
            
            _posL = label;
            _posL.text = @"上传正面人像页";
            [_infoView addSubview:_posL];
        }else{
            
            [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
            _backBtn = btn;
            [_infoView addSubview:_backBtn];
            
            _backL = label;
            _backL.text = @"上传背面国徽页";
            [_infoView addSubview:_backL];
        }
        
    }
    
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundColor:CLBlueBtnColor];
    _nextBtn.layer.cornerRadius = 2 *SIZE;
    _nextBtn.clipsToBounds = YES;
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrolleView addSubview:_nextBtn];
    
    [self masonryUI];
}


- (void)masonryUI{
    
    [_scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrolleView).offset(0);
        make.top.equalTo(self->_scrolleView).offset(0);
        make.right.equalTo(self->_scrolleView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
        make.bottom.equalTo(self->_nextBtn.mas_top).offset(-40 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_infoView).offset(31 *SIZE);
        make.width.equalTo(@(90 *SIZE));
        make.height.equalTo(@(12 *SIZE));
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(81 *SIZE);
        make.top.equalTo(self->_infoView).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(40 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_phoneTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(81 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF1.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF2.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF3.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF4.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF5.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF6.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF8 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF7.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF9 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF8.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF10 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF9.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_phoneTF11 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_phoneTF10.mas_right).offset(4 *SIZE);
        make.top.equalTo(self->_nameTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(19 *SIZE));
        make.height.equalTo(@(24 *SIZE));
    }];
    
    [_hideL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(80 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
        make.height.mas_equalTo(10 *SIZE);
    }];
    
    [_hideImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(271 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(20 *SIZE);
        make.width.mas_equalTo(14 *SIZE);
        make.height.mas_equalTo(6 *SIZE);
    }];
    
    [_hideReportL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(299 *SIZE);
        make.top.equalTo(self->_phoneL.mas_bottom).offset(18 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
        make.height.mas_equalTo(10 *SIZE);
    }];
    
    [_identifyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_hideL.mas_bottom).offset(31 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_identifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(81 *SIZE);
        make.top.equalTo(self->_hideL.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_identifyBtn.mas_bottom).offset(32 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(81 *SIZE);
        make.top.equalTo(self->_identifyBtn.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_collL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(29 *SIZE);
        make.width.equalTo(@(90 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    //    [_authenColl mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_infoView).offset(0 *SIZE);
    //        make.top.equalTo(_codeTF.mas_bottom).offset(58 *SIZE);
    //        make.width.equalTo(@(SCREEN_Width));
    //        make.height.equalTo(@(91 *SIZE));
    //        make.bottom.equalTo(_infoView.mas_bottom).offset( -32 *SIZE);
    //    }];
    
    [_posBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(58 *SIZE);
        make.width.equalTo(@(83 *SIZE));
        make.height.equalTo(@(83 *SIZE));
        make.bottom.equalTo(self->_infoView.mas_bottom).offset( -32 *SIZE);
    }];
    
    [_posL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(13 *SIZE);
        make.top.equalTo(self->_posBtn.mas_bottom).offset(5 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(133 *SIZE);
        make.top.equalTo(self->_codeTF.mas_bottom).offset(58 *SIZE);
        make.width.equalTo(@(83 *SIZE));
        make.height.equalTo(@(83 *SIZE));
        make.bottom.equalTo(self->_infoView.mas_bottom).offset( -32 *SIZE);
    }];
    
    [_backL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(135 *SIZE);
        make.top.equalTo(self->_backBtn.mas_bottom).offset(5 *SIZE);
        make.width.equalTo(@(100 *SIZE));
        make.height.equalTo(@(10 *SIZE));
    }];
    
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrolleView).offset(22 *SIZE);
        make.top.equalTo(self->_infoView.mas_bottom).offset(40 *SIZE);
        make.right.equalTo(self->_scrolleView).offset(-22 *SIZE);
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(self->_scrolleView.mas_bottom).offset(-51 *SIZE);
    }];
    
}

-(void)textFieldDidDeleteBackward:(UITextField *)textField{
    if (textField ==_phoneTF2) {
        if (_phoneTF2.text.length ==0) {
            [_phoneTF2 resignFirstResponder];
            [_phoneTF1 becomeFirstResponder];
            [_phoneTF1 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    
    if (textField ==_phoneTF3) {
        if (_phoneTF3.text.length ==0) {
            [_phoneTF3 resignFirstResponder];
            [_phoneTF2 becomeFirstResponder];
            [_phoneTF2 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    
    if (textField ==_phoneTF4) {
        if (_phoneTF4.text.length ==0) {
            [_phoneTF4 resignFirstResponder];
            [_phoneTF3 becomeFirstResponder];
            [_phoneTF3 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField ==_phoneTF5) {
        if (_phoneTF5.text.length ==0) {
            [_phoneTF5 resignFirstResponder];
            [_phoneTF4 becomeFirstResponder];
            [_phoneTF4 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField ==_phoneTF6) {
        if (_phoneTF6.text.length ==0) {
            [_phoneTF6 resignFirstResponder];
            [_phoneTF5 becomeFirstResponder];
            [_phoneTF5 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField ==_phoneTF7) {
        if (_phoneTF7.text.length ==0) {
            [_phoneTF7 resignFirstResponder];
            [_phoneTF6 becomeFirstResponder];
            [_phoneTF6 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField ==_phoneTF8) {
        if (_phoneTF8.text.length ==0) {
            [_phoneTF8 resignFirstResponder];
            [_phoneTF7 becomeFirstResponder];
            [_phoneTF7 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField ==_phoneTF9) {
        if (_phoneTF9.text.length ==0) {
            [_phoneTF9 resignFirstResponder];
            [_phoneTF8 becomeFirstResponder];
            [_phoneTF8 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField ==_phoneTF10) {
        if (_phoneTF10.text.length ==0) {
            [_phoneTF10 resignFirstResponder];
            [_phoneTF9 becomeFirstResponder];
            [_phoneTF9 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    if (textField ==_phoneTF11) {
        if (_phoneTF11.text.length ==0) {
            [_phoneTF11 resignFirstResponder];
            [_phoneTF10 becomeFirstResponder];
            [_phoneTF10 setSelectedRange:NSMakeRange(0, 1)];
        }
    }
    
}

@end
