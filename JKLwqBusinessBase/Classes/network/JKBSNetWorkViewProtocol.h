//
//  JKBSNetWorkViewProtocol.h
//  Pods
//
//  Created by 刘伟强 on 2017/8/17.
//
//

#import <Foundation/Foundation.h>

typedef void (^JKRefresBlock)(void);


// 成功界面 无数据协议
@protocol BGRequestNODataViewProtocol <NSObject>

@required

- (void)setNoDataImage:(UIImage *)image;

- (void)setNoDataTitle:(NSString *)title;

@end

// 失败界面 协议
@protocol BGRequestResultViewProtocol <NSObject>

@optional

- (void) refreshReqeust:(JKRefresBlock  )refresBlock;

@end

//自定义loading 协议
@protocol BGRequestLoadingViewProtocol <NSObject>

@required

@property (nonatomic, assign) CGRect myFrame;

- (void)showView:(UIView *)superView;

- (void)hidenView;

@end

@protocol SettingNetWorkViewProtocol <NSObject>

@required

- (void) requestSetting:(UIView<BGRequestNODataViewProtocol> *) successView
       businessFailView:(UIView<BGRequestResultViewProtocol> *) businessFailView
        networkFailView:(UIView<BGRequestResultViewProtocol> *) networkFailView
            loadingView:(UIView<BGRequestLoadingViewProtocol> *) loadingView;


@end

