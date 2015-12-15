//
//  KPQRCodeCoverView.m
//  SZQRCodeCoverViewDemo
//
//  Created by 陈圣治 on 15/12/14.
//  Copyright © 2015年 shengzhichen. All rights reserved.
//

#import "SZQRCodeCoverView.h"

@interface SZQRCodeCoverView ()

@property (nonatomic, strong) UIImageView *detectionLineImageView;

@end

@implementation SZQRCodeCoverView

#pragma mark - property method -
- (void)setAreaRectWithoutCover:(CGRect)areaRectWithoutCover {
    _areaRectWithoutCover = areaRectWithoutCover;
    if (_detectionLineImageView) {
        [_detectionLineImageView removeFromSuperview];
        _detectionLineImageView = nil;
        [self detectionLineImageView];
    }
    [self setNeedsDisplay];
}

- (void)setCoverColor:(UIColor *)coverColor {
    _coverColor = coverColor;
    [self setNeedsDisplay];
}

- (void)setAnchorColor:(UIColor *)anchorColor {
    _anchorColor = anchorColor;
    [self setNeedsDisplay];
}

- (void)setAnchorLineLength:(CGFloat)anchorLineLength {
    _anchorLineLength = anchorLineLength;
    [self setNeedsDisplay];
}

- (void)setAnchorLineWidth:(CGFloat)anchorLineWidth {
    _anchorLineWidth = anchorLineWidth;
    [self setNeedsDisplay];
}

- (void)setPaddingBetweenAnchorAndNoFillAreaBorder:(CGFloat)paddingBetweenAnchorAndNoFillAreaBorder {
    _paddingBetweenAnchorAndNoFillAreaBorder = paddingBetweenAnchorAndNoFillAreaBorder;
    [self setNeedsDisplay];
}

- (void)setDetectionLineBackgroundColor:(UIColor *)detectionLineBackgroundColor {
    _detectionLineBackgroundColor = detectionLineBackgroundColor;
    if (_detectionLineImageView) {
        _detectionLineImageView.image = [self createDetectionLineImage];
    }
}

- (void)setDetectionLineFrontColor:(UIColor *)detectionLineFrontColor {
    _detectionLineFrontColor = detectionLineFrontColor;
    if (_detectionLineImageView) {
        _detectionLineImageView.image = [self createDetectionLineImage];
    }
}

- (void)setDetectionLineImage:(UIImage *)detectionLineImage {
    _detectionLineImage = detectionLineImage;
    if (_detectionLineImageView) {
        _detectionLineImageView.image = [self createDetectionLineImage];
    }
}

- (UIImageView *)detectionLineImageView {
    if (!_detectionLineImageView) {
        CGRect frame = CGRectMake(CGRectGetMinX(self.areaRectWithoutCover) + 5, CGRectGetMinY(self.areaRectWithoutCover) + 5, CGRectGetWidth(self.areaRectWithoutCover) - 10, 6);
        _detectionLineImageView = [[UIImageView alloc] initWithFrame:frame];
        if (!_detectionLineImage) {
            _detectionLineImageView.image = [self createDetectionLineImage];
        } else {
            _detectionLineImageView.image = _detectionLineImage;
        }
        _detectionLineImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_detectionLineImageView];
    }
    return _detectionLineImageView;
}

#pragma mark - life cycle -
- (void)commInit {
    self.opaque = NO;
    self.userInteractionEnabled = NO;
    
    _coverColor = [UIColor colorWithWhite:0 alpha:.3];
    _anchorColor = [UIColor colorWithRed:0.345 green:0.882 blue:0.000 alpha:1.000];
    _anchorLineLength = 15;
    _anchorLineWidth = 4;
    _paddingBetweenAnchorAndNoFillAreaBorder = 1 / [UIScreen mainScreen].scale;

    _detectionLineBackgroundColor = [UIColor colorWithRed:0.608 green:0.973 blue:0.090 alpha:1.000];
    _detectionLineFrontColor = [UIColor colorWithRed:0.835 green:0.988 blue:0.612 alpha:1.000];
    _animationDuration = 3;
    
    CGFloat defaultWidth = 180;
    _areaRectWithoutCover = CGRectMake(MAX(0, self.frame.size.width/2 - 150/2), MAX(0, self.frame.size.height/2 - 150/2), defaultWidth, defaultWidth);
}

- (instancetype)init {
    if (self = [super init]) {
        [self commInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commInit];
    }
    return self;
}

- (void)awakeFromNib {
    [self commInit];
}

- (void)drawRect:(CGRect)rect {
    self.opaque = NO;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, _coverColor.CGColor);
    CGContextFillRect(contextRef, rect);
    
    CGContextClearRect(contextRef, _areaRectWithoutCover);
    
    CGContextSetLineCap(contextRef, kCGLineCapSquare);
    CGContextSetLineWidth(contextRef, self.anchorLineWidth);
    CGContextSetStrokeColorWithColor(contextRef, self.anchorColor.CGColor);
    
    CGFloat x = self.areaRectWithoutCover.origin.x + self.paddingBetweenAnchorAndNoFillAreaBorder  + floor(self.anchorLineWidth/2);
    CGFloat y = self.areaRectWithoutCover.origin.y + self.paddingBetweenAnchorAndNoFillAreaBorder  + floor(self.anchorLineWidth/2);
    CGFloat maxX = CGRectGetMaxX(self.areaRectWithoutCover) - self.paddingBetweenAnchorAndNoFillAreaBorder - floor(self.anchorLineWidth/2);
    CGFloat maxY = CGRectGetMaxY(self.areaRectWithoutCover) - self.paddingBetweenAnchorAndNoFillAreaBorder - floor(self.anchorLineWidth/2);
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(x, y + self.anchorLineLength)];
        
        [bezierPath addLineToPoint:CGPointMake(x, y)];
        
        [bezierPath addLineToPoint:CGPointMake(x + self.anchorLineLength, y)];
        CGContextAddPath(contextRef, bezierPath.CGPath);
    }
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(maxX, y + self.anchorLineLength)];
        
        [bezierPath addLineToPoint:CGPointMake(maxX, y)];
        
        [bezierPath addLineToPoint:CGPointMake(maxX - self.anchorLineLength, y)];
        CGContextAddPath(contextRef, bezierPath.CGPath);
    }
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(maxX, maxY - self.anchorLineLength)];
        
        [bezierPath addLineToPoint:CGPointMake(maxX, maxY)];
        
        [bezierPath addLineToPoint:CGPointMake(maxX - self.anchorLineLength, maxY)];
        CGContextAddPath(contextRef, bezierPath.CGPath);
    }
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(x, maxY - self.anchorLineLength)];
        
        [bezierPath addLineToPoint:CGPointMake(x, maxY)];
        
        [bezierPath addLineToPoint:CGPointMake(x + self.anchorLineLength, maxY)];
        CGContextAddPath(contextRef, bezierPath.CGPath);
    }
    
    CGContextStrokePath(contextRef);
}

#pragma mark - public method -
- (void)startDetectionAnimation {
    [_detectionLineImageView.layer removeAllAnimations];
    
    CGRect frame = self.detectionLineImageView.frame;
    frame.origin = CGPointMake(CGRectGetMinX(self.areaRectWithoutCover) + 5, CGRectGetMinY(self.areaRectWithoutCover) + 5);
    self.detectionLineImageView.frame = frame;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = @(CGRectGetMinY(self.areaRectWithoutCover) + 5);
    animation.toValue = @(CGRectGetMaxY(self.areaRectWithoutCover) - 5);
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.duration = self.animationDuration;
    [self.detectionLineImageView.layer addAnimation:animation forKey:nil];
}

- (void)stopDetectionAnimation {
    CALayer *presentationLayer = _detectionLineImageView.layer.presentationLayer;
    _detectionLineImageView.frame = presentationLayer.frame;
    [_detectionLineImageView.layer removeAllAnimations];
}

#pragma mark - util -
- (UIImage *)createDetectionLineImage {
    CGFloat height = 4;
    CGFloat width = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(contextRef, CGSizeMake(0, 0), .5, [self.detectionLineBackgroundColor colorWithAlphaComponent:.8].CGColor);
    CGContextSetFillColorWithColor(contextRef, self.detectionLineBackgroundColor.CGColor);
    CGContextFillEllipseInRect(contextRef, CGRectMake(0.5, 0.5, width-1, height-1));
    
    CGContextSetShadowWithColor(contextRef, CGSizeMake(0, 0), .5, [self.detectionLineFrontColor colorWithAlphaComponent:.8].CGColor);
    CGContextSetFillColorWithColor(contextRef, self.detectionLineFrontColor.CGColor);
    CGContextFillEllipseInRect(contextRef, CGRectMake((width-2)/2, (height-1)/2, 2, 1));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
}

@end
