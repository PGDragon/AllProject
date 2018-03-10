
//
//  UIView+FxlExtensionView.m
//  paobanglang
//
//  Created by ios on 18/1/31.
//  Copyright © 2018年 user. All rights reserved.
//

#import "UIView+FxlExtensionView.h"

@implementation UIView (FxlExtensionView)

- (CGFloat)fxl_x {
    return self.frame.origin.x;
}

- (void)setFxl_x:(CGFloat)fxl_x {
    CGRect frame = self.frame;
    frame.origin.x = fxl_x;
    self.frame = frame;
}

- (CGFloat)fxl_y {
    return self.frame.origin.y;
}

- (void)setFxl_y:(CGFloat)fxl_y {
    CGRect frame = self.frame;
    frame.origin.y = fxl_y;
    self.frame = frame;
}

- (CGFloat)fxl_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFxl_right:(CGFloat)fxl_right {
    CGRect frame = self.frame;
    frame.origin.x = fxl_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)fxl_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFxl_bottom:(CGFloat)fxl_bottom {
    CGRect frame = self.frame;
    frame.origin.y = fxl_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)fxl_width {
    return self.frame.size.width;
}

- (void)setFxl_width:(CGFloat)fxl_width {
    CGRect frame = self.frame;
    frame.size.width = fxl_width;
    self.frame = frame;
}


- (CGFloat)fxl_height {
    return self.frame.size.height;
}

- (void)setFxl_height:(CGFloat)fxl_height {
    CGRect frame = self.frame;
    frame.size.height = fxl_height;
    self.frame = frame;
}

- (CGFloat)fxl_centerX {
    return self.center.x;
}

- (void)setFxl_centerX:(CGFloat)fxl_centerX {
    self.center = CGPointMake(fxl_centerX, self.center.y);
}

- (CGFloat)fxl_centerY {
    return self.center.y;
}

- (void)setFxl_centerY:(CGFloat)fxl_centerY {
    self.center = CGPointMake(self.center.x, fxl_centerY);
}

- (CGPoint)fxl_origin {
    return self.frame.origin;
}

- (void)setFxl_origin:(CGPoint)fxl_origin {
    CGRect frame = self.frame;
    frame.origin = fxl_origin;
    self.frame = frame;
}

- (CGSize)fxl_size {
    return self.frame.size;
}

- (void)setFxl_size:(CGSize)fxl_size {
    CGRect frame = self.frame;
    frame.size = fxl_size;
    self.frame = frame;
}

- (instancetype)fxl_drawrectWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (borderWidth > 0) {
        //设置线条样式
        CGContextSetLineCap(context, kCGLineCapSquare);
        //设置线条粗细宽度
        CGContextSetLineWidth(context, borderWidth);
        //设置颜色
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    }
    //开始一个起始路径
    CGContextBeginPath(context);
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextMoveToPoint(context, self.fxl_x, self.fxl_y);
    //设置下一个坐标点
    CGContextAddLineToPoint(context,self.fxl_right, self.fxl_y);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, self.fxl_right, self.fxl_bottom);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, self.fxl_x, self.fxl_bottom);
    //连接上面定义的坐标点
    CGContextStrokePath(context);
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)color cornerRadius:(int)radius {
    self = [self initWithFrame:frame];
    if (radius > 0) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = radius;
    }
    if (color) {
        self.backgroundColor = color;
    }
    return self;
}

-(UILabel *)initWithLableFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor bgColor:(UIColor*)color font:(long)size bold:(BOOL)flag cornerRadius:(int)radius {
    self = [self init];
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    //文字
    label.text = text;
    //文字颜色
    label.textColor = textColor;
    if (color) {
        label.backgroundColor = color;
    }
    //字体大小
    if (flag) {
        label.font = [UIFont boldSystemFontOfSize:size];
    }else {
        if (size){
            label.font = [UIFont systemFontOfSize:size];
        }
    }
    if (radius > 0) {
        label.clipsToBounds = YES;
        label.layer.cornerRadius = radius;
    }
    return label;
}

-(UITextField *)initWithFieldFrame:(CGRect)frame text:(NSString *)text font:(int)font color:(UIColor *)color bgColor:(UIColor *)bgColor placeHolder:(NSString *)placeHolder placeHolderfont:(int)placeFont placeColor:(UIColor *)placeColor {

    self = [self init];
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    if (text.length > 0) {
        [textField setText:text];
    }
    
    if (placeHolder.length > 0) {
        [textField setPlaceholder:placeHolder];
    }
    
    if (font) {
        [textField setFont:[UIFont systemFontOfSize:font]];
    }
    
    if (color) {
        [textField setTextColor:color];
    }
    
    if (bgColor) {
        textField.backgroundColor = bgColor;
    }
    
    NSMutableDictionary *tempDic = [NSMutableDictionary new];
    if (![self isNULLOrnil:placeColor]) {
        UIColor *placeC = [self isNULLOrnil:placeColor]?[UIColor colorWithRed:173/255.0f green:173/255.0f blue:173/255.0f alpha:1.0f]:placeColor;
        [tempDic setObject:placeC forKey:NSForegroundColorAttributeName];
    }
    
    if (placeFont) {
        [tempDic setObject:[UIFont systemFontOfSize:placeFont] forKey:NSFontAttributeName];
    }
    
    if (tempDic.count) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:tempDic];
    }
    
    return textField;
}

-(UITextView *)initWithTextViewFrame:(CGRect)frame text:(NSString *)text font:(int)font color:(UIColor *)color bgColor:(UIColor *)bgColor placeHolder:(NSString *)placeHolder placeColor:(UIColor *)placeColor {
    self = [self init];
    UITextView * textView = [[UITextView alloc]initWithFrame:frame];
    if (text.length > 0) {
        [textView setText:text];
    }
    
    if (font) {
        [textView setFont:[UIFont systemFontOfSize:font]];
    }
    
    if (color) {
        [textView setTextColor:color];
    }
    
    if (bgColor) {
        textView.backgroundColor = bgColor;
    }
    
    if (placeHolder.length > 0) {
        textView.FXL_placeholder = placeHolder;
    }
    
    if (placeColor) {
        textView.FXL_placeholderColor = [self isNULLOrnil:placeColor]?[UIColor colorWithRed:173/255.0f green:173/255.0f blue:173/255.0f alpha:1.0f]:placeColor;;
    }
    return textView;
}

-(Boolean)isNULLOrnil:(id)sender{
    if (((NSNull *)sender == [NSNull null])||(sender==nil))
        return YES;
    return NO;
}

@end
