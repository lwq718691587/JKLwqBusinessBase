//
//  BGNetworkRequest+jkBusinessRequest.m
//  Pods
//
//  Created by 刘伟强 on 2017/6/12.
//
//

#import "BGNetworkRequest+jkBusinessRequest.h"

#import "JKBusinessHeader.h"

@implementation BGNetworkRequest (jkBusinessRequest)


- (void) requestBusinessLoadingCurrClass:(id  ) currClass
                                 success:( BGSuccessCompletionBlock)successCompletionBlock
                         businessFailure:( BGBusinessFailureBlock)businessFailureBlock
                     networkFailureBlock:( BGNetworkFailureBlock)networkFailureBlock{
    
    [self requestDataDefault:currClass type:HTTPRequestAlertViewTypeCustomAlertView allowCancel:YES showMessage:NO cusFrame:CGRectZero success:^BOOL(BGNetworkRequest *request, id response) {
        if (successCompletionBlock) {
            successCompletionBlock(request,response);
        }
        return NO;
    } businessFailure:^BOOL(BGNetworkRequest *request, id response) {
        if (businessFailureBlock) {
            businessFailureBlock(request,response);
        }
        return YES;
    } networkFailure:^BOOL(BGNetworkRequest *request, NSError *error) {
        if (networkFailureBlock) {
            networkFailureBlock(request,error);
        }
        return YES;
    }];

}


- (void) requestBusinessSVCurrClass:(id  ) currClass
                            success:( BGSuccessCompletionBlock)successCompletionBlock
                    businessFailure:( BGBusinessFailureBlock)businessFailureBlock
                networkFailureBlock:( BGNetworkFailureBlock)networkFailureBlock{
    
    [self requestDataDefault:currClass type:HTTPRequestAlertViewTypeSVP allowCancel:YES showMessage:YES cusFrame:CGRectZero success:^BOOL(BGNetworkRequest *request, id response) {
        if (successCompletionBlock) {
            successCompletionBlock(request,response);
        }
        return NO;
    } businessFailure:^BOOL(BGNetworkRequest *request, id response) {
        if (businessFailureBlock) {
            businessFailureBlock(request,response);
        }
        return NO;
    } networkFailure:^BOOL(BGNetworkRequest *request, NSError *error) {
        if (networkFailureBlock) {
            networkFailureBlock(request,error);
        }
        return NO;
    }];
}


- (void) requestBusinessNoneCurrClass:(id  ) currClass
                              success:( BGSuccessCompletionBlock)successCompletionBlock
                      businessFailure:( BGBusinessFailureBlock)businessFailureBlock
                  networkFailureBlock:( BGNetworkFailureBlock)networkFailureBlock{
    
    [self requestDataDefault:currClass type:HTTPRequestAlertViewTypeNone allowCancel:YES showMessage:NO cusFrame:CGRectZero success:^BOOL(BGNetworkRequest *request, id response) {
        if (successCompletionBlock) {
            successCompletionBlock(request,response);
        }
        return NO;
    } businessFailure:^BOOL(BGNetworkRequest *request, id response) {
        if (businessFailureBlock) {
            businessFailureBlock(request,response);
        }
        return NO;
    } networkFailure:^BOOL(BGNetworkRequest *request, NSError *error) {
        if (networkFailureBlock) {
            networkFailureBlock(request,error);
        }
        return NO;
    }];
}


- (void) requestBusinessNoneShowMsgCurrClass:(id) currClass
                                     success:(BGSuccessCompletionBlock )successCompletionBlock
                             businessFailure:(BGBusinessFailureBlock )businessFailureBlock
                         networkFailureBlock:(BGNetworkFailureBlock )networkFailureBlock{
    
    [self requestDataDefault:currClass type:HTTPRequestAlertViewTypeNone allowCancel:YES showMessage:YES cusFrame:CGRectZero success:^BOOL(BGNetworkRequest *request, id response) {
        if (successCompletionBlock) {
            successCompletionBlock(request,response);
        }
        return NO;
    } businessFailure:^BOOL(BGNetworkRequest *request, id response) {
        if (businessFailureBlock) {
            businessFailureBlock(request,response);
        }
        return NO;
    } networkFailure:^BOOL(BGNetworkRequest *request, NSError *error) {
        if (networkFailureBlock) {
            networkFailureBlock(request,error);
        }
        return NO;
    }];
}


@end
