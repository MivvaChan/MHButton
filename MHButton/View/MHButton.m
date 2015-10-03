//
//  MHButton.m
//  MHButton
//
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

#import "MHButton.h"

@interface MHButton ()
@property (nonatomic, assign) CGFloat titleLabelScale;  // titleLable相对imageView占整个内容视图的比例(例:如果titleLabel = 0.4,那么imageView的比例为0.6)
@property (nonatomic, assign) CGFloat border;           // 最左侧控件的x值或y值\按钮四周与控件的边界距离
@property (nonatomic, assign) CGFloat midBorder;        // titleLabel和imageView两个控件之间的间距
@end

@implementation MHButton

- (instancetype)initWithContentType:(MHButtonContentType)contentType
                       contentStyle:(MHButtonContentStyle)contentStyle
                    titleLabelScale:(CGFloat)titleLabelScale
                             border:(CGFloat)border
                          midBorder:(CGFloat)midBorder {
    if (self = [super init]) {
        self.contentType = contentType;
        self.contentStyle = contentStyle;
        self.border = border;
        self.midBorder = midBorder;
        self.titleLabelScale = titleLabelScale;
        int scale = self.titleLabelScale;
        if (scale == 1) {
            self.midBorder = 0.0f;
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

/**
 *  设置内部图标的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    switch (self.contentType) {
        case MHButtonContentTypeOnlyTitleLabel: {
            return CGRectZero;
        }
            break;
        case MHButtonContentTypeOnlyImageView: {
            CGFloat imageY = self.midBorder;
            CGFloat imageX = self.border;
            CGFloat imageH = contentRect.size.height - 2*self.midBorder;
            CGFloat imageW = contentRect.size.width - 2*self.border;
            return CGRectMake(imageX, imageY, imageW, imageH);
        }
            break;
        case MHButtonContentTypeDefault: {
            switch (self.contentStyle) {
                case MHButtonContentStyleDefault: {
                    CGFloat imageY = self.border + kSpace;
                    CGFloat imageW = (contentRect.size.width - self.border*2 - self.midBorder) * (1 - self.titleLabelScale);
                    CGFloat imageH = contentRect.size.height - self.border*2;
                    CGFloat imageX = self.border;
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                case MHButtonContentStyleValue1: {
                    CGFloat imageY = self.border + kSpace;
                    CGFloat imageW = (contentRect.size.width - self.border*2 - self.midBorder) * (1 - self.titleLabelScale);
                    CGFloat imageH = contentRect.size.height - self.border*2;
                    CGFloat imageX = self.border + self.midBorder + (contentRect.size.width - self.border*2 - self.midBorder) * self.titleLabelScale;
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                case MHButtonContentStyleValue2: {
                    CGFloat imageY = self.border;
                    CGFloat imageW = contentRect.size.width - self.border*2;
                    CGFloat imageH = (contentRect.size.height + kSpace*2 - self.border*2 - self.midBorder) * (1 - self.titleLabelScale);
                    CGFloat imageX = self.border;
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                case MHButtonContentStyleValue3: {
                    CGFloat imageY = self.border + self.titleLabelScale*contentRect.size.height + self.midBorder;
                    CGFloat imageW = contentRect.size.width - self.border*2;
                    CGFloat imageH = (contentRect.size.height + kSpace*2 - self.border*2 - self.midBorder) * (1 - self.titleLabelScale);
                    CGFloat imageX = self.border;
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    return CGRectZero;
}

/**
 *  设置内部文字的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    switch (self.contentType) {
        case MHButtonContentTypeOnlyTitleLabel: {
            CGFloat titleY = self.midBorder;
            CGFloat titleX = self.border;
            CGFloat titleH = contentRect.size.height - 2*self.midBorder;
            CGFloat titleW = contentRect.size.width - 2*self.border;
            return CGRectMake(titleX, titleY, titleW, titleH);
        }
            break;
        case MHButtonContentTypeOnlyImageView: {
            return CGRectZero;
        }
            break;
        case MHButtonContentTypeDefault: {
            switch (self.contentStyle) {
                case MHButtonContentStyleValue1: {
                    CGFloat imageY = self.border + kSpace;
                    CGFloat imageW = (contentRect.size.width - self.border*2 - self.midBorder) * self.titleLabelScale;
                    CGFloat imageH = contentRect.size.height - self.border*2;
                    CGFloat imageX = self.border;
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                case MHButtonContentStyleDefault: {
                    CGFloat imageY = self.border + kSpace;
                    CGFloat imageW = (contentRect.size.width - self.border*2 - self.midBorder) * self.titleLabelScale;
                    CGFloat imageH = contentRect.size.height - self.border*2;
                    CGFloat imageX = self.border + self.midBorder + (contentRect.size.width - self.border*2 - self.midBorder) * (1 - self.titleLabelScale);
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                case MHButtonContentStyleValue3: {
                    CGFloat imageY = self.border;
                    CGFloat imageW = contentRect.size.width - self.border*2;
                    CGFloat imageH = (contentRect.size.height + kSpace*2 - self.border*2 - self.midBorder) * self.titleLabelScale;
                    CGFloat imageX = self.border;
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                case MHButtonContentStyleValue2: {
                    CGFloat imageY = self.border + (1 - self.titleLabelScale)*contentRect.size.height + self.midBorder;
                    CGFloat imageW = contentRect.size.width - self.border*2;
                    CGFloat imageH = (contentRect.size.height + kSpace*2 - self.border*2 - self.midBorder) * self.titleLabelScale;
                    CGFloat imageX = self.border;
                    return CGRectMake(imageX, imageY, imageW, imageH);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    return CGRectZero;
}

- (void)setTitleLabelScale:(CGFloat)titleLabelScale {
    _titleLabelScale = titleLabelScale;
    if (_titleLabelScale > 1.0f) {
        _titleLabelScale = 1.0f;
    }
    if (_titleLabelScale < 0.0f) {
        _titleLabelScale = 0.0f;
    }
}

@end
