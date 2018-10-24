//
//  JKBusinessHeader.h
//  Pods
//
//  Created by A on 2017/6/8.
//
//

#ifndef JKBusinessHeader_h
#define JKBusinessHeader_h

#import <JKUIBaseKit/JKUIBaseKit.h>
#import <JKBaseKit/JKBaseKit.h>
#import "JKBsBaseViewController.h"
#import <objc/runtime.h>

#define jkbLoadPodImage(imageName)   [UIImage jkImageName:imageName withClass:[JKBsBaseViewController class] bundleName:@"JKBusinessBase"]

#define jkbLoadPodXib(xibName)       [NSClassFromString(xibName) jkPodLoadFromXibWithBundleName:@"JKBusinessBase"]


static inline void swizzle_stick(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    if (class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(originalClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#endif /* JKBusinessHeader_h */
