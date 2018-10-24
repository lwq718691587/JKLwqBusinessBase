//
//  BGNetworkRequest+jkBusinessRequest.h
//  Pods
//
//  Created by 刘伟强 on 2017/6/12.
//
//

#import <JKNetWorking/JKNetWorking.h>
#import "BGNetworkRequest+jkAdditional.h"

@interface BGNetworkRequest (jkBusinessRequest)


/**
 业务基础loading动画 和 业务基础失败页面 业务失败提示 离开页面取消请求

 @param currClass 当前所在的ViewController 必传
 @param successCompletionBlock 成功的block
 @param businessFailureBlock 业务失败的block 不需要任何操作 传nil
 @param networkFailureBlock  网络失败的block 不需要任何操作 传nil
 */
- (void) requestBusinessLoadingCurrClass:(id) currClass
                                 success:(BGSuccessCompletionBlock )successCompletionBlock
                         businessFailure:(BGBusinessFailureBlock )businessFailureBlock
                     networkFailureBlock:(BGNetworkFailureBlock )networkFailureBlock;

/**
 SV加载 SV提示

 @param currClass 当前所在的ViewController 必传
 @param successCompletionBlock 成功的block
 @param businessFailureBlock 业务失败的block 如果不需要任何操作传nil
 @param networkFailureBlock  网络失败的block 如果不需要任何操作传nil
 */
- (void) requestBusinessSVCurrClass:(id) currClass
                            success:(BGSuccessCompletionBlock )successCompletionBlock
                    businessFailure:(BGBusinessFailureBlock )businessFailureBlock
                networkFailureBlock:(BGNetworkFailureBlock )networkFailureBlock;

/**
 没有加载动画 没有 任何提示 静默请求使用
 
 @param currClass 当前所在的ViewController 必传
 @param successCompletionBlock 成功的block
 @param businessFailureBlock 业务失败的block 如果不需要任何操作传nil
 @param networkFailureBlock  网络失败的block 如果不需要任何操作传nil
 */
- (void) requestBusinessNoneCurrClass:(id) currClass
                              success:(BGSuccessCompletionBlock )successCompletionBlock
                      businessFailure:(BGBusinessFailureBlock )businessFailureBlock
                  networkFailureBlock:(BGNetworkFailureBlock )networkFailureBlock;



/**
  没有加载动画 有网络失败和业务失败的提示

 @param currClass 当前所在的ViewController 必传
 @param successCompletionBlock 成功的block
 @param businessFailureBlock 业务失败的block 如果不需要任何操作传nil
 @param networkFailureBlock  网络失败的block 如果不需要任何操作传nil
 */
- (void) requestBusinessNoneShowMsgCurrClass:(id) currClass
                                     success:(BGSuccessCompletionBlock )successCompletionBlock
                             businessFailure:(BGBusinessFailureBlock )businessFailureBlock
                         networkFailureBlock:(BGNetworkFailureBlock )networkFailureBlock;



@end
