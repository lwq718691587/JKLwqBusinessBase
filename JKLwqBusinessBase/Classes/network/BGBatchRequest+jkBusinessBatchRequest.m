//
//  BGBatchRequest+jkBusinessBatchRequest.m
//  Pods
//
//  Created by 刘伟强 on 2017/8/11.
//
//

#import "BGBatchRequest+jkBusinessBatchRequest.h"
#import "BGNetworkRequest+jkAdditional.h"
#import <JKUIBaseKit/JKUIBaseKit.h>
#import <JKBaseKit/JKBaseKit.h>
#import "JKBsSetting.h"
#import "NSObject+jkNetWorkView.h"

static const NSInteger BgBatchBusinessFailViewTag  = 60001;
static const NSInteger BgBatchNetworkFailViewTag   = 60002;
static const NSInteger BgBatchSuccessViewTag       = 60003;


@implementation BGBatchRequest (jkBusinessBatchRequest)


- (void)sendRequestBaseCurrentVC:(UIViewController *)currVC
                        cusframe:(CGRect)cusFrame
               isShowLoadingView:(BOOL )isShowLoadingView
                      completion:(void (^)(NSMutableArray<JKRequestAndResponse *> *responseArr))completionBlock{
    
    self.continueLoadWhenRequestFailure = NO;

    if (isShowLoadingView) {
        
        [self removeOldFailerView:currVC];
        
        [self addNetWorkView];
        
        CGFloat top = 0;
        if (currVC.navigationController && currVC.navigationController.navigationBarHidden
            == NO) {
            top = -64;
        }
        CGRect frame;
        if (CGRectEqualToRect(cusFrame, CGRectZero)) {
            frame = CGRectMake(0, top, jkScreenWidth, jkScreenHeight);
        }else{
            frame = cusFrame;
        }
        
        if (self.successView) self.successView.frame = frame;
        if (self.loadingView) self.loadingView.myFrame = frame;
        if (self.businessFailView) self.businessFailView.frame = frame;
        if (self.networkFailView) self.networkFailView.frame  = frame;
        
        [self.networkFailView refreshReqeust:^{
            [self sendRequestBaseCurrentVC:currVC cusframe:cusFrame isShowLoadingView:isShowLoadingView completion:completionBlock];
        }];
        
        [self.businessFailView refreshReqeust:^{
            [self sendRequestBaseCurrentVC:currVC cusframe:cusFrame isShowLoadingView:isShowLoadingView completion:completionBlock];
        }];
        
        self.businessFailView.hidden = self.networkFailView.hidden = YES;
        [self.loadingView showView:currVC.view];
    }
    
    
    __block NSMutableArray * responseArr = [NSMutableArray array];
    
    [self sendRequestSuccess:^(BGNetworkRequest * _Nonnull request, id  _Nullable response) {
        JKRequestAndResponse * rs = [[JKRequestAndResponse alloc]init];
        rs.request = request;
        rs.response = response;
        
        [responseArr addObject:rs];
        
    } completion:^(BGBatchRequest * _Nonnull batchRequest, BOOL isAllSuccess) {
        
        if (isAllSuccess) {
            if (isShowLoadingView) {
                [self.loadingView hidenView];
                self.businessFailView.hidden = self.networkFailView.hidden = YES;
            }
            completionBlock(responseArr);
        }
    }];
    @jkWeak(self);
    [self setBusinessFailure:^(BGNetworkRequest * _Nonnull request, id  _Nullable response) {
        if (isShowLoadingView) {
            [selfWeak.loadingView hidenView];
            selfWeak.businessFailView.tag = BgBatchBusinessFailViewTag;
            [currVC.view addSubview:selfWeak.businessFailView];
            selfWeak.businessFailView.hidden = selfWeak.networkFailView.hidden = NO;
        }

    } networkFailure:^(BGNetworkRequest * _Nonnull request, NSError * _Nullable error) {
        
        if (isShowLoadingView) {
            [selfWeak.loadingView hidenView];
            selfWeak.networkFailView.tag = BgBatchNetworkFailViewTag;
            [currVC.view addSubview:selfWeak.networkFailView];
            selfWeak.businessFailView.hidden = selfWeak.networkFailView.hidden = NO;
        }
    
    }];
}


- (void)sendRequestLoadingCurrentVC:(UIViewController *)currVC
                           cusframe:(CGRect)cusFrame
                         completion:(void (^)(NSMutableArray<JKRequestAndResponse *> *responseArr))completionBlock{
    
    [self sendRequestBaseCurrentVC:currVC cusframe:cusFrame isShowLoadingView:YES completion:completionBlock];
    
}


- (void)sendRequestLoadingCurrentVC:(UIViewController *)currVC
                         completion:(void (^)(NSMutableArray<JKRequestAndResponse *> *responseArr))completionBlock;{
    [self sendRequestBaseCurrentVC:currVC cusframe:CGRectZero isShowLoadingView:YES completion:completionBlock];
}

// 删除老的 失败的view
- (void)removeOldFailerView:(id)currClass{
    if ([currClass isKindOfClass:[UIViewController class]]) {
        if ([[currClass view] viewWithTag:BgBatchBusinessFailViewTag]) {
            [[[currClass view] viewWithTag:BgBatchBusinessFailViewTag] removeFromSuperview];
        }
        if ([[currClass view] viewWithTag:BgBatchNetworkFailViewTag]) {
            [[[currClass view] viewWithTag:BgBatchNetworkFailViewTag] removeFromSuperview];
        }
        if ([[currClass view] viewWithTag:BgBatchSuccessViewTag]) {
            [[[currClass view] viewWithTag:BgBatchSuccessViewTag] removeFromSuperview];
        }
    }
    if ([currClass isKindOfClass:[UIView class]]) {
        if ([currClass viewWithTag:BgBatchBusinessFailViewTag]) {
            [[currClass viewWithTag:BgBatchBusinessFailViewTag] removeFromSuperview];
        }
        if ([currClass viewWithTag:BgBatchNetworkFailViewTag]) {
            [[currClass viewWithTag:BgBatchNetworkFailViewTag] removeFromSuperview];
        }
        if ([currClass viewWithTag:BgBatchSuccessViewTag]) {
            [[currClass viewWithTag:BgBatchSuccessViewTag] removeFromSuperview];
        }
    }
}


@end

@implementation JKRequestAndResponse



@end

