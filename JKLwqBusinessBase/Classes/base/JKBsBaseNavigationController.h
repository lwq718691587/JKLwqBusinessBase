//
//  JKBaseNavigationController.h
//  JKBusinessBase
//
//  Created by 刘伟强 on 2017/6/7.
//  Copyright © 2017年 liuweiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKBsBaseNavigationController : UINavigationController


/**
 如果复写此方法 所有设置失效
 */
- (void)setNavTitleAndNavBackground;

@end
