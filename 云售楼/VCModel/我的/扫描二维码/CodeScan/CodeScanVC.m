//
//  CodeScanVC.m
//  云售楼
//
//  Created by 谷治墙 on 2019/9/12.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CodeScanVC.h"

#import <AVFoundation/AVFoundation.h>
#import "CodeScanHeader.h"
#import "CodeScanTools.h"
#import "CustomTools.h"

@interface CodeScanVC ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

/**输入输出中间桥梁(会话)*/
@property (strong, nonatomic) AVCaptureSession *session;
/**计时器*/
@property (strong, nonatomic) CADisplayLink *link;
/**实际有效扫描区域的背景图(亦或者自己设置一个边框)*/
@property (strong, nonatomic) UIImageView *bgImg;
/**有效扫描区域循环往返的一条线（这里用的是一个背景图）*/
@property (strong, nonatomic) UIImageView *scrollLine;
/**扫码有效区域外自加的文字提示*/
@property (strong, nonatomic) UILabel *tip;
/**用于记录scrollLine的上下循环状态*/
@property (assign, nonatomic) BOOL up;
/** 遮盖图层 */
@property (nonatomic,weak) CAShapeLayer *shapeLayer;
/** 遮盖视图 */
@property (nonatomic,strong) UIView *maskView;
/** 记录闪光灯点击 */
@property (nonatomic,assign) NSInteger flashIndex;
/** 切换按钮 */
@property (nonatomic,strong) UIButton *switchBtn;
/** 手动输入框 */
@property (nonatomic,strong) UITextField *codeNumText;
@property (nonatomic,strong) UIView *codeTextView;

//@property (nonatomic, strong) UIButton *<#class#>;

@end

@implementation CodeScanVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.session startRunning];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"扫一扫";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitleColor:CLTitleLabColor forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitle:@"相册" forState:UIControlStateNormal];
    
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    _up = YES;
    _flashIndex=0;

    [self session];
    [self setScanView];
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    [self photoClick];
}

- (void)setScanView{
    
    //添加一个可见的扫描有效区域的框（这里直接是设置一个背景图片）
    [self.view addSubview:self.bgImg];
    //添加遮罩图层
    [self.view addSubview:self.maskView];
    //添加其他有效控件
    [self.view addSubview:self.tip];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_flashIndex==0) {
        _flashIndex=1;
        [CodeScanTools openLight:YES];
    }else{
        _flashIndex=0;
        [CodeScanTools openLight:NO];
    }
}

#pragma mark 相机调用
- (AVCaptureSession *)session {
    if (!_session) {
        //1.获取输入设备（摄像头）
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        //2.根据输入设备创建输入对象
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
        if (input == nil) {
            return nil;
        }
        
        //3.创建元数据的输出对象
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        //4.设置代理监听输出对象输出的数据,在主线程中刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 5.创建会话(桥梁)
        AVCaptureSession *session = [[AVCaptureSession alloc]init];
        //实现高质量的输出和摄像，默认值为AVCaptureSessionPresetHigh，可以不写
        [session setSessionPreset:AVCaptureSessionPreset1280x720];
        // 6.添加输入和输出到会话中（判断session是否已满）
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        
        // 7.告诉输出对象, 需要输出什么样的数据 (二维码还是条形码等) 要先创建会话才能设置
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode];
        
        // 8.创建预览图层
        AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
        [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        previewLayer.frame = self.view.bounds;
        [self.view.layer insertSublayer:previewLayer atIndex:0];
        //        [previewLayer addAnimation:[ScanFunction zoomOutAnimation] forKey:nil];
        
    //9.设置有效扫描区域，默认整个图层(很特别，1、要除以屏幕宽高比例，2、其中x和y、width和height分别互换位置)
        CGRect rect = CGRectMake((NAVIGATION_BAR_HEIGHT + 100 *SIZE)/SCREEN_HEIGHT, 30 *SIZE/SCREEN_WIDTH, 300 *SIZE/SCREEN_HEIGHT, 300 *SIZE/SCREEN_WIDTH);
        //        CGRect rect = CGRectMake(0, 0, 0, 0);
        output.rectOfInterest = rect;
        
        //10.设置中空区域，即有效扫描区域(中间扫描区域透明度比周边要低的效果)绘制黑色底框 中空正方形
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [self scanPath].CGPath;
        self.maskView.layer.mask = shapeLayer;
        _shapeLayer=shapeLayer;
        
        _session = session;
    }
    return _session;
}

#pragma mark 扫描区域动画类型转换
- (void)setScanTypeTransform:(ScanAnimationTransform)transformType
{
    [_shapeLayer addAnimation:[self animationType:transformType] forKey:@"animate"];
    _maskView.layer.mask = _shapeLayer;
}

#pragma mark 动画部分
- (CAKeyframeAnimation *)animationType:(ScanAnimationTransform)animationType{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    if (animationType==ScanToInput) {//从扫描到输入
        keyframeAnimation.values = @[(__bridge id)[self scanPath].CGPath,
                                     (__bridge id)[self inputPath].CGPath];
    }else{//从输入到扫描
        keyframeAnimation.values = @[(__bridge id)[self inputPath].CGPath,
                                     (__bridge id)[self scanPath].CGPath];
    }
    //    keyframeAnimation.keyTimes = @[@(0.0), @(0.3), @(0.5), @(0.75), @(0.9)];
    keyframeAnimation.fillMode = kCAFillModeForwards;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.duration = 0.5;
    return keyframeAnimation;
}

- (UIBezierPath *)scanPath{
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(30 *SIZE, 100 *SIZE, 300 *SIZE, 300 *SIZE) cornerRadius:1] bezierPathByReversingPath]];
    return rectPath;
}

- (UIBezierPath *)inputPath{
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(30 *SIZE, NAVIGATION_BAR_HEIGHT + 100 *SIZE, 300 *SIZE, 300 *SIZE) cornerRadius:1] bezierPathByReversingPath]];
    return rectPath;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self scanCodeResult:textField.text];
    //    [textField resignFirstResponder];
    return YES;
}



#pragma mark 扫描到数据时会调用
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        [CodeScanTools openShake:YES Sound:YES];
        // 1.停止扫描
        [self.session stopRunning];
        // 2.停止冲击波
        [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        // 3.取出扫描到得数据
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        if (obj) {
            //二维码信息回传
            //NSLog(@">>>>>>>>>>>>%@>>>>",[obj stringValue]);
            [self scanCodeResult:[obj stringValue]];
            
        }
    }
}

#pragma mark 扫描/输入二维码/条形码结果
- (void)scanCodeResult:(NSString *)scanCode{
//    [CustomTools showAlert:[NSString stringWithFormat:@"扫描(输入)结果为：%@",scanCode] Target:self];
    NSString *str = [self base64DecodeString:scanCode];
    NSLog(@"%@",str);
    [BaseRequest GET:ClientNeedInfo_URL parameters:@{@"client_id":str} success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.codeScanVCBlock) {
                
                self.codeScanVCBlock(str);
            }
            [self.navigationController popViewControllerAnimated:NO];
        }else{
            
            [self showContent:@"你不能处理该信息"];
            [self.session startRunning];
        }
    } failure:^(NSError * _Nonnull error) {
        
        [self showContent:@"你不能处理该信息"];
        [self.session startRunning];
    }];
}

#pragma mark - 开灯或关灯
- (void)flashClick{
    
    if (_flashIndex==0) {
        _flashIndex=1;
        [CodeScanTools openLight:YES];
    }else{
        _flashIndex=0;
        [CodeScanTools openLight:NO];
    }
}

#pragma mark 调用相册
- (void)photoClick{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        [CustomTools showAlert:@"不支持访问相册" Target:self];
    }
}

#pragma mark - - - UIImagePickerControllerDelegate相册回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >= 1){
        CIQRCodeFeature *feature = [features firstObject];
        //        NSLog(@"%@>>>>>",feature.messageString);
        [self scanCodeResult:feature.messageString];
    }else{
        [CustomTools showAlert:@"无法识别图中二维码" Target:self];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                              context:nil
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count >= 1){
        CIQRCodeFeature *feature = [features firstObject];
        //        NSLog(@"%@>>>>>",feature.messageString);
        [self scanCodeResult:feature.messageString];
    }else{
        [CustomTools showAlert:@"无法识别图中二维码" Target:self];
    }
}


#pragma mark - 线条运动的动画
//- (void)LineAnimation {
//    if (_up == YES) {
//        CGFloat y = self.scrollLine.frame.origin.y;
//        y += 2;
//        [self.scrollLine setY:y];
//        if (y >= (barBgImgY+barBgImgHeight-kScrollLineHeight)) {
//            _up = NO;
//        }
//    }else{
//        CGFloat y = self.scrollLine.frame.origin.y;
//        y -= 2;
//        [self.scrollLine setY:y];
//        if (y <= barBgImgY) {
//            _up = YES;
//        }
//    }
//}

#pragma mark 基础视图
- (UIImageView *)bgImg {
    if (!_bgImg) {
        
        _bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(30 *SIZE, NAVIGATION_BAR_HEIGHT + 100 *SIZE, 300 *SIZE, 300 *SIZE)];
        _bgImg.image = [UIImage imageNamed:bgImg_img];
    }
    return _bgImg;
}

//- (UIImageView *)scrollLine {
//    if (!_scrollLine) {
//        _scrollLine = [[UIImageView alloc]initWithFrame:CGRectMake(barBgImgX, barBgImgY, barBgImgWidth, kScrollLineHeight)];
//        _scrollLine.image = [UIImage imageNamed:Line_img];
//    }
//    return _scrollLine;
//}

- (UILabel *)tip {
    if (!_tip) {
        _tip = [[UILabel alloc]initWithFrame:CGRectMake(barBgImgX, NAVIGATION_BAR_HEIGHT + 430 *SIZE, barBgImgWidth, barTipHeight)];
        _tip.text = @"二维码扫描";
        _tip.numberOfLines = 0;
        _tip.textColor = [UIColor whiteColor];
        _tip.textAlignment = NSTextAlignmentCenter;
        _tip.font = [UIFont systemFontOfSize:13];
    }
    return _tip;
}


//- (CADisplayLink *)link {
//    if (!_link) {
//        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(LineAnimation)];
//    }
//    return _link;
//}

- (UIView *)maskView{
    if (!_maskView) {
        
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kBgAlpha];
    }
    return _maskView;
}



#pragma mark 前后台切换
- (void)appWillEnterBackground{
    [self.session stopRunning];
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)appWillEnterPlayGround{
    [self.session startRunning];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
