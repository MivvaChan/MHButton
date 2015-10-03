//
//  MHToolbar.h
//  MHButton
//  https://github.com/huazaiCee/MHButton
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

// 设备宽度
#define KScreenW [UIScreen mainScreen].bounds.size.width
// 设备高度
#define KScreenH [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>
#import "MHButton.h"
@class MHToolbar;

@protocol MHToolbarDelegate <NSObject>
- (void)toolbar:(MHToolbar *)toolbar didClickButton:(UIButton *)button;
@end

@interface MHToolbar : UIView
@property (nonatomic, strong) UIColor *labelTextColor;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic) NSTextAlignment  labelTextAlignment;
@property (nonatomic, assign) id<MHToolbarDelegate> delegate;
@property (nonatomic, readonly, weak) MHButton *firstButton;

- (instancetype)initWithFrame:(CGRect)frame                            // toolbar的frame
                  contentType:(MHButtonContentType)contentType         // 按钮的内容类型
                 contentStyle:(MHButtonContentStyle)contentStyle       // 按钮的内容布局样式
              titleLabelScale:(CGFloat)titleLabelScale                 // 按钮上面titleLabel所占比例
                       border:(CGFloat)border                          // 按钮四周与内容控件的边界距离
                    midBorder:(CGFloat)midBorder                       // 按钮内部titleLabel与imageView之间的间距
                  titlesArray:(NSArray *)titlesArray                   // toolbar上面按钮的文字
                  imagesArray:(NSArray *)imagesArray;                  // toolbar上面按钮的图片

/**
 *  根据传递进来的文字数组创建一个toolbar,titleLabel的大小占据整个按钮的大小
 */
- (instancetype)initWithFrame:(CGRect)frame titlesArray:(NSArray *)titlesArray;

/**
 *  根据传递进来的图片数组创建一个toolbar,imageView的大小占据整个按钮的大小
 */
- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray *)titlesArray;
@end
