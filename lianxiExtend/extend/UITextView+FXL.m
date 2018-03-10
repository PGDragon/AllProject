//
//  UITextView+FXL.m
//  FXLTextView-demo
//
//  Created by normal on 2016/11/14.
//  Copyright © 2016年 FXL. All rights reserved.
//

#import "UITextView+FXL.h"
#import <objc/runtime.h>

// 占位文字
static const void *FXLPlaceholderViewKey = &FXLPlaceholderViewKey;
// 占位文字颜色
static const void *FXLPlaceholderColorKey = &FXLPlaceholderColorKey;
// 最大高度
static const void *FXLTextViewMaxHeightKey = &FXLTextViewMaxHeightKey;
// 最小高度
static const void *FXLTextViewMinHeightKey = &FXLTextViewMinHeightKey;
// 高度变化的block
static const void *FXLTextViewHeightDidChangedBlockKey = &FXLTextViewHeightDidChangedBlockKey;
// 存储添加的图片
static const void *FXLTextViewImageArrayKey = &FXLTextViewImageArrayKey;
// 存储最后一次改变高度后的值
static const void *FXLTextViewLastHeightKey = &FXLTextViewLastHeightKey;

@interface UITextView ()

// 存储添加的图片
@property (nonatomic, strong) NSMutableArray *FXL_imageArray;
// 存储最后一次改变高度后的值
@property (nonatomic, assign) CGFloat lastHeight;

@end

@implementation UITextView (FXL)

#pragma mark - Swizzle Dealloc
+ (void)load {
    // 交换dealoc
    Method dealoc = class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc"));
    Method myDealloc = class_getInstanceMethod(self.class, @selector(myDealloc));
    method_exchangeImplementations(dealoc, myDealloc);
}

- (void)myDealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    UITextView *placeholderView = objc_getAssociatedObject(self, FXLPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        for (NSString *property in propertys) {
            @try {
                [self removeObserver:self forKeyPath:property];
            } @catch (NSException *exception) {}
        }
    }
    [self myDealloc];
}

#pragma mark - set && get
- (UITextView *)FXL_placeholderView {
    
    // 为了让占位文字和textView的实际文字位置能够完全一致，这里用UITextView
    UITextView *placeholderView = objc_getAssociatedObject(self, FXLPlaceholderViewKey);
    
    if (!placeholderView) {
        
        // 初始化数组
        self.FXL_imageArray = [NSMutableArray array];
        
        placeholderView = [[UITextView alloc] init];
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, FXLPlaceholderViewKey, placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        placeholderView = placeholderView;
        
        // 设置基本属性
        placeholderView.scrollEnabled = placeholderView.userInteractionEnabled = NO;
//        self.scrollEnabled = placeholderView.scrollEnabled = placeholderView.showsHorizontalScrollIndicator = placeholderView.showsVerticalScrollIndicator = placeholderView.userInteractionEnabled = NO;
        placeholderView.textColor = [UIColor lightGrayColor];
        placeholderView.backgroundColor = [UIColor clearColor];
        [self refreshPlaceholderView];
        [self addSubview:placeholderView];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange) name:UITextViewTextDidChangeNotification object:self];
        
        // 这些属性改变时，都要作出一定的改变，尽管已经监听了TextDidChange的通知，也要监听text属性，因为通知监听不到setText：
        NSArray *propertys = @[@"frame", @"bounds", @"font", @"text", @"textAlignment", @"textContainerInset"];
        
        // 监听属性
        for (NSString *property in propertys) {
            [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
        }
        
    }
    return placeholderView;
}

- (void)setFXL_placeholder:(NSString *)placeholder
{
    // 为placeholder赋值
    [self FXL_placeholderView].text = placeholder;
}

- (NSString *)FXL_placeholder
{
    // 如果有placeholder值才去调用，这步很重要
    if (self.placeholderExist) {
        return [self FXL_placeholderView].text;
    }
    return nil;
}

- (void)setFXL_placeholderColor:(UIColor *)FXL_placeholderColor
{
    // 如果有placeholder值才去调用，这步很重要
    if (!self.placeholderExist) {
        NSLog(@"请先设置placeholder值！");
    } else {
        self.FXL_placeholderView.textColor = FXL_placeholderColor;
        
        // 动态添加属性的本质是: 让对象的某个属性与值产生关联
        objc_setAssociatedObject(self, FXLPlaceholderColorKey, FXL_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (UIColor *)FXL_placeholderColor
{
    return objc_getAssociatedObject(self, FXLPlaceholderColorKey);
}

- (void)setFXL_maxHeight:(CGFloat)FXL_maxHeight
{
    CGFloat max = FXL_maxHeight;
    
    // 如果传入的最大高度小于textView本身的高度，则让最大高度等于本身高度
    if (FXL_maxHeight < self.frame.size.height) {
        max = self.frame.size.height;
    }
    
    objc_setAssociatedObject(self, FXLTextViewMaxHeightKey, [NSString stringWithFormat:@"%lf", max], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)FXL_maxHeight
{
    return [objc_getAssociatedObject(self, FXLTextViewMaxHeightKey) doubleValue];
}

- (void)setFXL_minHeight:(CGFloat)FXL_minHeight
{
    objc_setAssociatedObject(self, FXLTextViewMinHeightKey, [NSString stringWithFormat:@"%lf", FXL_minHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)FXL_minHeight
{
    return [objc_getAssociatedObject(self, FXLTextViewMinHeightKey) doubleValue];
}

- (void)setFXL_textViewHeightDidChanged:(textViewHeightDidChangedBlock)FXL_textViewHeightDidChanged
{
    objc_setAssociatedObject(self, FXLTextViewHeightDidChangedBlockKey, FXL_textViewHeightDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (textViewHeightDidChangedBlock)FXL_textViewHeightDidChanged
{
    void(^textViewHeightDidChanged)(CGFloat currentHeight) = objc_getAssociatedObject(self, FXLTextViewHeightDidChangedBlockKey);
    return textViewHeightDidChanged;
}

- (NSArray *)FXL_getImages
{
    return self.FXL_imageArray;
}

- (void)setLastHeight:(CGFloat)lastHeight {
    objc_setAssociatedObject(self, FXLTextViewLastHeightKey, [NSString stringWithFormat:@"%lf", lastHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)lastHeight {
    return [objc_getAssociatedObject(self, FXLTextViewLastHeightKey) doubleValue];
}

- (void)setFXL_imageArray:(NSMutableArray *)FXL_imageArray {
    objc_setAssociatedObject(self, FXLTextViewImageArrayKey, FXL_imageArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)FXL_imageArray {
    return objc_getAssociatedObject(self, FXLTextViewImageArrayKey);
}

- (void)FXL_autoHeightWithMaxHeight:(CGFloat)maxHeight
{
    [self FXL_autoHeightWithMaxHeight:maxHeight textViewHeightDidChanged:nil];
}
// 是否启用自动高度，默认为NO
static bool autoHeight = NO;
- (void)FXL_autoHeightWithMaxHeight:(CGFloat)maxHeight textViewHeightDidChanged:(textViewHeightDidChangedBlock)textViewHeightDidChanged
{
    autoHeight = YES;
    [self FXL_placeholderView];
    self.FXL_maxHeight = maxHeight;
    if (textViewHeightDidChanged) self.FXL_textViewHeightDidChanged = textViewHeightDidChanged;
}

#pragma mark - addImage
/* 添加一张图片 */
- (void)FXL_addImage:(UIImage *)image
{
    [self FXL_addImage:image size:CGSizeZero];
}

/* 添加一张图片 image:要添加的图片 size:图片大小 */
- (void)FXL_addImage:(UIImage *)image size:(CGSize)size
{
    [self FXL_insertImage:image size:size index:self.attributedText.length > 0 ? self.attributedText.length : 0];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 */
- (void)FXL_insertImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index
{
    [self FXL_addImage:image size:size index:index multiple:-1];
}

/* 添加一张图片 image:要添加的图片 multiple:放大／缩小的倍数 */
- (void)FXL_addImage:(UIImage *)image multiple:(CGFloat)multiple
{
    [self FXL_addImage:image size:CGSizeZero index:self.attributedText.length > 0 ? self.attributedText.length : 0 multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 multiple:放大／缩小的倍数 index:插入的位置 */
- (void)FXL_insertImage:(UIImage *)image multiple:(CGFloat)multiple index:(NSInteger)index
{
    [self FXL_addImage:image size:CGSizeZero index:index multiple:multiple];
}

/* 插入一张图片 image:要添加的图片 size:图片大小 index:插入的位置 multiple:放大／缩小的倍数 */
- (void)FXL_addImage:(UIImage *)image size:(CGSize)size index:(NSInteger)index multiple:(CGFloat)multiple {
    if (image) [self.FXL_imageArray addObject:image];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    CGRect bounds = textAttachment.bounds;
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        bounds.size = size;
        textAttachment.bounds = bounds;
    } else if (multiple <= 0) {
        CGFloat oldWidth = textAttachment.image.size.width;
        CGFloat scaleFactor = oldWidth / (self.frame.size.width - 10);
        textAttachment.image = [UIImage imageWithCGImage:textAttachment.image.CGImage scale:scaleFactor orientation:UIImageOrientationUp];
    } else {
        bounds.size = image.size;
        textAttachment.bounds = bounds;
    }
    
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString replaceCharactersInRange:NSMakeRange(index, 0) withAttributedString:attrStringWithImage];
    self.attributedText = attributedString;
    [self textViewTextChange];
    [self refreshPlaceholderView];
}


#pragma mark - KVO监听属性改变
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self refreshPlaceholderView];
    if ([keyPath isEqualToString:@"text"]) [self textViewTextChange];
}

// 刷新PlaceholderView
- (void)refreshPlaceholderView {
    
    UITextView *placeholderView = objc_getAssociatedObject(self, FXLPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.FXL_placeholderView.frame = self.bounds;
        if (self.FXL_maxHeight < self.bounds.size.height) self.FXL_maxHeight = self.bounds.size.height;
        self.FXL_placeholderView.font = self.font;
        self.FXL_placeholderView.textAlignment = self.textAlignment;
        self.FXL_placeholderView.textContainerInset = self.textContainerInset;
        self.FXL_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
}

// 处理文字改变
- (void)textViewTextChange {
    UITextView *placeholderView = objc_getAssociatedObject(self, FXLPlaceholderViewKey);
    
    // 如果有值才去调用，这步很重要
    if (placeholderView) {
        self.FXL_placeholderView.hidden = (self.text.length > 0 && self.text);
    }
    // 如果没有启用自动高度，不执行以下方法
    if (!autoHeight) return;
    if (self.FXL_maxHeight >= self.bounds.size.height) {
        
        // 计算高度
        NSInteger currentHeight = ceil([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
        
        // 如果高度有变化，调用block
        if (currentHeight != self.lastHeight) {
            // 是否可以滚动
            self.scrollEnabled = currentHeight >= self.FXL_maxHeight;
            CGFloat currentTextViewHeight = currentHeight >= self.FXL_maxHeight ? self.FXL_maxHeight : currentHeight;
            // 改变textView的高度
            if (currentTextViewHeight >= self.FXL_minHeight) {
                CGRect frame = self.frame;
                frame.size.height = currentTextViewHeight;
                self.frame = frame;
                // 调用block
                if (self.FXL_textViewHeightDidChanged) self.FXL_textViewHeightDidChanged(currentTextViewHeight);
                // 记录当前高度
                self.lastHeight = currentTextViewHeight;
            }
        }
    }
    
    if (!self.isFirstResponder) [self becomeFirstResponder];
}

// 判断是否有placeholder值，这步很重要
- (BOOL)placeholderExist {
    
    // 获取对应属性的值
    UITextView *placeholderView = objc_getAssociatedObject(self, FXLPlaceholderViewKey);
    
    // 如果有placeholder值
    if (placeholderView) return YES;
    
    return NO;
}

@end
