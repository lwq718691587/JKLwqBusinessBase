//
//  JKBaseViewController.h
//  JKBusinessBase
//
//  Created by 刘伟强 on 2017/6/7.
//  Copyright © 2017年 liuweiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JKBsBaseViewController : UIViewController


/**
 存放请求的数组
 */
@property (strong, nonatomic) NSMutableArray *reqArr;

/**
 设置返回按钮的样式 如需改变请重写
 */
- (void)setNavBackArrow;


/**
 可以重写返回按钮的方法
 
 @param sender 返回按钮
 */
- (void)navBackButtonClicked:(UIButton *)sender;


/**
 设置导航栏title  默认 颜色为@"1a1a1a" 字号为18  如果修改 请重写

 @param title <#title description#>
 */
- (void)setNavTitle:(NSString *)title;


/**
 创建导航栏左右按钮  默认 颜色为@"1a1a1a" 字号为14  如果修改 请重写

 @param title 标题
 @param image 图片的名字
 @param action 方法
 @param isRight 是否是右边按钮
 */
- (void)creatNavigationBarButton:(NSString *)title
                           image:(UIImage *)image
                          action:(SEL )action
                         isRight:(BOOL)isRight;


/// 方法快捷提示
/**
 *  @brief 初始化View
 */
-(void)setupViews;
/**
 *  @brief 初始化Data 
 */
-(void)setupDatas;
/**
 更新数据
 */
- (void)update;

@end
