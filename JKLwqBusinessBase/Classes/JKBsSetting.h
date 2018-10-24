//
//  JKBsRequestSetting.h
//  JKBusinessBase
//
//  Created by 刘伟强 on 2017/10/26.
//

#import <Foundation/Foundation.h>
#import "JKBSNetWorkViewProtocol.h"

typedef void(^RequestSettingRegisteringBlock)(id<SettingNetWorkViewProtocol> obj);
UIKIT_EXTERN RequestSettingRegisteringBlock global_bussiness_requestSettingBlock;

typedef void(^SettingBackArrowBlock)(void(^backArrowBlock)(UIImage *image,CGFloat leftMargin));
UIKIT_EXTERN SettingBackArrowBlock global_bussiness_BackArrowBlock;


@interface JKBsSetting : NSObject

+ (void) requestSettingBlock:(RequestSettingRegisteringBlock ) block;

+ (void) settingBackArrow:(SettingBackArrowBlock) block;

@end
