//
//  BGUploadImagesRequest+jkBusiness.h
//  JKControlSugar
//
//  Created by 刘伟强 on 2017/9/10.
//  Copyright © 2017年 JK. All rights reserved.
//

#import <JKNetWorking/JKNetWorking.h>

@interface BGUploadImagesRequest (jkBusiness)


- (void)sendRequestUploadImageSuccess:(BGSuccessCompletionBlock)successCompletionBlock businessFailure:(BGBusinessFailureBlock)businessFailureBlock networkFailure:(BGNetworkFailureBlock)networkFailureBlock ;

@end
