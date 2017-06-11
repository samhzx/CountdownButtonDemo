/*---------------------------------------------------------------------
 文件名称 : CountdownButton.h
 创建作者 : sam
 创建时间 : 2017/6/10
 文件描述 :
 版权信息 : Created by sam on 2017/6/10.
 ---------------------------------------------------------------------*/


#import <UIKit/UIKit.h>

@class CountdownButton;

typedef NSString *(^TitleBlock)(CountdownButton *sender,NSUInteger time);
typedef NSString *(^TimeOver)(CountdownButton *sender);
@interface CountdownButton : UIButton
#pragma mark - 普通属性
/**
 返回当前title
 */
@property (nonatomic, copy)  TitleBlock titleCall;
/**
 倒计时结束回调
 */
@property (nonatomic, copy)  TimeOver finishCall;

/**
 倒计时从多少秒开始
 */
@property (nonatomic, assign) IBInspectable NSUInteger second;

/**
 开始倒计时
 */
@property (nonatomic, assign, getter = isFire)  BOOL fire;
#pragma mark - 数据模型属性
#pragma mark - 视图属性
#pragma mark - 方法
@end
