//
//  BGNetworkRequest+jkAdditional.m
//  JKOnLiveModule
//
//  Created by A on 2017/6/1.
//  Copyright © 2017年 liuweiqiang. All rights reserved.
//

#import "BGNetworkRequest+jkAdditional.h"
#import <JKUIBaseKit/JKUIBaseKit.h>
#import <JKBaseKit/JKBaseKit.h>
#import "JKBusinessHeader.h"
#import "JKBsBaseViewController.h"
#import "JKBsSetting.h"
#import "NSObject+jkNetWorkView.h"


static const NSInteger BusinessFailViewTag  = 50001;
static const NSInteger NetworkFailViewTag   = 50002;
static const NSInteger SuccessViewTag       = 50003;

@implementation BGNetworkRequest(jkAdditional)


/**
 基础方法
 */
- (void) requestDataDefault:(id  ) currClass
                       type:(HTTPRequestAlertViewType)alertViewType
                allowCancel:(BOOL)isAllowCancel
                showMessage:(BOOL)showMessage
                   cusFrame:(CGRect)cusFrame
                    success:(JKBGSuccessCompletionBlock)successCompletionBlock
            businessFailure:(JKBGBusinessFailureBlock)businessFailureBlock
             networkFailure:(JKBGNetworkFailureBlock)networkFailureBlock{
    
    
    
    [self removeOldFailerView:currClass];
    [self addNetWorkView];
    
    CGFloat top = 0;
    CGRect frame;
    if ([currClass isKindOfClass:[UIViewController class]]) {
        UIViewController *currVC = currClass;
        if (currVC.navigationController && currVC.navigationController.navigationBarHidden
            == NO) {
            top = -64;
        }
    }
    
    if (CGRectEqualToRect(cusFrame, CGRectZero)) {
        frame = CGRectMake(0, top, jkScreenWidth, jkScreenHeight);
    }else{
        frame = cusFrame;
    }
    
    
    if (self.successView) self.successView.frame = frame;
    if (self.loadingView) self.loadingView.myFrame = frame;
    if (self.businessFailView) self.businessFailView.frame = frame;
    if (self.networkFailView) self.networkFailView.frame  = frame;
    
    
    if (alertViewType == HTTPRequestAlertViewTypeSVP) {
        [SVProgressHUD jk_show];
    } else if (alertViewType == HTTPRequestAlertViewTypeCustomAlertView) {
        
        if ([currClass isKindOfClass:[UIView class]]) {
            [self.loadingView showView:currClass];
        }
        if ([currClass isKindOfClass:[UIViewController class]]) {
            [self.loadingView showView:[currClass view]];
        }
        
    }
    
    #define RequestAlertViewDismiss                                            \
        if (alertViewType == HTTPRequestAlertViewTypeSVP) {                    \
            [SVProgressHUD jk_dismiss];                                        \
        } else if (alertViewType == HTTPRequestAlertViewTypeCustomAlertView) { \
            [self.loadingView hidenView];                                      \
        }                                                                      \
        [self.successView setHidden:true];                                     \
        [self.networkFailView setHidden:true];                                 \
        [self.businessFailView setHidden:true];                                \

    #define RequestDisplayView(displayView)                                    \
        if (displayView) {                                                     \
            if ([currClass isKindOfClass:[UIView class]]) {                    \
            [currClass  addSubview:displayView];                               \
        }                                                                      \
        if ([currClass isKindOfClass:[UIViewController class]]) {              \
            [[currClass view] addSubview:displayView];                         \
        }                                                                      \
        RequestRefresh(displayView, self.businessFailView);                    \
        RequestRefresh(displayView, self.networkFailView);                     \
        [displayView setHidden:false];                                         \
    }                                                                          \

    #define RequestRefresh(displayView, currView)                              \
        if (displayView == currView) {                                         \
        [displayView refreshReqeust:^{                                         \
        [self requestDataDefault:currClass                                     \
                            type:alertViewType                                 \
                     allowCancel:isAllowCancel                                 \
                     showMessage:showMessage                                   \
                        cusFrame:(CGRect)cusFrame                              \
                         success:successCompletionBlock                        \
                 businessFailure:businessFailureBlock                          \
                  networkFailure:networkFailureBlock];                         \
        }];                                                                    \
    }                                                                          \
    
    
    [self sendRequestWithSuccess:^(BGNetworkRequest *  request, id   response) {
        RequestAlertViewDismiss
        /// 添加成功界面
        if (successCompletionBlock && successCompletionBlock(request, response)) {
            
            if (self.successView) {
                self.successView.tag = SuccessViewTag;
                if ([currClass isKindOfClass:[UIView class]]) {
                    [currClass addSubview:self.successView];
                }
                if ([currClass isKindOfClass:[UIViewController class]]) {
                    [[currClass view] addSubview:self.successView];
                }
                
                [self.successView setHidden:false];
            }
        }
    } businessFailure:^(BGNetworkRequest *  request, id   response) {
        RequestAlertViewDismiss
        /// 添加失败界面
        if (businessFailureBlock && businessFailureBlock(request, response)) {
            self.businessFailView.tag = BusinessFailViewTag;
            RequestDisplayView(self.businessFailView)
        }
        
        if (showMessage) {
            
            id message = response[@"msg"];
            
            if ([message isKindOfClass:[NSDictionary class]] && message) {
                NSString * messageInfo = message[@"info"];
                if ([messageInfo isKindOfClass:[NSString class]]) {
                    [SVProgressHUD jk_showErrorWithStatus:messageInfo];
                }
            }
            
            if ([message isKindOfClass:[NSString class]] && message) {
                [SVProgressHUD jk_showErrorWithStatus:message];
            }
            
            NSString * errormsg = response[@"errormsg"];
            if (errormsg) {
                [SVProgressHUD jk_showErrorWithStatus:errormsg];
            }
            
        }
    } networkFailure:^(BGNetworkRequest *  request, NSError *  error) {
        RequestAlertViewDismiss
        
        /// 如果网络请求取消，则不做任何处理
        if (error.code == -999) return;
        /// 添加失败界面
        if (networkFailureBlock && networkFailureBlock(request,error)) {
            self.networkFailView.tag = NetworkFailViewTag;
            RequestDisplayView(self.networkFailView)
        }
        
        if (showMessage) [SVProgressHUD jk_showErrorWithStatus:@"网络错误"];
        
    }];
    
    if (isAllowCancel && [currClass isKindOfClass:[JKBsBaseViewController class]]) {
        [((JKBsBaseViewController *)currClass).reqArr addObject:self];
    }
}


- (void) requestDataDefault:(id ) currClass
                       type:(HTTPRequestAlertViewType )alertViewType
                    success:(JKBGSuccessCompletionBlock )successCompletionBlock
            businessFailure:(JKBGBusinessFailureBlock )businessFailureBlock
             networkFailure:(JKBGNetworkFailureBlock )networkFailureBlock {
    [self requestDataDefault:currClass type:alertViewType allowCancel:YES showMessage:NO cusFrame:CGRectZero success:successCompletionBlock businessFailure:businessFailureBlock networkFailure:networkFailureBlock];
}




- (void) requestDataDefault:(id ) currClass
                       type:(HTTPRequestAlertViewType)alertViewType
                   cusFrame:(CGRect)cusFrame
                    success:(JKBGSuccessCompletionBlock )successCompletionBlock
            businessFailure:(JKBGBusinessFailureBlock )businessFailureBlock
             networkFailure:(JKBGNetworkFailureBlock )networkFailureBlock{
    
    [self requestDataDefault:currClass type:alertViewType allowCancel:YES showMessage:NO cusFrame:cusFrame success:successCompletionBlock businessFailure:businessFailureBlock networkFailure:networkFailureBlock];
}


// 删除老的 失败的view
- (void)removeOldFailerView:(id)currClass{
    if ([currClass isKindOfClass:[UIViewController class]]) {
        if ([[currClass view] viewWithTag:BusinessFailViewTag]) {
            [[[currClass view] viewWithTag:BusinessFailViewTag] removeFromSuperview];
        }
        if ([[currClass view] viewWithTag:NetworkFailViewTag]) {
            [[[currClass view] viewWithTag:NetworkFailViewTag] removeFromSuperview];
        }
        if ([[currClass view] viewWithTag:SuccessViewTag]) {
            [[[currClass view] viewWithTag:SuccessViewTag] removeFromSuperview];
        }
    }
    if ([currClass isKindOfClass:[UIView class]]) {
        if ([currClass viewWithTag:BusinessFailViewTag]) {
            [[currClass viewWithTag:BusinessFailViewTag] removeFromSuperview];
        }
        if ([currClass viewWithTag:NetworkFailViewTag]) {
            [[currClass viewWithTag:NetworkFailViewTag] removeFromSuperview];
        }
        if ([currClass viewWithTag:SuccessViewTag]) {
            [[currClass viewWithTag:SuccessViewTag] removeFromSuperview];
        }
    }
}


@end
