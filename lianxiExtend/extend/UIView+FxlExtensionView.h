//
//  UIView+FxlExtensionView.h
//  paobanglang
//
//  Created by ios on 18/1/31.
//  Copyright © 2018年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FxlExtensionView)

@property (nonatomic) CGFloat fxl_x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat fxl_y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat fxl_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat fxl_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat fxl_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat fxl_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat fxl_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat fxl_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint fxl_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  fxl_size;        ///< Shortcut for frame.size.

- (instancetype)fxl_drawrectWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 初始化frame
 */
-(instancetype)initWithFrame:(CGRect)frame bgColor:(UIColor *)color cornerRadius:(int)radius;
/**
 初始化lable的frame
 */
-(UILabel *)initWithLableFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor bgColor:(UIColor*)color font:(long)size bold:(BOOL)flag cornerRadius:(int)radius;
/**
 初始化field的frame
 */
-(UITextField *)initWithFieldFrame:(CGRect)frame text:(NSString *)text font:(int)font color:(UIColor *)color bgColor:(UIColor *)bgColor placeHolder:(NSString *)placeHolder placeHolderfont:(int)placeFont placeColor:(UIColor *)placeColor;
/**
 初始化textView的frame
 */
-(UITextView *)initWithTextViewFrame:(CGRect)frame text:(NSString *)text font:(int)font color:(UIColor *)color bgColor:(UIColor *)bgColor placeHolder:(NSString *)placeHolder placeColor:(UIColor *)placeColor;
@end
