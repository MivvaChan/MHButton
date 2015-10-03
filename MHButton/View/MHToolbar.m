//
//  MHToolbar.m
//  MHButton
//
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

#import "MHToolbar.h"

@interface MHToolbar ()
@property (nonatomic, weak) MHButton *firstButton;
@end

@implementation MHToolbar

- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray {
    return [self initWithFrame:frame contentType:MHButtonContentTypeOnlyTitleLabel contentStyle:MHButtonContentStyleDefault titleLabelScale:1.0f border:0 midBorder:0 titlesArray:titlesArray imagesArray:nil];
}

- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)imagesArray {
    return [self initWithFrame:frame contentType:MHButtonContentTypeOnlyImageView contentStyle:MHButtonContentStyleDefault titleLabelScale:0.0f border:0 midBorder:0 titlesArray:nil imagesArray:imagesArray];
}

- (instancetype)initWithFrame:(CGRect)frame
                  contentType:(MHButtonContentType)contentType
                 contentStyle:(MHButtonContentStyle)contentStyle
              titleLabelScale:(CGFloat)titleLabelScale
                       border:(CGFloat)border
                    midBorder:(CGFloat)midBorder
                  titlesArray:(NSArray *)titlesArray
                  imagesArray:(NSArray *)imagesArray
{
    if (self = [super initWithFrame:frame]) {
        [self setupButtonsWithContentType:contentType contentStyle:contentStyle width:frame.size.width titleLabelScale:titleLabelScale border:border midBorder:midBorder titlesArray:titlesArray imagesArray:imagesArray];
    }
    
    return self;
}

- (void)setupButtonsWithContentType:(MHButtonContentType)contentType
                       contentStyle:(MHButtonContentStyle)contentStyle
                              width:(CGFloat)width
                    titleLabelScale:(CGFloat)titleLabelScale
                             border:(CGFloat)border
                          midBorder:(CGFloat)midBorder
                        titlesArray:(NSArray *)titlesArray
                        imagesArray:(NSArray *)imagesArray
{
    for (int i = 0; i < (titlesArray.count ? titlesArray.count : (imagesArray.count ? imagesArray.count : 0)); i++) {
        MHButton *btn = [[MHButton alloc] initWithContentType:contentType contentStyle:contentStyle titleLabelScale:titleLabelScale border:border midBorder:midBorder];
        btn.tag = i;
        btn.titleLabel.backgroundColor = [UIColor redColor];
        btn.imageView.backgroundColor = [UIColor greenColor];
        btn.contentEdgeInsets = UIEdgeInsetsMake(kSpace, 0, kSpace, 0);
        [btn setTitle:(titlesArray.count ? titlesArray[i] : nil) forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setImage:[UIImage imageNamed:(imagesArray.count ? imagesArray[i] : nil)] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0) {
            self.firstButton = btn;
        }
    }
}

- (void)setLabelTextAlignment:(NSTextAlignment)labelTextAlignment {
    for (UIButton *btn in self.subviews) {
        btn.titleLabel.textAlignment = labelTextAlignment;
    }
}

- (void)setLabelFont:(UIFont *)labelFont {
    for (UIButton *btn in self.subviews) {
        btn.titleLabel.font = labelFont;
    }
}

- (void)setLabelColor:(UIColor *)labelColor {
    for (UIButton *btn in self.subviews) {
        btn.titleLabel.backgroundColor = labelColor;
    }
}

- (void)setLabelTextColor:(UIColor *)labelTextColor {
    for (UIButton *btn in self.subviews) {
        [btn setTitleColor:labelTextColor forState:UIControlStateNormal];
    }
}

- (void)buttonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(toolbar:didClickButton:)]) {
        [self.delegate toolbar:self didClickButton:button];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIButton *btn in self.subviews) {
        btn.frame = CGRectMake(btn.tag*(self.bounds.size.width/self.subviews.count), 0, self.bounds.size.width/self.subviews.count, self.bounds.size.height);
    }
}

@end
