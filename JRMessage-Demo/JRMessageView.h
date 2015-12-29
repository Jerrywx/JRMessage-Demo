//
//  JRMessageView.h
//  JRMessage-Demo
//
//  Created by wxiao on 15/12/28.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Message Type
typedef NS_ENUM(NSInteger, JRMessageViewType) {
	JRMessageViewTypeMessage = 0,			// 信息
	JRMessageViewTypeSuccess,				// 成功
	JRMessageViewTypeError,					// 错误
	JRMessageViewTypeWarning,				// 警告
	JRMessageViewTypeCustom					// 自定义
};

///  Message Position
typedef NS_ENUM(NSInteger, JRMessagePosition) {
	JRMessagePositionTop = 0,
	JRMessagePositionNavBarOverlay,
	JRMessagePositionBottom
};

@interface JRMessageView : UIView


@property (nonatomic, assign)	BOOL				isShow;						//
@property (nonatomic, copy)		NSString			*icon;						// 图标
@property (nonatomic, copy)		NSString			*title;						// 标题
@property (nonatomic, copy)		NSString			*subTitle;					// 描述
@property (nonatomic, assign)	JRMessageViewType	type;						// 类型
@property (nonatomic, strong)	UIViewController	*viewController;			// 控制器
//@property (nonatomic, assign)	CGFloat				messageHeight;				// 高度
@property (nonatomic, assign)	CGFloat				duration;					// 显示时间

@property (nonatomic, assign)	CGFloat				messageTop;					//
@property (nonatomic, assign)	CGFloat				messageLeft;
@property (nonatomic, assign)	CGFloat				messageBottom;
@property (nonatomic, assign)	CGFloat				messageRight;
@property (nonatomic, assign)	CGFloat				messageHMargin;
@property (nonatomic, assign)	CGFloat				messageVMargin;

@property (nonatomic, assign)	JRMessagePosition	messagePosition;			// 位置

- (instancetype)initWithTitle:(NSString *)title
					 subTitle:(NSString *)subTitle
					 iconName:(NSString *)icon
				  messageType:(JRMessageViewType)type
			  messagePosition:(JRMessagePosition)position
					  superVC:(UIViewController *)superVC
					 duration:(CGFloat)duration;

- (instancetype)initWithTitle:(NSString *)title
					 subTitle:(NSString *)subTitle
					 iconName:(NSString *)icon
				  messageType:(JRMessageViewType)type
			  messagePosition:(JRMessagePosition)position
					  window:(UIWindow *)window
					 duration:(CGFloat)duration;

- (void)showMessageView;

- (void)hidedMessageView;

@end
