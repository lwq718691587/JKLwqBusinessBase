//
//  BGBatchRequest+jkBusinessBatchRequest.h
//  Pods
//
//  Created by 刘伟强 on 2017/8/11.
//
//

#import <JKNetWorking/JKNetWorking.h>
@class JKRequestAndResponse;

@interface BGBatchRequest (jkBusinessBatchRequest)


/**
 多个网络请求 异步发送 基础 不常用
 
 @param currVC <#currVC description#>
 @param cusFrame <#cusFrame description#>
 @param isShowLoadingView 是否展示 loading 动画
 @param completionBlock <#completionBlock description#>
 */
- (void)sendRequestBaseCurrentVC:(UIViewController *)currVC
                        cusframe:(CGRect)cusFrame
               isShowLoadingView:(BOOL )isShowLoadingView
                      completion:(void (^)(NSMutableArray<JKRequestAndResponse *> *responseArr))completionBlock;

/**
 多个网络请求 异步发送 带loading动画 自定义加载动画的frame
 
 @param currVC <#currVC description#>
 @param cusFrame <#cusFrame description#>
 @param completionBlock <#completionBlock description#>
 */
- (void)sendRequestLoadingCurrentVC:(UIViewController *)currVC
                           cusframe:(CGRect)cusFrame
                         completion:(void (^)(NSMutableArray<JKRequestAndResponse *> *responseArr))completionBlock;


/**
  多个网络请求 异步发送 带loading动画 加载动画frame为全屏自适应

 @param currVC <#currVC description#>
 @param completionBlock <#completionBlock description#>
 */
- (void)sendRequestLoadingCurrentVC:(UIViewController *)currVC
                         completion:(void (^)(NSMutableArray<JKRequestAndResponse *> *responseArr))completionBlock;

@end


@class BGNetworkRequest;

@interface JKRequestAndResponse : NSObject
/**
 请求信息
 */
@property (nonatomic,strong)  BGNetworkRequest *request;

/**
 请求结果
 */
@property (nonatomic,strong)  id response;

@end
