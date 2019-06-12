//
//  PersonalVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "PersonalVC.h"

#import "ChangeNameVC.h"
#import "PersonalIntroVC.h"

#import "DateChooseView.h"
//#import "AddressChooseView3.h"
#import "AdressChooseView.h"

#import "TitleContentRightBaseCell.h"
#import "PersonalHeader.h"

@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    
    NSData *_imageData;
    NSString *_name;
    NSString *_sex;
    NSString *_birth;
    NSString *_pro;
    NSString *_city;
    NSString *_area;
    NSString *_intro;
    
    UIImagePickerController *_imagePickerController; /**< 相册拾取器 */
    NSDateFormatter *_formatter;
}
@property (nonatomic, strong) UITableView *personTable;

@property (nonatomic, strong) UIButton *exitBtn;

@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;

}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    
    _titleArr = @[@"云算号：",@"手机号：",@"姓名：",@"性别：",@"生日：",@"所在地：",@"个人说明："];
    
    NSString *adreess = @"";
    
    if ([UserInfoModel defaultModel].province) {
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
        
        NSError *err;
        NSArray *provice = [NSJSONSerialization JSONObjectWithData:JSONData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];
        for (NSUInteger i = 0; i < provice.count; i++) {
            
            if([provice[i][@"code"] integerValue] == [[UserInfoModel defaultModel].province integerValue]){
                
                NSArray *city = provice[i][@"city"];
                for (NSUInteger j = 0; j < city.count; j++) {
                    
                    if([city[j][@"code"] integerValue] == [[UserInfoModel defaultModel].city integerValue]){
                        
                        NSArray *area = city[j][@"district"];
                        
                        for (NSUInteger k = 0; k < area.count; k++) {
                            
                            if([area[k][@"code"] integerValue] == [[UserInfoModel defaultModel].district integerValue]){
                                
                                adreess = [NSString stringWithFormat:@"%@/%@/%@",provice[i][@"name"],city[0][@"name"],area[k][@"name"]];
                            }
                        }
                    }
                }
            }
        }
//        adreess =[NSString stringWithFormat:@"%@/%@/%@",[UserInfoModel defaultModel].province,[UserInfoModel defaultModel].city,[UserInfoModel defaultModel].district];
    }else{
        
        adreess = @"";
    }

    _contentArr = [NSMutableArray arrayWithArray:@[[UserInfoModel defaultModel].account,[UserInfoModel defaultModel].tel,[UserInfoModel defaultModel].name,[[UserInfoModel defaultModel].sex integerValue] == 1?@"男":[[UserInfoModel defaultModel].sex integerValue] == 2?@"女":@"",[UserInfoModel defaultModel].birth.length?[UserInfoModel defaultModel].birth:@"",adreess,[UserInfoModel defaultModel].slef_desc.length?[UserInfoModel defaultModel].slef_desc:@""]];
}


#pragma mark -- action

- (void)ActionExitBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    
    if (_name) {
        
        [dic setObject:_name forKey:@"name"];
    }
    if (_sex) {
        
        [dic setObject:_sex forKey:@"sex"];
    }
    if (_birth) {
        
        [dic setObject:_birth forKey:@"birth"];
    }
    
    if (_pro) {
        
        [dic setObject:_pro forKey:@"province"];
        [dic setObject:_city forKey:@"city"];
        [dic setObject:_area forKey:@"district"];
    }
    if (_intro) {
        
        [dic setObject:_intro forKey:@"slef_desc"];
    }
    
    if (_imageData) {
        
        [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:self->_imageData name:@"headimg" fileName:@"headimg.jpg" mimeType:@"image/jpg"];
        } url:UploadFile_URL parameters:@{
                                          @"file_name":@"headimg"
                                          }
        success:^(id  _Nonnull resposeObject) {
                                              
            if ([resposeObject[@"code"] integerValue] == 200) {
                                                  
                NSDictionary *dic = @{@"head_img":resposeObject[@"data"]};
                [BaseRequest POST:UserPersonalChangeAgentInfo_URL parameters:dic success:^(id resposeObject) {
                
                    if ([resposeObject[@"code"] integerValue] == 200) {
                                                          
                        [UserInfoModel defaultModel].head_img = dic[@"head_img"];
                        if (self->_name) {
                            
                            [UserInfoModel defaultModel].name = self->_name;
                        }
                        if (self->_sex) {
                            
                            [UserInfoModel defaultModel].sex = self->_sex;
                        }
                        if (self->_birth) {
                            
                            [UserInfoModel defaultModel].birth = self->_birth;
                        }
                        
                        if (self->_pro) {
                            
                            [UserInfoModel defaultModel].province = self->_pro;
                            [UserInfoModel defaultModel].city = self->_city;
                            [UserInfoModel defaultModel].district = self->_area;
                        }
                        if (self->_intro) {
                            
                            [UserInfoModel defaultModel].slef_desc = self->_intro;
                        }
                        [UserModelArchiver infoArchive];
                        if (self.personalVCBlock) {
                                                              
                            self.personalVCBlock();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                                                          
                        [self showContent:resposeObject[@"msg"]];
                     }
                } failure:^(NSError *error) {
                
                    [self showContent:@"网络错误"];
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        if (dic.count) {
            
            [BaseRequest POST:UserPersonalChangeAgentInfo_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if (self->_name) {
                        
                        [UserInfoModel defaultModel].name = self->_name;
                    }
                    if (self->_sex) {
                        
                        [UserInfoModel defaultModel].sex = self->_sex;
                    }
                    if (self->_birth) {
                        
                        [UserInfoModel defaultModel].birth = self->_birth;
                    }
                    
                    if (self->_pro) {
                        
                        [UserInfoModel defaultModel].province = self->_pro;
                        [UserInfoModel defaultModel].city = self->_city;
                        [UserInfoModel defaultModel].district = self->_area;
                    }
                    if (self->_intro) {
                        
                        [UserInfoModel defaultModel].slef_desc = self->_intro;
                    }
                    if (self.personalVCBlock) {
                        
                        self.personalVCBlock();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                [self showContent:@"网络错误"];
            }];
        }else{
        
            [self showContent:@"您未修改任何个人信息"];
        }
    }
}


#pragma mark -- 选择头像

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
        //        NSLog(@"当前设备不支持拍照");
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
    
    NSLog(@"%@",info);
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            UIImage *originalImage = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
            [self updateheadimgbyimg:originalImage];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
        UIImage *originalImage = [self fixOrientation:info[UIImagePickerControllerEditedImage]];
        [self updateheadimgbyimg:originalImage];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateheadimgbyimg:(UIImage *)img
{
    NSData *data = [self resetSizeOfImageData:img maxSize:150];
    
    _imageData = data;
    [_personTable reloadData];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    PersonalHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PersonalHeader"];
    if (!header) {
        
        header = [[PersonalHeader alloc] initWithReuseIdentifier:@"PersonalHeader"];
    }
    
    if (_imageData) {
        
        header.headerImg.image = [UIImage imageWithData:_imageData];
    }else{
        
        [header.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]] placeholderImage:IMAGE_WITH_NAME(@"def_head") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                header.headerImg.image = IMAGE_WITH_NAME(@"def_head");
            }
        }];;
    }
    
    header.personalHeaderBlock = ^{
      
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传头像"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            [self selectPhotoAlbumPhotos];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            [self takingPictures];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        }]];
        [self presentViewController:alertController animated:YES completion:^{
        
        }];
    };
    
    return header;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TitleContentRightBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentRightBaseCell"];
    if (!cell) {
        
        cell = [[TitleContentRightBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalTableCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
    cell.contentL.text = _contentArr[indexPath.row];
    if (indexPath.row >1) {
        
        cell.rightImg.hidden = NO;
    }else{
        
        cell.rightImg.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        
        ChangeNameVC *nextVC = [[ChangeNameVC alloc] initWithName:self->_contentArr[2]];
        nextVC.changeNameVCBlock = ^(NSString *str) {
            
            self->_name = str;
            [self->_contentArr replaceObjectAtIndex:2 withObject:self->_name];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 3){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            self->_sex = @"1";
            [self->_contentArr replaceObjectAtIndex:3 withObject:@"男"];
            
            [tableView reloadData];
        }];
        
        UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self->_sex = @"2";
            [self->_contentArr replaceObjectAtIndex:3 withObject:@"女"];
            
            [tableView reloadData];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:male];
        [alert addAction:female];
        [alert addAction:cancel];
        [self.navigationController presentViewController:alert animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 4){
        
        DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        view.dateblock = ^(NSDate *date) {
            
            self->_birth = [self->_formatter stringFromDate:date];
            [self->_contentArr replaceObjectAtIndex:4 withObject:self->_birth];
            
            [tableView reloadData];
        };
        [self.view addSubview:view];
    }else if (indexPath.row == 5){

        AdressChooseView *addressChooseView = [[AdressChooseView alloc] initWithFrame:self.view.bounds withdata:@[]];
//        WS(weakself);
        addressChooseView.selectedBlock = ^(NSString *province, NSString *city, NSString *area, NSString *proviceid, NSString *cityid, NSString *areaid) {

            
            NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"region" ofType:@"json"]];
            
            NSError *err;
            NSArray *proArr = [NSJSONSerialization JSONObjectWithData:JSONData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&err];
            NSString *pro = [cityid substringToIndex:2];
            pro = [NSString stringWithFormat:@"%@0000",pro];
            
            self->_pro = pro;
            self->_city = cityid;
            self->_area = areaid;
            
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
            [self->_contentArr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%@/%@/%@",proName,city,area]];
            [tableView reloadData];
        };
        [self.view addSubview:addressChooseView];
    }else if (indexPath.row == 6){
        
        PersonalIntroVC *nextVC = [[PersonalIntroVC alloc] initWithIntro:self->_contentArr[6]];
        nextVC.personalIntroVCBlock = ^(NSString *str) {
            
            self->_intro = str;
            [self->_contentArr replaceObjectAtIndex:6 withObject:self->_intro];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"个人信息";
    
    
    _personTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 50 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _personTable.sectionHeaderHeight = UITableViewAutomaticDimension;
    _personTable.estimatedSectionHeaderHeight = 100 *SIZE;
    _personTable.backgroundColor = self.view.backgroundColor;
    _personTable.delegate = self;
    _personTable.dataSource = self;
    _personTable.bounces = NO;
    _personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_personTable];
    
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _exitBtn.frame = CGRectMake(0, SCREEN_Height - 50 *SIZE - TAB_BAR_MORE, SCREEN_Width, 50 *SIZE + TAB_BAR_MORE);
    _exitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_exitBtn addTarget:self action:@selector(ActionExitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_exitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:CLBlueBtnColor];
//    [_exitBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    [self.view addSubview:_exitBtn];
}

@end
