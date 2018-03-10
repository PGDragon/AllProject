//
//  ViewController.m
//  lianxiExtend
//
//  Created by ios on 18/2/26.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ViewController.h"
#import <HMScannerController.h>

@interface ViewController ()<LKNotificationDelegate>

@property (nonatomic,strong) UILabel *lable;
@property (nonatomic,strong) DataModel *dataModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 100) buttonTitle:@"测试1" normalBGColor:[UIColor greenColor] selectBGColor:nil normalColor:[UIColor whiteColor] selectColor:nil buttonFont:[UIFont systemFontOfSize:15] cornerRadius:3 doneBlock:^(UIButton *button) {
        ceshi1VC *vc = [[ceshi1VC alloc]init];
        vc.popUpViewSize = CGSizeMake(100, 100);
        [self showPopUpViewController:vc animationType:DDPopUpAnimationTypeFade];
    }];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(button1.fxl_right+10, 100, 100, 100) buttonTitle:@"测试2" normalBGColor:[UIColor greenColor] selectBGColor:nil normalColor:[UIColor whiteColor] selectColor:nil buttonFont:[UIFont systemFontOfSize:15] cornerRadius:3 doneBlock:^(UIButton *button) {
        ceshi1VC *vc = [[ceshi1VC alloc]init];
        vc.popUpViewSize = CGSizeMake(SCREEN_WIDTH*0.8, SCREEN_HEIGHT*0.8);
        [self showPopUpViewController:vc animationType:DDPopUpAnimationTypeNone];
    }];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(button2.fxl_right+10, 100, 100, 100) buttonTitle:@"测试3" normalBGColor:[UIColor greenColor] selectBGColor:nil normalColor:[UIColor whiteColor] selectColor:nil buttonFont:[UIFont systemFontOfSize:15] cornerRadius:3 doneBlock:^(UIButton *button) {
        ceshi1VC *vc = [[ceshi1VC alloc]init];
        vc.popUpViewSize = CGSizeMake(100, 100);
        [self showPopUpViewController:vc animationType:DDPopUpAnimationTypeFade dismissWhenTouchBackground:YES];
    }];
    [self.view addSubview:button3];
    
    UIImageView *pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, button1.fxl_bottom + 10, 100, 100) bgColor:[UIColor cyanColor] cornerRadius:3 image:@"美女.jpg"];
    [self.view addSubview:pictureImageView];
    pictureImageView.userInteractionEnabled = YES;
    FXLWeakSelf(self);
    [pictureImageView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        NSLog(@"我是美女中字符串%@",gestureId);
        ceshi2VC *showPicVc = [[ceshi2VC alloc] init];
        showPicVc.popUpViewSize = CGSizeMake(100, 100);
        [weakself showPopUpViewController:showPicVc animationType:DDPopUpAnimationTypeFade dismissWhenTouchBackground:YES];
    }];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(pictureImageView.fxl_right + 10, button1.fxl_bottom + 10, 100, 100) bgColor:[UIColor redColor] cornerRadius:3];
    view.userInteractionEnabled = YES;
    view.tag = 512;
    [self.view addSubview:view];
    [view addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        NSLog(@"我是浮层中字符串%@",gestureId);
        MBProgressHUD *HUD = [MBProgressHUD defaultMBProgress:nil];
        HUD.color = [UIColor lightGrayColor];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD hide:YES];
        });
    } tapGestureId:@""];
    
    UITextView *textView = [[UITextView alloc] initWithTextViewFrame:CGRectMake(10, pictureImageView.fxl_bottom+10, SCREEN_WIDTH-20, 30) text:nil font:18 color:[UIColor whiteColor] bgColor:[UIColor orangeColor] placeHolder:@"我是占位文字" placeColor:[UIColor blackColor]];
//    [textView FXL_addImage:[UIImage imageNamed:@"美女.jpg"]];
    [self.view addSubview:textView];
    
    UILabel *lable = [[UILabel alloc]initWithLableFrame:CGRectMake(10, textView.fxl_bottom+10, 100, 100) text:@"我是一个lable" textColor:[UIColor blackColor] bgColor:[UIColor yellowColor] font:14 bold:NO cornerRadius:0];
    lable.userInteractionEnabled = YES;
    lable.numberOfLines = 0;
    [self.view addSubview:lable];
    [lable addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        NSLog(@"我是lable中字符串%@",gestureId);
    }];
    
    UITextField *field = [[UITextField alloc]initWithFieldFrame:CGRectMake(10, lable.fxl_bottom + 10, SCREEN_WIDTH-20, 50) text:nil font:15 color:[UIColor redColor] bgColor:[UIColor grayColor] placeHolder:@"我是一个field" placeHolderfont:15 placeColor:[UIColor blackColor]];
    [self.view addSubview:field];
    
    FXLWeakSelf(lable);
    FXLWeakSelf(textView);
    FXLWeakSelf(field);
    [textView FXL_autoHeightWithMaxHeight:200 textViewHeightDidChanged:^(CGFloat currentTextViewHeight) {
        //        NSLog(@"高度已经改变了%.f",currentTextViewHeight);
        dispatch_async(dispatch_get_main_queue(), ^{
            weaklable.fxl_y = weaktextView.fxl_bottom +10;
            weakfield.fxl_y = weaklable.fxl_bottom + 10;
        });
    }];
    
    UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake(10, field.fxl_bottom+20, 50, 50) buttonTitle:nil normalBGColor:[UIColor whiteColor] selectBGColor:nil normalColor:nil selectColor:nil buttonFont:nil cornerRadius:0 doneBlock:^(UIButton *button) {
        HMScannerController *scanner = [HMScannerController scannerWithCardName:@"http://wm0530.com" avatar:nil completion:^(NSString *stringValue) {
            lable.text = stringValue;
        }];
        [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
        [weakself showDetailViewController:scanner sender:nil];
    }];
    [button4 setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
    [self.view addSubview:button4];
}


- (void)onNavigationBarTouchUpInside:(LKNotificationBar *)navigationBar{
    [navigationBar hideWithAnimated: YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
