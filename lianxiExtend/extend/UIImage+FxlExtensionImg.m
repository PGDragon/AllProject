//
//  UIImage+FxlExtensionImg.m
//  paobanglang
//
//  Created by ios on 18/1/31.
//  Copyright © 2018年 user. All rights reserved.
//

#import "UIImage+FxlExtensionImg.h"

@implementation UIImage (FxlExtensionImg)

- (instancetype)circleImage {
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+(instancetype)fxl_circleImage:(NSString *)name {
    return [[self imageNamed:name] circleImage];
}

-(instancetype)circleBorderImageWithParam:(CGFloat)inset cornerWidth:(CGFloat)borderWidth cornerColor:(UIColor *)cornerColor {
    
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    
    CGContextSetLineWidth(context,borderWidth);
    
    CGContextSetStrokeColorWithColor(context, cornerColor.CGColor);
    
    CGRect rect = CGRectMake(inset, inset, self.size.width - inset *2.0f, self.size.height - inset *2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [self drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}

+ (instancetype)fxl_circleBorderImage:(UIImage *)image cornerWidth:(CGFloat)borderWidth cornerColor:(UIColor *)cornerColor {
    return [image circleBorderImageWithParam:0 cornerWidth:borderWidth cornerColor:cornerColor];
}

- (instancetype)imageWithPath:(NSString *)pathName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:pathName ofType:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    return image;
}

+ (instancetype)fxl_imageWithPath:(NSString *)pathName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:pathName ofType:nil];
    return [self imageWithContentsOfFile:filePath];
}

- (instancetype)drawRectImage {
    //确定压缩后的size
    CGFloat scaleWidth = self.size.width;
    CGFloat scaleHeight = self.size.height;
    CGSize scaleSize = CGSizeMake(scaleWidth, scaleHeight);
    //开启图形上下文
    UIGraphicsBeginImageContext(scaleSize);
    //绘制图片
    [self drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];
    //从图形上下文获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)fxl_drawRectImage:(UIImage *)image {
    return [image drawRectImage];
}

+(UIImage*)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
