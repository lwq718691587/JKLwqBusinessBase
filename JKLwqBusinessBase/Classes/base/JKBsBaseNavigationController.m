//
//  JKBaseNavigationController.m
//  JKBusinessBase
//
//  Created by 刘伟强 on 2017/6/7.
//  Copyright © 2017年 liuweiqiang. All rights reserved.
//

#import "JKBsBaseNavigationController.h"
#import <JKUIBaseKit/JKUIBaseKit.h>
@interface JKBsBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JKBsBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleAndNavBackground];
    // Do any additional setup after loading the view.
}

- (void)setNavTitleAndNavBackground{
    
    [self setNavBackgroundImage:[UIImage jkImageName:@"nav_bar" withClass:[JKBsBaseNavigationController class] bundleName:@"JKBusinessBase"]];
    
    [self setTitleColor:jkHexColor(@"343434") titleFont:[UIFont systemFontOfSize:18]];
    
    //设置返回手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        __weak typeof (self) weakSelf = self;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.interactivePopGestureRecognizer.enabled = YES;
    [UIApplication sharedApplication].statusBarHidden = NO;
}


-(BOOL)shouldAutorotate{
    return self.topViewController.shouldAutorotate;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.topViewController supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}


@end
