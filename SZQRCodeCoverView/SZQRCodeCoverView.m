//
//  KPQRCodeCoverView.m
//  SZQRCodeCoverViewDemo
//
//  Created by 陈圣治 on 15/12/14.
//  Copyright © 2015年 shengzhichen. All rights reserved.
//

#import "SZQRCodeCoverView.h"

@interface SZQRCodeCoverView ()

@property (nonatomic, strong) UIImageView *scanLineImageView;

@end

@implementation SZQRCodeCoverView

#pragma mark - property method -
- (void)setAreaRectWithoutCover:(CGRect)areaRectWithoutCover {
    _areaRectWithoutCover = areaRectWithoutCover;
    if (_scanLineImageView) {
        [_scanLineImageView removeFromSuperview];
        _scanLineImageView = nil;
        [self scanLineImageView];
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

- (void)setScanLineBackgroundColor:(UIColor *)scanLineBackgroundColor {
    _scanLineBackgroundColor = scanLineBackgroundColor;
    if (_scanLineImageView) {
        _scanLineImageView.image = [self createScanLineImage];
    }
}

- (void)setScanLineFrontColor:(UIColor *)scanLineFrontColor {
    _scanLineFrontColor = scanLineFrontColor;
    if (_scanLineImageView) {
        _scanLineImageView.image = [self createScanLineImage];
    }
}

- (void)setScanLineImage:(UIImage *)scanLineImage {
    _scanLineImage = scanLineImage;
    if (_scanLineImageView) {
        _scanLineImageView.image = [self createScanLineImage];
    }
}

- (UIImageView *)scanLineImageView {
    if (!_scanLineImageView) {
        CGRect frame = CGRectMake(CGRectGetMinX(self.areaRectWithoutCover) + 5, CGRectGetMinY(self.areaRectWithoutCover) + 5, CGRectGetWidth(self.areaRectWithoutCover) - 10, 6);
        _scanLineImageView = [[UIImageView alloc] initWithFrame:frame];
        if (!_scanLineImage) {
            _scanLineImageView.image = [self createScanLineImage];
        } else {
            _scanLineImageView.image = _scanLineImage;
        }
        _scanLineImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_scanLineImageView];
    }
    return _scanLineImageView;
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

    _scanLineBackgroundColor = [UIColor colorWithRed:0.608 green:0.973 blue:0.090 alpha:1.000];
    _scanLineFrontColor = [UIColor colorWithRed:0.835 green:0.988 blue:0.612 alpha:1.000];
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
- (void)startScanAnimation {
    [_scanLineImageView.layer removeAllAnimations];
    
    CGRect frame = self.scanLineImageView.frame;
    frame.origin = CGPointMake(CGRectGetMinX(self.areaRectWithoutCover) + 5, CGRectGetMinY(self.areaRectWithoutCover) + 5);
    self.scanLineImageView.frame = frame;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = @(CGRectGetMinY(self.areaRectWithoutCover) + 5);
    animation.toValue = @(CGRectGetMaxY(self.areaRectWithoutCover) - 5);
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    animation.duration = self.animationDuration;
    [self.scanLineImageView.layer addAnimation:animation forKey:nil];
}

- (void)stopScanAnimation {
    [_scanLineImageView.layer removeAllAnimations];
}

#pragma mark - util -
- (UIImage *)createScanLineImage {
    CGFloat height = 4;
    CGFloat width = 3;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(contextRef, CGSizeMake(0, 0), .5, [self.scanLineBackgroundColor colorWithAlphaComponent:.8].CGColor);
    CGContextSetFillColorWithColor(contextRef, self.scanLineBackgroundColor.CGColor);
    CGContextFillEllipseInRect(contextRef, CGRectMake(0.5, 0.5, width-1, height-1));
    
    CGContextSetShadowWithColor(contextRef, CGSizeMake(0, 0), .5, [self.scanLineFrontColor colorWithAlphaComponent:.8].CGColor);
    CGContextSetFillColorWithColor(contextRef, self.scanLineFrontColor.CGColor);
    CGContextFillEllipseInRect(contextRef, CGRectMake((width-2)/2, (height-1)/2, 2, 1));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
}

@end
