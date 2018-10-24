//
//  NSObject+jkNetWorkView.m
//  Pods
//
//  Created by 刘伟强 on 2017/8/17.
//
//

#import "NSObject+jkNetWorkView.h"
#import <objc/runtime.h>
#import <JKBaseKit/JKBaseKit.h>
#import "JKBsSetting.h"

@implementation NSObject (jkNetWorkView)

#pragma mark -  Property Runtime       Source : POP -> POPAnimationInternal.h

#define JK_Runtime_Property_Key(methodkey) static const NSString *methodkey = @#methodkey
#define JK_Property_Key(methodkey) @#methodkey

#define JK_Runtime_Property_SET(target, key, method, type, OBJCType)                 \
- (void) method (type)value {                                                        \
objc_setAssociatedObject(target,(__bridge const void *)(key),value, OBJCType);    \
}

#define JK_Runtime_Property_GET(target, key, method, returnValue)                    \
- (returnValue) method {                                                             \
return objc_getAssociatedObject(target,(__bridge const void *)(key));            \
}

#define JK_Runtime_Property(target, method, setMethod, returnValue, OBJCType)        \
JK_Runtime_Property_GET(target, JK_Property_Key(method##key), method, returnValue)   \
JK_Runtime_Property_SET(target, JK_Property_Key(method##key), setMethod, returnValue, OBJCType)

JK_Runtime_Property(self, successView, setSuccessView:, UIView *, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
JK_Runtime_Property(self, businessFailView, setBusinessFailView:, UIView *, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
JK_Runtime_Property(self, networkFailView, setNetworkFailView:, UIView *, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
JK_Runtime_Property(self, loadingView, setLoadingView:, UIView *, OBJC_ASSOCIATION_RETAIN_NONATOMIC)


- (void) requestSetting:(UIView<BGRequestNODataViewProtocol> *) successView
       businessFailView:(UIView<BGRequestResultViewProtocol> *) businessFailView
        networkFailView:(UIView<BGRequestResultViewProtocol> *) networkFailView
            loadingView:(UIView<BGRequestLoadingViewProtocol> *) loadingView{
    self.successView      = successView;
    self.businessFailView = businessFailView;
    self.networkFailView  = networkFailView;
    self.loadingView      = loadingView;
}

- (void)addNetWorkView{
    jkBLOCK_EXEC(global_bussiness_requestSettingBlock, self);
}

@end
