//
//  UIImageView+FxlExtension.h
//  paobanglang
//
//  Created by ios on 18/1/31.
//  Copyright © 2018年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+FxlExtensionImg.h"

@interface UIImageView (FxlExtension)

/**
 *  圆形
 */
- (void)FXL_setCircleHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName;

/**
 *  圆形并且有边框
 */
- (void)FXL_setCircleBorderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**
 *  方形或者圆角型
 */
- (void)FXL_setRectHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName cornerRadius:(CGFloat)cornerRadius;

/**
 *  六边形
 */
- (void)FXL_setSixSideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName imageViewWH:(CGFloat)imageViewWH;


-(instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor cornerRadius:(CGFloat)radius image:(NSString *)imgName;

- (instancetype)initWithCorner;

@end
