//
//  UIImageView+FxlExtension.m
//  paobanglang
//
//  Created by ios on 18/1/31.
//  Copyright © 2018年 user. All rights reserved.
//

#import "UIImageView+FxlExtension.h"

@implementation UIImageView (FxlExtension)

-(BOOL)isValidateHttp:(NSString *)http {
    if ([http hasPrefix:@"http"] || [http hasPrefix:@"https"]) {
        return YES;
    }else {
        return NO;
    }
}

-(instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor cornerRadius:(CGFloat)radius
                       image:(NSString *)imgName {

    self = [self initWithFrame:frame];
    self.backgroundColor = bgColor;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    if ([self isValidateHttp:imgName]) {
        if ([imgName isKindOfClass:[NSString class]] && imgName.length > 0) {
            [self sd_setImageWithURL:[NSURL URLWithString:imgName]];
        }
    }else {
        if ([imgName isKindOfClass:[NSString class]] && imgName.length > 0) {
            [self setImage:[UIImage imageNamed:imgName]];
        }
    }
    return self;
}

- (UIImage *)fxl_PlaceHolderImg:(NSString *)placeholderName {
    UIImage *placeholderImage = nil;
    if (placeholderName == nil || [placeholderName isEqualToString:@""]) {
        placeholderImage = nil;
    }else {
        placeholderImage = [UIImage fxl_circleImage:placeholderName];
    }
    return placeholderImage;
}

/**
 *  圆形
 */
- (void)FXL_setCircleHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName {

    if ([self isValidateHttp:url]) {
        // 让占位图片也是圆的
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[self fxl_PlaceHolderImg:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image == nil) return;
            self.image = [image circleImage];
        }];
    }else {
        self.image = [[UIImage imageNamed:url] circleImage];
    }
}

/**
 *  圆形并且有边框
 */
- (void)FXL_setCircleBorderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    // 让占位图片也是圆的
    if ([self isValidateHttp:url]) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[self fxl_PlaceHolderImg:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image == nil) return;
            if (borderWidth > 0) {
                self.image = [image circleBorderImageWithParam:0 cornerWidth:borderWidth cornerColor:borderColor];
            }else {
                self.image = [image circleImage];
            }
        }];
    }else {
        UIImage *image = [UIImage imageNamed:url];
        if (borderWidth > 0) {
            self.image = [image circleBorderImageWithParam:0 cornerWidth:borderWidth cornerColor:borderColor];
        }else {
            self.image = [image circleImage];
        }
    }
}

/**
 *  方形,也可以设置圆角
 */
- (void)FXL_setRectHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName cornerRadius:(CGFloat)cornerRadius {
    if ([self isValidateHttp:url]) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[self fxl_PlaceHolderImg:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image == nil) return;
            if (cornerRadius > 0) {
                self.layer.cornerRadius = cornerRadius;
                self.clipsToBounds = YES;
            }
            self.image = [image drawRectImage];
        }];
    }else {
        if (cornerRadius > 0) {
            self.layer.cornerRadius = cornerRadius;
            self.clipsToBounds = YES;
        }
        self.image = [[UIImage imageNamed:url] drawRectImage];
    }
}

/**
 *  六边形
 */
- (void)FXL_setSixSideHeaderWithUrl:(NSString *)url placeholder:(NSString *)placeholderName imageViewWH:(CGFloat)imageViewWH {
    if ([self isValidateHttp:url]) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[self fxl_PlaceHolderImg:placeholderName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image == nil) return;
            // 这个宽高要跟外面你要设置的 imageview 的宽高一样
            UIBezierPath * path = [UIBezierPath bezierPath];
            path.lineWidth = 2;
            [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2), (imageViewWH / 4))];
            [path addLineToPoint:CGPointMake((imageViewWH / 2), 0)];
            [path addLineToPoint:CGPointMake(imageViewWH - ((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2)), (imageViewWH / 4))];
            [path addLineToPoint:CGPointMake(imageViewWH - ((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2)), (imageViewWH / 2) + (imageViewWH / 4))];
            [path addLineToPoint:CGPointMake((imageViewWH / 2), imageViewWH)];
            [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2), (imageViewWH / 2) + (imageViewWH / 4))];
            [path closePath];
            CAShapeLayer * shapLayer = [CAShapeLayer layer];
            shapLayer.lineWidth = 2;
            shapLayer.path = path.CGPath;
            self.layer.mask = shapLayer;
        }];
    }else {
        self.image = [UIImage imageNamed:url];
        // 这个宽高要跟外面你要设置的 imageview 的宽高一样
        UIBezierPath * path = [UIBezierPath bezierPath];
        path.lineWidth = 2;
        [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2), (imageViewWH / 4))];
        [path addLineToPoint:CGPointMake((imageViewWH / 2), 0)];
        [path addLineToPoint:CGPointMake(imageViewWH - ((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2)), (imageViewWH / 4))];
        [path addLineToPoint:CGPointMake(imageViewWH - ((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2)), (imageViewWH / 2) + (imageViewWH / 4))];
        [path addLineToPoint:CGPointMake((imageViewWH / 2), imageViewWH)];
        [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (imageViewWH / 2), (imageViewWH / 2) + (imageViewWH / 4))];
        [path closePath];
        CAShapeLayer * shapLayer = [CAShapeLayer layer];
        shapLayer.lineWidth = 2;
        shapLayer.path = path.CGPath;
        self.layer.mask = shapLayer;
    }
}

- (instancetype)initWithCorner {
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    return self;
}


@end
