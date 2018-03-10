//
//  ceshi2VC.m
//  lianxiExtend
//
//  Created by ios on 18/2/26.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ceshi2VC.h"

@interface ceshi2VC ()

@property (nonatomic,assign) int flag;

@end

@implementation ceshi2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    NSArray *imgArr = @[@"美女.jpg",@"美女2.jpg",@"美女3.jpg"];
    imageView.userInteractionEnabled = YES;
    [imageView setImage:[UIImage imageNamed:imgArr[_flag?0:_flag]]];
    [self.view addSubview:imageView];
    FXLWeakSelf(imageView);
    [imageView addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        if (_flag > 1) {
            _flag = -1;
        }
        [weakimageView setImage:[UIImage imageNamed:imgArr[++_flag]]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
