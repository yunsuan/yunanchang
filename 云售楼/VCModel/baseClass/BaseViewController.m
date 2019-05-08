//
//  BaseViewController.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CLBackColor;//[UIColor whiteColor];
    [self initialBaseViewInterface];
}

#pragma mark - init
- (void)initialBaseViewInterface {
    
//    self.view.backgroundColor = CLBackColor;
    [self.view addSubview:self.navBackgroundView];
    
    [self.navBackgroundView addSubview:self.titleLabel];
    [self.navBackgroundView addSubview:self.leftButton];
    [self.navBackgroundView addSubview:self.rightBtn];
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//提示框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1{
    UIAlertController *alert_forbidden = [UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    [alert_forbidden addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert_forbidden animated:YES completion:nil];
}

- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithDefaultBlack:(void(^)(void))defaultBlack{
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        defaultBlack();
    }];
    [alert addAction:alert2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

//弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelBlack();
    }];
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        defaultBlack();
    }];
    [alert addAction:alert1];
    [alert addAction:alert2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


/**
 *  检查输入的手机号正确与否
 */
- (BOOL)checkTel:(NSString *)str {
    
    NSString *regex = @"^((13[0-9])|(17[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(19[0-9])|16[0-9])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (void)showContent:(NSString *)str {
    
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.mode = MBProgressHUDModeText;
    //    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7f];
    //    hud.label.text= str;
    //    hud.label.textColor = [UIColor whiteColor];
    //    hud.margin = 10.f;
    //    [hud setOffset:CGPointMake(0, 10.f*SIZE)];
    //    //    hud.yOffset = 10.f * SIZE;
    //    hud.removeFromSuperViewOnHide = YES;
    //    //    [hud hide:YES afterDelay:1.5];
    //    [hud hideAnimated:YES afterDelay:1.5];
}

//判断字符串为空
- (BOOL)isEmpty:(NSString *)str{
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

//对图片压缩
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

//调整图片方向
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, (CGFloat)M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, (CGFloat) M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, (CGFloat)-M_PI_2);
            break;
        default:
            break;
        case UIImageOrientationUp:break;
        case UIImageOrientationUpMirrored:break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, (size_t) aImage.size.width,(size_t) aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (UIView *)navBackgroundView {
    
    if (!_navBackgroundView) {
        _navBackgroundView = [[UIView alloc] init];
        
        _navBackgroundView.frame = CGRectMake(0, 0, SCREEN_Width, NAVIGATION_BAR_HEIGHT);
        
        _navBackgroundView.backgroundColor = [UIColor whiteColor];
        
//    _navImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, NAVIGATION_BAR_HEIGHT)];
//        _navImg.image = [UIImage imageNamed:@"titlelbar.png"];
//        [_navBackgroundView addSubview:_navImg];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - SIZE, SCREEN_Width, SIZE)];
        _line.backgroundColor = CLLineColor;
        [_navBackgroundView addSubview:_line];
        
    }
    return _navBackgroundView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.center = CGPointMake(SCREEN_Width / 2, STATUS_BAR_HEIGHT+22 );
        _titleLabel.bounds = CGRectMake(0, 0, 180 * SIZE, 44);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.textColor = CLWhiteColor;
        _titleLabel.font = [UIFont systemFontOfSize:17 * SIZE];
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _maskButton.frame = CGRectMake(0, 20 * SIZE, 60 * SIZE, 44);
        _leftButton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 60 * SIZE, 44);
        [_leftButton setBackgroundColor:[UIColor clearColor]];
        [_leftButton setImage:[UIImage imageNamed:@"leftarrow"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(ActionMaskBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.center = CGPointMake(SCREEN_Width - 25 * SIZE, STATUS_BAR_HEIGHT+20);
        _rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        //        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 * SIZE];
        _rightBtn.hidden = YES;
    }
    return _rightBtn;
}

@end
