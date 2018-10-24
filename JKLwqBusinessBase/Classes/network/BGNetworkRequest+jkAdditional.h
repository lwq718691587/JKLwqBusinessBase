//
//  BGNetworkRequest+jkAdditional.h
//  JKOnLiveModule
//
//  Created by A on 2017/6/1.
//  Copyright © 2017年 liuweiqiang. All rights reserved.
//

#import <JKNetWorking/JKNetWorking.h>
#import "JKBSNetWorkViewProtocol.h"

//取消请求的思路 是 想请求放到一个数组里，在用户点击返回按钮的时候取消调数组里的请求


typedef NS_ENUM(NSInteger, HTTPRequestAlertViewStyle) {
    HTTPRequestAlertViewStyleNormal,
    HTTPRequestAlertViewStyleSufferer,
    HTTPRequestAlertViewStyleDoctor,
};

typedef NS_ENUM(NSInteger, HTTPRequestAlertViewType) {
    HTTPRequestAlertViewTypeNone,
    HTTPRequestAlertViewTypeSVP,
    HTTPRequestAlertViewTypeCustomAlertView,
};

typedef BOOL (^JKBGSuccessCompletionBlock)(BGNetworkRequest  * request, id   response);
typedef BOOL (^JKBGBusinessFailureBlock)(BGNetworkRequest * request, id  response);
typedef BOOL (^JKBGNetworkFailureBlock)(BGNetworkRequest * request, NSError * error);



@interface BGNetworkRequest(jkAdditional)


@property (nonatomic, strong) UIView<BGRequestNODataViewProtocol> * successView;

@property (nonatomic, strong) UIView<BGRequestResultViewProtocol> * businessFailView;

@property (nonatomic, strong) UIView<BGRequestResultViewProtocol> * networkFailView;

@property (nonatomic, strong) UIView<BGRequestLoadingViewProtocol> * loadingView;


/**
 外部几乎不用 获取网络_基础
 
 @param currClass 当前controller 或 view
 @param alertViewType 弹框类型
 @param isAllowCancel 返回时 是否取消请求
 @param showMessage 是否展示SV 提示错误
 @param cusFrame 自定义loading的 frame
 @param successCompletionBlock 成功回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 @param businessFailureBlock   失败回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 @param networkFailureBlock    网络回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 */
- (void) requestDataDefault:(id  ) currClass
                       type:(HTTPRequestAlertViewType)alertViewType
                allowCancel:(BOOL)isAllowCancel
                showMessage:(BOOL)showMessage
                   cusFrame:(CGRect)cusFrame
                    success:(JKBGSuccessCompletionBlock)successCompletionBlock
            businessFailure:(JKBGBusinessFailureBlock)businessFailureBlock
             networkFailure:(JKBGNetworkFailureBlock)networkFailureBlock;

/**
 推荐 - 适用于 segment tableview 第一次显示加载动画 之后不显示
 @param currClass    controller 或 view
 @param alertViewType 弹出框的类型
 @param cusFrame 自定义loading的frame
 @param successCompletionBlock 成功回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 @param businessFailureBlock   失败回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 @param networkFailureBlock    网络回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 */
- (void) requestDataDefault:(id ) currClass
                       type:(HTTPRequestAlertViewType)alertViewType
                   cusFrame:(CGRect)cusFrame
                    success:(JKBGSuccessCompletionBlock)successCompletionBlock
            businessFailure:(JKBGBusinessFailureBlock)businessFailureBlock
             networkFailure:(JKBGNetworkFailureBlock)networkFailureBlock;

/**
 推荐 - 适用于 tableview 第一次显示加载动画 之后不显示
 @param currClass    当前所在的ViewController 必传
 @param alertViewType 弹出框的类型
 @param successCompletionBlock 成功回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 @param businessFailureBlock   失败回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 @param networkFailureBlock    网络回调 block 的返回值 控制 HTTPRequestAlertViewTypeCustomAlertView下 是否显示 业务页面
 */
- (void) requestDataDefault:(id ) currClass
                       type:(HTTPRequestAlertViewType)alertViewType
                    success:(JKBGSuccessCompletionBlock)successCompletionBlock
            businessFailure:(JKBGBusinessFailureBlock)businessFailureBlock
             networkFailure:(JKBGNetworkFailureBlock)networkFailureBlock;



@end
