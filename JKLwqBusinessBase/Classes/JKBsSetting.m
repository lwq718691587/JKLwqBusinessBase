//
//  JKBsRequestSetting.m
//  JKBusinessBase
//
//  Created by 刘伟强 on 2017/10/26.
//

#import "JKBsSetting.h"

RequestSettingRegisteringBlock  global_bussiness_requestSettingBlock;

SettingBackArrowBlock           global_bussiness_BackArrowBlock;

@implementation JKBsSetting

+ (void) requestSettingBlock: (RequestSettingRegisteringBlock _Null_unspecified) block {
    global_bussiness_requestSettingBlock = block;
}

+(void)settingBackArrow:(SettingBackArrowBlock)block{
    global_bussiness_BackArrowBlock = block;
}

@end
