//
//  JKBaseViewController.m
//  JKBusinessBase
//
//  Created by 刘伟强 on 2017/6/7.
//  Copyright © 2017年 liuweiqiang. All rights reserved.
//

#import "JKBsBaseViewController.h"
#import <JKUIBaseKit/JKUIBaseKit.h>
#import <JKBaseKit/JKBaseKit.h>
#import <JKNetWorking/JKNetWorking.h>
#import "JKBsSetting.h"


@interface JKBsBaseViewController ()


@end

@implementation JKBsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reqArr = [NSMutableArray array];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self setNavBackArrow];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView * v in self.view.subviews) {
        if ([v isKindOfClass:[UIScrollView class]] ) {
            if (@available(iOS 11.0, *)) {
                UIScrollView *sv = (UIScrollView *)v;
                if ([sv respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                    sv.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                }
            }
        }
    }
}

- (void)setNavBackArrow {
    
    if (global_bussiness_BackArrowBlock) {
        
        global_bussiness_BackArrowBlock(^void(UIImage *image ,CGFloat x){
            [self setBackArrowImage:image leftMargin:x action:@selector(navBackButtonClicked:)];
        });
        
    }else{
        UIImage *image = [UIImage jkImageName:@"btn_back" withClass:[JKBsBaseViewController class] bundleName:@"JKBusinessBase"];
        CGFloat leftMargin = 0;
        
        [self setBackArrowImage:image leftMargin:leftMargin action:@selector(navBackButtonClicked:)];
    }
}
    
- (void)navBackButtonClicked:(UIButton *)sender {
    for (BGNetworkRequest *req in self.reqArr) {
        [req cancelRequest];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNavTitle:(NSString *)title{
    [self setNavTitle:title color:jkHexColor(@"1a1a1a") font:[UIFont systemFontOfSize:18]];
}

- (void)creatNavigationBarButton:(NSString *)title
                           image:(UIImage *)image
                          action:(SEL )action
                         isRight:(BOOL)isRight{
    [self creatNavigationBarButton:title image:image titleColor:jkHexColor(@"1a1a1a") titleFont:[UIFont systemFontOfSize:14] action:action type:!isRight ? BarButton_Left : BarButton_Right];
}

/// 方法快捷提示
/**
 *  @brief 初始化View
 */
-(void)setupViews{}
/**
 *  @brief 初始化Data
 */
-(void)setupDatas{}
/**
 更新数据
 */
- (void)update{}


-(BOOL)shouldAutorotate{
    return NO;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    UIInterfaceOrientation orient = [[UIApplication sharedApplication] statusBarOrientation];
    if (orient != UIInterfaceOrientationPortrait) {
        orient = UIInterfaceOrientationPortrait;
    }
    return  UIInterfaceOrientationPortrait;
}


@end
