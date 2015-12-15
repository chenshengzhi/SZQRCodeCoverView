//
//  KPQRCodeCoverView.h
//  SZQRCodeCoverViewDemo
//
//  Created by 陈圣治 on 15/12/14.
//  Copyright © 2015年 shengzhichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZQRCodeCoverView : UIView

@property (nonatomic) CGRect areaRectWithoutCover;

@property (nonatomic, strong) UIColor *coverColor;

@property (nonatomic, strong) UIColor *anchorColor;
@property (nonatomic) CGFloat anchorLineLength;
@property (nonatomic) CGFloat anchorLineWidth;

@property (nonatomic) CGFloat paddingBetweenAnchorAndNoFillAreaBorder;

@property (nonatomic, strong) UIColor *detectionLineBackgroundColor;
@property (nonatomic, strong) UIColor *detectionLineFrontColor;

@property (nonatomic, strong) UIImage *detectionLineImage;

@property (nonatomic) CGFloat animationDuration;

- (void)startDetectionAnimation;

- (void)stopDetectionAnimation;

@end
