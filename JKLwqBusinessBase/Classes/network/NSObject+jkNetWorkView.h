//
//  NSObject+jkNetWorkView.h
//  Pods
//
//  Created by 刘伟强 on 2017/8/17.
//
//

#import <Foundation/Foundation.h>

#import "JKBSNetWorkViewProtocol.h"

@interface NSObject (jkNetWorkView)

@property (nonatomic, strong) UIView<BGRequestNODataViewProtocol> * successView;

@property (nonatomic, strong) UIView<BGRequestResultViewProtocol> * businessFailView;

@property (nonatomic, strong) UIView<BGRequestResultViewProtocol> * networkFailView;

@property (nonatomic, strong) UIView<BGRequestLoadingViewProtocol> * loadingView;

- (void)addNetWorkView;

@end
