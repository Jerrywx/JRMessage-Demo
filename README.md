# JRMessage-Demo
### JRMessage-Demo 版本 0.1
#####信息提示框简单效果1
![(App01)](http://images2015.cnblogs.com/blog/757453/201512/757453-20151229224608510-977962469.gif)
#####信息提示框简单效果1
![(App01)](http://images2015.cnblogs.com/blog/757453/201512/757453-20151229224910932-1650552330.gif)

### JRMessage-Demo 版本 0.2
#####信息提示框简单效果1
![(App01)](http://images2015.cnblogs.com/blog/757453/201512/757453-20151230165913307-1756669393.gif)
#####信息提示框简单效果1
![(App01)](http://images2015.cnblogs.com/blog/757453/201512/757453-20151230165930026-11574586.gif)

```objective-c
/// 常用枚举
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
```
```objective-c
/// 常用属性
@property (nonatomic, assign)	BOOL				      isShow;			  			// 是否正在显示
@property (nonatomic, copy)		NSString			    *icon;		  				// 图标
@property (nonatomic, copy)		NSString			    *title;	  					// 标题
@property (nonatomic, copy)		NSString			    *subTitle;					// 描述
@property (nonatomic, assign)	JRMessageViewType	type;					    	// 类型
@property (nonatomic, assign)	CGFloat				    duration;				  	// 显示时间
```

```objective-c
/// 常用方法
/// 创建一个MessageView 添加到Controller
- (instancetype)initWithTitle:(NSString *)title
					 subTitle:(NSString *)subTitle
					 iconName:(NSString *)icon
				  messageType:(JRMessageViewType)type
			  messagePosition:(JRMessagePosition)position
					  superVC:(UIViewController *)superVC
					 duration:(CGFloat)duration;

/// 创建一个MessageView 添加到 window
- (instancetype)initWithTitle:(NSString *)title
					 subTitle:(NSString *)subTitle
					 iconName:(NSString *)icon
				  messageType:(JRMessageViewType)type
			  messagePosition:(JRMessagePosition)position
					 duration:(CGFloat)duration;

/// 显示一个 MessageView
- (void)showMessageView;
/// 隐藏 Messageview
- (void)hidedMessageView;
```
