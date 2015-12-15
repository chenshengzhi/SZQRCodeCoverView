//
//  ViewController.m
//  SZQRCodeCoverViewDemo
//
//  Created by 陈圣治 on 15/12/14.
//  Copyright © 2015年 shengzhichen. All rights reserved.
//

#import "ViewController.h"
#import "SZQRCodeCoverView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SZQRCodeCoverView *coverView = [[SZQRCodeCoverView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:coverView];
    
    [coverView startScanAnimation];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
    [self.redView addGestureRecognizer:panGesture];
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint movement = [panGesture translationInView:panGesture.view];
        CGRect frame = panGesture.view.frame;
        frame.origin.x += movement.x;
        frame.origin.y += movement.y;
        panGesture.view.frame = frame;
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
    }
}

@end
