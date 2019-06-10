//
//  WorkCompleteCustomVC2.m
//  云售楼
//
//  Created by 谷治墙 on 2019/5/6.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "WorkCompleteCustomVC2.h"

#import "DropBtn.h"
#import "BorderTextField.h"
#import "AuthenCollCell.h"
#import "SinglePickView.h"
#import "WorkerPickView.h"
#import "DateChooseView.h"
#import "WorkRecommendVC.h"
#import "TaskVC.h"

@interface WorkCompleteCustomVC2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    
    NSInteger _num;
    BOOL _isOne;
    NSInteger _index;
    NSMutableArray *_imgArr1;
    NSMutableArray *_imgUrl1;
    NSMutableArray *_imgArr2;
    NSMutableArray *_imgUrl2;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSMutableDictionary *_dic;
    NSMutableArray *_peopleArr;
    NSDate *_date;
    NSString *_agentname;
    NSString *_agentid;
    NSMutableArray *_ruleArr;
}

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) DropBtn *numBtn;

@property (nonatomic, strong) DropBtn *purposeBtn;

@property (nonatomic, strong) DropBtn *agentbtn;

@property (nonatomic, strong) BorderTextField *adviserTF;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) BorderTextField *signTF1;

@property (nonatomic, strong) BorderTextField *signTF2;

@property (nonatomic, strong) BorderTextField *signTF3;

@property (nonatomic, strong) BorderTextField *signTF4;

@property (nonatomic, strong) BorderTextField *signTF5;

@property (nonatomic, strong) UILabel *recommendTypeL;

@property (nonatomic, strong) DropBtn *recommendTypeBtn;

@property (nonatomic, strong) UILabel *visitL;

@property (nonatomic, strong) UILabel *confirmL;

@property (nonatomic, strong) UITextView *markView;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIView *timeView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UICollectionView *authenColl1;

@property (nonatomic, strong) UICollectionView *authenColl2;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) DateChooseView *dateView;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation WorkCompleteCustomVC2

- (instancetype)initWithData:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        _dic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _peopleArr = [[NSMutableArray alloc] init];
    for (int i = 1; i < 5; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d人",i];
        [_peopleArr addObject:@{@"id":@(i),@"param":str}];
    }
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    _imgArr1 = [@[] mutableCopy];
    _imgArr2 = [@[] mutableCopy];
    _imgUrl1 = [@[] mutableCopy];
    _imgUrl2 = [@[] mutableCopy];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _agentname =@"";
    _agentid = @"0";
    
    [self.consulDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"rule_type_tags"]) {
            
            [self.consulDic setObject:obj forKey:key];
        }else{
            
            [self.consulDic setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
        }
        
    }];
    
    _ruleArr = [@[] mutableCopy];
    if ([self.consulDic count] && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]]) {
        
        for (int i = 0; i < [self.consulDic[@"rule_type_tags"] count]; i++) {
            
            NSMutableDictionary *tempDic = [self.consulDic[@"rule_type_tags"][i] mutableCopy];
            [tempDic setObject:tempDic[@"tag_id"] forKey:@"id"];
            [tempDic setObject:tempDic[@"tag_name"] forKey:@"param"];
            [tempDic removeObjectForKey:@"tag_id"];
            [tempDic removeObjectForKey:@"tag_name"];
            
            [_ruleArr addObject:tempDic];
        }
    }
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    _num += 1;
    switch (_num) {
        case 1:
        {
            _signTF2.hidden = NO;
            [_signTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_infoView).offset(81 *SIZE);
                make.top.equalTo(self->_signTF1.mas_bottom).offset(21 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            
            if (self.consulDic.count && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]] && [self.consulDic[@"rule_type_tags"] count]) {
                
                [_recommendTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(10 *SIZE);
                    make.top.equalTo(self->_signTF2.mas_bottom).offset(31 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
                
                [_recommendTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(80 *SIZE);
                    make.top.equalTo(self->_signTF2.mas_bottom).offset(21 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                
            }else{
                
                [_visitL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(10 *SIZE);
                    make.top.equalTo(self->_signTF2.mas_bottom).offset(31 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
            }
            
            break;
        }
        case 2:
        {
            _signTF3.hidden = NO;
            [_signTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_infoView).offset(81 *SIZE);
                make.top.equalTo(self->_signTF2.mas_bottom).offset(21 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            
            if (self.consulDic.count && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]] && [self.consulDic[@"rule_type_tags"] count]) {
                
                [_recommendTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(10 *SIZE);
                    make.top.equalTo(self->_signTF3.mas_bottom).offset(31 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
                
                [_recommendTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(80 *SIZE);
                    make.top.equalTo(self->_signTF3.mas_bottom).offset(21 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                
            }else{
                
                [_visitL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(10 *SIZE);
                    make.top.equalTo(self->_signTF3.mas_bottom).offset(31 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
            }
            break;
        }
        case 3:
        {
            _signTF4.hidden = NO;
            [_signTF4 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_infoView).offset(81 *SIZE);
                make.top.equalTo(self->_signTF3.mas_bottom).offset(21 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            if (self.consulDic.count && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]] && [self.consulDic[@"rule_type_tags"] count]) {
                
                [_recommendTypeL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(10 *SIZE);
                    make.top.equalTo(self->_signTF4.mas_bottom).offset(31 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
                
                [_recommendTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(80 *SIZE);
                    make.top.equalTo(self->_signTF4.mas_bottom).offset(21 *SIZE);
                    make.width.equalTo(@(258 *SIZE));
                    make.height.equalTo(@(33 *SIZE));
                }];
                
            }else{
                
                [_visitL mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_infoView).offset(10 *SIZE);
                    make.top.equalTo(self->_signTF4.mas_bottom).offset(31 *SIZE);
                    make.width.equalTo(@(70 *SIZE));
                    make.height.equalTo(@(13 *SIZE));
                }];
            }
            break;
        }
        case 4:
        {
            _signTF5.hidden = NO;
            [_signTF5 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_infoView).offset(81 *SIZE);
                make.top.equalTo(self->_signTF4.mas_bottom).offset(21 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
            [_visitL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self->_infoView).offset(10 *SIZE);
                make.top.equalTo(self->_signTF5.mas_bottom).offset(31 *SIZE);
                make.width.equalTo(@(70 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            break;
        }
        default:
            break;
    }
}

- (void)ActionTimeTap:(UITapGestureRecognizer *)sender{
    
//    [[[UIApplication sharedApplication] keyWindow] addSubview:self.dateView];
}

-(void)action_agent
{
    
    [BaseRequest GET:ProjectGetAdvicer_URL parameters:@{@"project_id":_datadic[@"project_id"]} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {

            if ([resposeObject[@"data"][@"rows"] count]) {

                WorkerPickView *view= [[WorkerPickView alloc] initWithFrame:self.view.bounds WithData:resposeObject[@"data"][@"rows"]];
                view.workerPickBlock = ^(NSString *GSMC, NSString *ID, NSString *RYBH, NSString *RYDH, NSString *RYXM, NSString *RYTP) {

                    self->_agentname = [NSString stringWithFormat:@"%@",RYXM];

                    if (GSMC) {
                        
                        self->_agentbtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",GSMC,RYXM,RYDH];
                    }
                    else
                    {
                        self->_agentbtn.content.text = [NSString stringWithFormat:@"%@/%@",RYXM,RYDH];
                    }
                    //                _agentbtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",GSMC,RYXM,RYDH];
                    self->_agentid = [NSString stringWithFormat:@"%@",ID];
                };
                [self.view addSubview:view];
            }else{

                [self showContent:@"该项目暂未设置置业顾问"];
            }
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self showContent:@"获取置业顾问失败"];
    }];
}

- (void)ActionTagNumBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_peopleArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.numBtn.content.text = MC;
                weakself.numBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 1:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {

                weakself.purposeBtn.content.text = MC;
                weakself.purposeBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 2:
        {
            
            break;
        }
        case 3:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_ruleArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.recommendTypeBtn.content.text = MC;
                weakself.recommendTypeBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
        }
        default:
            break;
    }
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
    if (!_numBtn->str) {
        
        [self showContent:@"请选择到访人数"];
        return;
        
    }
    //
    //     if (![_datadic[@"yunsuan_url"] isEqualToString:@""])
    //         {
    //             if (!_agentname.length) {
    //
    //                 [self showContent:@"请选择置业顾问"];
    //                 return;
    //             }
    //         }
    //         else{
    //             if(_adviserTF.textfield.text.length==0)
    //             {
    //                 [self showContent:@"请填写置业顾问"];
    //                 return;
    //             }
    //         }
    
    
    
    NSString *sign;
    if (_num == 0) {
        
        if (_signTF1.textField.text.length) {
            
            sign = _signTF1.textField.text;
        }
    }else if (_num == 1) {
        
        if (_signTF2.textField.text.length) {
            
            sign = [NSString stringWithFormat:@"%@,%@",_signTF1.textField.text,_signTF2.textField.text];
        }
    }else if (_num == 2) {
        
        if (_signTF3.textField.text.length) {
            
            sign = [NSString stringWithFormat:@"%@,%@,%@",_signTF1.textField.text,_signTF2.textField.text,_signTF3.textField.text];
        }
    }else if (_num == 3) {
        
        if (_signTF4.textField.text.length) {
            
            sign = [NSString stringWithFormat:@"%@,%@,%@,%@",_signTF1.textField.text,_signTF2.textField.text,_signTF3.textField.text,_signTF4.textField.text];
        }
    }else{
        
        if (_signTF5.textField.text.length) {
            
            sign = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",_signTF1.textField.text,_signTF2.textField.text,_signTF3.textField.text,_signTF4.textField.text,_signTF5.textField.text];
        }
    }
    
    
    
    
    if (_numBtn->str) {
        
        [_dic setObject:_numBtn->str forKey:@"visit_num"];
    }
    
    if (_purposeBtn->str) {
        
        [_dic setObject:_purposeBtn->str forKey:@"buy_purpose"];
    }
    
    //         if (![_datadic[@"yunsuan_url"] isEqualToString:@""])
    //         {
    if (_agentid) {
        
        [_dic setObject:_agentid forKey:@"property_advicer_wish_id"];
    }
    
    if (_agentname) {
        
        [_dic setObject:_agentname forKey:@"property_advicer_wish"];
    }
    //         }
    //         else{
    //             [_dic setObject:@"0" forKey:@"property_advicer_wish_id"];
    //             [_dic setObject:_adviserTF.textfield.text forKey:@"property_advicer_wish"];
    //         }
    
    
    
    
    
    if (sign) {
        
        [_dic setObject:sign forKey:@"signatory"];
    }
    
    if (_imgUrl1) {
        
        [_dic setObject:[_imgUrl1 componentsJoinedByString:@","] forKey:@"visit_img_url"];
    }
    
    [_dic setObject:[_imgUrl2 componentsJoinedByString:@","] forKey:@"verify_img_url"];
    
    if (_markView.text) {
        
        [_dic setObject:_markView.text forKey:@"comment"];
    }
    
    if (_timeL.text) {
        
        [_dic setObject:_timeL.text forKey:@"visit_time"];
    }
    
    if (_recommendTypeBtn.content.text) {
        
        [_dic setObject:_recommendTypeBtn->str forKey:@"rule_type"];
    }
    
    _confirmBtn.userInteractionEnabled = NO;
    [BaseRequest POST:ConfirmValue_URL parameters:_dic success:^(id resposeObject) {


        if ([resposeObject[@"code"] integerValue] == 200) {

            self->_confirmBtn.userInteractionEnabled = YES;
            for (UIViewController *vc in self.navigationController.viewControllers) {

                if ([vc isKindOfClass:[WorkRecommendVC class]] || [vc isKindOfClass:[TaskVC class]]) {

                    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTask" object:nil];
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else
        {
            [self showContent:resposeObject[@"msg"]];
            self->_confirmBtn.userInteractionEnabled = YES;
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
        self->_confirmBtn.userInteractionEnabled = YES;
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _placeL.hidden = YES;
    }else{
        
        _placeL.hidden = NO;
    }
}


#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _authenColl1) {
        
        return 1;
        //        return _imgArr1.count < 3? _imgArr1.count + 1: 3;
    }else{
        
        return 1;
        //        return _imgArr2.count < 3? _imgArr2.count + 1: 3;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthenCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuthenCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 91 *SIZE)];
    }
    cell.cancelBtn.tag = indexPath.item;
    cell.cancelBtn.hidden = YES;
    //    [cell.cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (collectionView == _authenColl1) {
        
        if (_imgArr1.count) {
            
            if (indexPath.item < _imgArr1.count) {
                
                cell.imageView.image = _imgArr1[indexPath.item];
            }else{
                
                cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
                cell.cancelBtn.hidden = YES;
            }
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
            cell.cancelBtn.hidden = YES;
        }
    }else{
        
        if (_imgArr2.count) {
            
            if (indexPath.item < _imgArr2.count) {
                
                cell.imageView.image = _imgArr2[indexPath.item];
            }else{
                
                cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
                cell.cancelBtn.hidden = YES;
            }
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
            cell.cancelBtn.hidden = YES;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    if (collectionView == _authenColl1) {
        
        _isOne = YES;
    }else{
        
        _isOne = NO;
    }
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
                                                              //                                                              _uploadButton.hidden = NO;
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
                
                [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
            } url:UploadFile_URL parameters:@{@"file_name":@"img"} success:^(id  _Nonnull resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if (self->_isOne) {
                        
                        if (self->_index < self->_imgArr1.count) {
                            
                            [self->_imgArr1 replaceObjectAtIndex:self->_index withObject:self->_image];
                            [self->_imgUrl1 replaceObjectAtIndex:self->_index withObject:resposeObject[@"data"]];
                        }else{
                            
                            [self->_imgArr1 addObject:self->_image];
                            [self->_imgUrl1 addObject:resposeObject[@"data"]];
                        }
                        [self.authenColl1 reloadData];
                    }else{
                        
                        if (self->_index < self->_imgArr2.count) {
                            
                            [self->_imgArr2 replaceObjectAtIndex:self->_index withObject:self->_image];
                            [self->_imgUrl2 replaceObjectAtIndex:self->_index withObject:resposeObject[@"data"]];
                        }else{
                            
                            [self->_imgArr2 addObject:self->_image];
                            [self->_imgUrl2 addObject:resposeObject[@"data"]];
                        }
                        [self.authenColl2 reloadData];
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
            
            [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];

        } url:UploadFile_URL parameters:@{@"file_name":@"img"} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (self->_isOne) {
                    
                    if (self->_index < self->_imgArr1.count) {
                        
                        [self->_imgArr1 replaceObjectAtIndex:self->_index withObject:self->_image];
                        [self->_imgUrl1 replaceObjectAtIndex:self->_index withObject:resposeObject[@"data"]];
                    }else{
                        
                        [self->_imgArr1 addObject:self->_image];
                        [self->_imgUrl1 addObject:resposeObject[@"data"]];
                    }
                    [self.authenColl1 reloadData];
                }else{
                    
                    if (self->_index < self->_imgArr2.count) {
                        
                        [self->_imgArr2 replaceObjectAtIndex:self->_index withObject:self->_image];
                        [self->_imgUrl2 replaceObjectAtIndex:self->_index withObject:resposeObject[@"data"]];
                    }else{
                        
                        [self->_imgArr2 addObject:self->_image];
                        [self->_imgUrl2 addObject:resposeObject[@"data"]];
                    }
                    [self.authenColl2 reloadData];
                }
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }

        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self->_authenColl1 reloadData];
        [self->_authenColl2 reloadData];
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
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(313 *SIZE, 193 *SIZE, 25 *SIZE, 25 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [_infoView addSubview:_addBtn];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 36 *SIZE + i * 54 *SIZE, 70 *SIZE, 12 *SIZE)];
        label.textColor = CLTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                label.text = @"到访人数:";
                [_infoView addSubview:label];
                break;
            }
            case 1:
            {
                label.text = @"置业目的:";
                [_infoView addSubview:label];
                break;
            }
            case 2:
            {
                label.text = @"置业顾问:";
                [_infoView addSubview:label];
                break;
            }
            case 3:
            {
                label.text = @"签字人:";
                [_infoView addSubview:label];
                break;
            }
            case 4:
            {
                label.text = @"到访照片:";
                _visitL = label;
                [_infoView addSubview:_visitL];
                break;
            }
            case 5:
            {
                label.text = @"确认单图片";
                _confirmL = label;
                [_infoView addSubview:_confirmL];
                break;
            }
            case 6:
            {
                label.text = @"推荐类型：";
                _recommendTypeL = label;
                [_infoView addSubview:_recommendTypeL];
                break;
            }
            default:
                break;
        }
        
        if (i < 4) {
            
            DropBtn *btn = [[DropBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
            btn.tag = i;
            [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
            switch (i) {
                case 0:
                {
                    _numBtn = btn;
                    [_infoView addSubview:_numBtn];
                    break;
                }
                case 1:
                {
                    _purposeBtn = btn;
                    [_infoView addSubview:_purposeBtn];
                    break;
                }
                case 2:
                {
                    //                    if (![_datadic[@"yunsuan_url"] isEqualToString:@""]) {
                    _agentbtn = [[DropBtn alloc]initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                    if ([self.consulDic[@"id"] length]) {
                        if (self.consulDic[@"comsulatent_advicer_company"]) {
                            _agentbtn.content.text = [NSString stringWithFormat:@"%@/%@/%@",self.consulDic[@"comsulatent_advicer_company"],self.consulDic[@"comsulatent_advicer"],self.consulDic[@"comsulatent_advicer_tel"]];
                        }
                        else
                        {
                            _agentbtn.content.text = [NSString stringWithFormat:@"%@/%@",self.consulDic[@"comsulatent_advicer"],self.consulDic[@"comsulatent_advicer_tel"]];
                        }
                        
                        
                        _agentname = self.consulDic[@"comsulatent_advicer"];
                        _agentid = self.consulDic[@"id"];
                    }
                    [_agentbtn addTarget:self action:@selector(action_agent) forControlEvents:UIControlEventTouchUpInside];
                    [_infoView addSubview:_agentbtn];
                    //                    }
                    //                    else{
                    //
                    //                        BorderTF *borderTF = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                    //                        _adviserTF = borderTF;
                    //                        [_infoView addSubview:_adviserTF];
                    //                    }
                    break;
                }
                case 3:
                {
                    _recommendTypeBtn = btn;
                    if (self.consulDic && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]] && [self.consulDic[@"rule_type_tags"] count]) {
                        
                        _recommendTypeBtn.content.text = [NSString stringWithFormat:@"%@",self.consulDic[@"rule_type_tags"][0][@"tag_name"]];
                        _recommendTypeBtn->str = [NSString stringWithFormat:@"%@",self.consulDic[@"rule_type_tags"][0][@"tag_id"]];
                    }else{
                        
                        
                    }
                    [_infoView addSubview:_recommendTypeBtn];
                    break;
                }
                default:
                    break;
            }
        }
        
        if (i < 5) {
            
            BorderTextField *borderTF = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, 189 *SIZE, 258 *SIZE, 33 *SIZE)];
            switch (i) {
                case 0:
                {
                    borderTF.frame = CGRectMake(80 *SIZE, 189 *SIZE, 217 *SIZE, 33 *SIZE);
                    _signTF1 = borderTF;
                    [_infoView addSubview:_signTF1];
                    break;
                }
                case 1:
                {
                    _signTF2 = borderTF;
                    _signTF2.hidden = YES;
                    [_infoView addSubview:_signTF2];
                    break;
                }
                case 2:
                {
                    _signTF3 = borderTF;
                    _signTF3.hidden = YES;
                    [_infoView addSubview:_signTF3];
                    break;
                }
                case 3:
                {
                    _signTF4 = borderTF;
                    _signTF4.hidden = YES;
                    [_infoView addSubview:_signTF4];
                    break;
                }
                case 4:
                {
                    _signTF5 = borderTF;
                    _signTF5.hidden = YES;
                    [_infoView addSubview:_signTF5];
                    break;
                }
                default:
                    break;
            }
        }
    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _authenColl1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl1.backgroundColor = [UIColor whiteColor];
    _authenColl1.delegate = self;
    _authenColl1.dataSource = self;
    
    [_authenColl1 registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [_infoView addSubview:_authenColl1];
    
    _authenColl2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl2.backgroundColor = [UIColor whiteColor];
    _authenColl2.delegate = self;
    _authenColl2.dataSource = self;
    
    [_authenColl2 registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [_infoView addSubview:_authenColl2];
    
    _markView = [[UITextView alloc] init];
    _markView.delegate = self;
    _markView.contentInset = UIEdgeInsetsMake(10 *SIZE, 12 *SIZE, 12 *SIZE, 12 *SIZE);
    [_scrolleView addSubview:_markView];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(6 *SIZE, 7 *SIZE, 40 *SIZE, 11 *SIZE)];
    _placeL.textColor = CLContentLabColor;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"备注...";
    [_markView addSubview:_placeL];
    
    _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 50 *SIZE)];
    _timeView.backgroundColor = [UIColor whiteColor];
    [_scrolleView addSubview:_timeView];
    
    UILabel *arriveL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 70 *SIZE, 13 *SIZE)];
    arriveL.textColor = CLTitleLabColor;
    arriveL.font = [UIFont systemFontOfSize:13 *SIZE];
    arriveL.text = @"到访时间:";
    [_timeView addSubview:arriveL];
    
    _timeL = [[UILabel alloc] initWithFrame:CGRectMake(75 *SIZE, 20 *SIZE, 200 *SIZE, 12 *SIZE)];
    _timeL.textColor = CLContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    [_timeView addSubview:_timeL];
    _date = [NSDate date];
    _timeL.text = [_formatter stringFromDate:_date];
    
    _timeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTimeTap:)];
    [_timeView addGestureRecognizer:tap];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setBackgroundColor:CLBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrolleView addSubview:_confirmBtn];
    
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
    }];
    
    [_signTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(80 *SIZE);
        make.top.equalTo(self->_infoView).offset(189 *SIZE);
        make.width.equalTo(@(217 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    if (self.consulDic.count && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]] && [self.consulDic[@"rule_type_tags"] count]) {
        
        [_recommendTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_infoView).offset(10 *SIZE);
            make.top.equalTo(self->_signTF1.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
        
        [_recommendTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_infoView).offset(80 *SIZE);
            make.top.equalTo(self->_signTF1.mas_bottom).offset(21 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
        [_visitL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_infoView).offset(10 *SIZE);
            make.top.equalTo(self->_recommendTypeBtn.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
    }else{
        
        _recommendTypeL.hidden = YES;
        _recommendTypeBtn.hidden = YES;
        [_visitL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self->_infoView).offset(10 *SIZE);
            make.top.equalTo(self->_signTF1.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
    }
    
    
    [_authenColl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(0 *SIZE);
        make.top.equalTo(self->_visitL.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(91 *SIZE));
    }];
    
    [_confirmL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_authenColl1.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_authenColl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_infoView).offset(0 *SIZE);
        make.top.equalTo(self->_confirmL.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(91 *SIZE));
        make.bottom.equalTo(self->_infoView.mas_bottom).offset(-32 *SIZE);
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrolleView).offset(0 *SIZE);
        make.top.equalTo(self->_infoView.mas_bottom).offset(6 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(117 *SIZE));
    }];
    
    [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrolleView).offset(0 *SIZE);
        make.top.equalTo(self->_markView.mas_bottom).offset(3 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(50 *SIZE));
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrolleView).offset(22 *SIZE);
        make.top.equalTo(self->_timeView.mas_bottom).offset(45 *SIZE);
        make.right.equalTo(self->_scrolleView).offset(-22 *SIZE);
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(self->_scrolleView.mas_bottom).offset(-40 *SIZE);
    }];
}

- (DateChooseView *)dateView{

    if (!_dateView) {

        _dateView = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        __weak __typeof(&*self)weakSelf = self;
        _dateView.dateblock = ^(NSDate *date) {

            self->_date = date;
            weakSelf.timeL.text = [weakSelf.formatter stringFromDate:date];
        };
    }
    return _dateView;
}

@end
