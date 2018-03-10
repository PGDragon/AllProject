//
//  UITextView+FXL.h
//  FXLTextView-demo
//
//  Created by normal on 2016/11/14.
//  Copyright © 2016年 FXL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^textViewHeightDidChangedBlock)(CGFloat currentTextViewHeight);

@interface UITextView (FXL)

/* 占位文字 */
@property (nonatomic, copy) NSString *FXL_placeholder;


/* 占位文字颜色 */
@property (nonatomic, strong) UIColor *FXL_placeholderColor;


/* 最大高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat FXL_maxHeight;


/* 最小高度，如果需要随文字改变高度的时候使用 */
@property (nonatomic, assign) CGFloat FXL_minHeight;


@property (nonatomic, copy) textViewHeightDidChangedBlock FXL_textViewHeightDidChanged;


/* 获取图片数组 */
- (NSArray *)FXL_getImages;


/* 自动高度的方法，maxHeight：最大高度 */
- (void)FXL_autoHeightWithMaxHeight:(CGFloat)maxHeight;


/* 自动高度的方法，maxHeight：最大高度， textHeightDidChanged：高度改变的时候调用 */
- (void)FXL_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged;

/* 添加一张图片 image:要添加的图片 */
- (void)FXL_addImage:(UIImage *)image;


/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)FXL_addImage:(UIImage *)image size:(CGSize)size;


/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)FXL_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index;


/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)FXL_addImage:(UIImage *)image multiple:(CGFloat)multiple;


/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)FXL_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index;


@end
