//
//  BGUploadImagesRequest+jkBusiness.m
//  JKControlSugar
//
//  Created by 刘伟强 on 2017/9/10.
//  Copyright © 2017年 JK. All rights reserved.
//

#import "BGUploadImagesRequest+jkBusiness.h"
#import "JKBusinessHeader.h"

@implementation BGUploadImagesRequest (jkBusiness)

- (void)sendRequestUploadImageSuccess:(BGSuccessCompletionBlock)successCompletionBlock businessFailure:(BGBusinessFailureBlock)businessFailureBlock networkFailure:(BGNetworkFailureBlock)networkFailureBlock {
    
    [SVProgressHUD setContainerView:jkKeyWindow];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD showProgress:0 status:@"0%"];

    [self sendRequestWithProgress:^(NSProgress * _Nonnull uploadProgress) {
        //设置模式为进度框形的
        dispatch_async(dispatch_get_main_queue(), ^{
            
            CGFloat per = (CGFloat)uploadProgress.completedUnitCount/(CGFloat)uploadProgress.totalUnitCount;
            int perInt = per * 100;
            NSLog(@"%f",per);
            [SVProgressHUD showProgress:per status:[NSString stringWithFormat:@"%d%%",perInt]];
            if (per == 1) {
                [SVProgressHUD showWithStatus:@"正在处理"];
            }
        });
    } success:^(BGNetworkRequest * _Nonnull request, id  _Nullable response) {
        
        jkBLOCK_EXEC(successCompletionBlock,request,response);
        
    } businessFailure:^(BGNetworkRequest * _Nonnull request, id  _Nullable response) {
        
        id msg = response[@"msg"];
        
        if ([msg isKindOfClass:[NSDictionary class]] ) {
            NSString * str = msg[@"info"];
            if (str.length > 0) {
                AlertError(str);
            }
        }
        
        jkBLOCK_EXEC(businessFailureBlock,request,response);
        
    } networkFailure:^(BGNetworkRequest * _Nonnull request, NSError * _Nullable error) {
        AlertError(@"网络错误");
        jkBLOCK_EXEC(networkFailureBlock,request,error);
        
    }];

}



@end
