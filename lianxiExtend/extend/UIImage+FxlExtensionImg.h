//
//  UIImage+FxlExtensionImg.h
//  paobanglang
//
//  Created by ios on 18/1/31.
//  Copyright © 2018年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FxlExtensionImg)

/**
 *  返回圆形图片
 */
- (instancetype)circleImage;

/**
 *  返回圆形图片
 */
+ (instancetype)fxl_circleImage:(NSString *)name;

/**
 *  返回圆形图片有边框
 */
-(instancetype)circleBorderImageWithParam:(CGFloat)inset cornerWidth:(CGFloat)borderWidth cornerColor:(UIColor *)cornerColor;

/**
 *  返回圆形图片有边框
 */
+ (instancetype)fxl_circleBorderImage:(UIImage *)image cornerWidth:(CGFloat)borderWidth cornerColor:(UIColor *)cornerColor;

/**
 *  加载本地图片(读文件)
 */
- (instancetype)imageWithPath:(NSString *)pathName;

/**
 *  加载本地图片(读文件)
 */
+ (instancetype)fxl_imageWithPath:(NSString *)pathName;

/**
 *  返回重绘图片
 */
- (instancetype)drawRectImage;

/**
 *  返回重绘图片
 */
+ (instancetype)fxl_drawRectImage:(UIImage *)image;

//颜色转换图片
+(UIImage*)imageWithColor:(UIColor*) color;

@end
