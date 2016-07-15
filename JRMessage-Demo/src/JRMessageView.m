//
//  JRMessageView.m
//  JRMessage-Demo
//
//  Created by wxiao on 15/12/28.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "JRMessageView.h"

#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
#define MESSAGE_H 60

@interface JRMessageView ()

@property (nonatomic, strong) UILabel		*titleLabel;
@property (nonatomic, strong) UILabel		*subTitleLabel;
@property (nonatomic, strong) UIButton		*iconView;
@property (nonatomic, assign) CGFloat		messageHeight;
@property (nonatomic, assign) CGFloat		iconWidth;

@property (nonatomic, strong) NSTimer		*timer;
@property (nonatomic, assign) NSTimeInterval timerInt;

@property (nonatomic, assign) CGFloat		messageOriginY;

@property (nonatomic, assign) CGPoint		startLoaction;
@property (nonatomic, assign) CGPoint		nowLoaction;
@property (nonatomic, assign) CGPoint		endLoaction;

@property (nonatomic, assign) CGFloat		messageMaxY;
@property (nonatomic, assign) CGFloat		messageSimY;
@property (nonatomic, assign) CGFloat		proPoint;

@end

@implementation JRMessageView

- (instancetype)init {
	if (self = [super init]) {
		self.messageLeft	= 15;
		self.messageTop		= 15;
		self.messageBottom	= 10;
		self.messageRight	= 10;
		self.iconWidth		= 30;
		self.messageHMargin = 10;
		self.messageVMargin = 2;
		
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(handleDeviceOrientationDidChange:)
													 name:UIDeviceOrientationDidChangeNotification
												   object:nil
		 ];
	}
	return self;
}

- (instancetype)initWithTitle:(NSString *)title
					 subTitle:(NSString *)subTitle
					 iconName:(NSString *)icon
				  messageType:(JRMessageViewType)type
			  messagePosition:(JRMessagePosition)position
					  superVC:(UIViewController *)superVC
					 duration:(CGFloat)duration {
	
	self.title			= title;
	self.subTitle		= title;
	self.icon			= icon;
	self.viewController = superVC;
	self.duration		= duration;
	self.type			= type;
	self.messagePosition = position;
	
	if (self = [self init]) {

		if (self.title.length != 0) {

			self.titleLabel			= [[UILabel alloc] init];
			self.titleLabel.text	= title;
			self.titleLabel.font	= [UIFont systemFontOfSize:14];
			[self.titleLabel sizeToFit];
			CGRect frame			= self.titleLabel.frame;
			frame.size.width		= SCREEN_W - (self.iconWidth + self.messageRight + self.messageHMargin * 2);
			frame.origin.x			= self.messageRight + self.iconWidth + self.messageHMargin;
			frame.origin.y			= self.messageTop;
			self.titleLabel.frame	= frame;
			self.titleLabel.textColor = [UIColor whiteColor];
			[self addSubview:self.titleLabel];
		}
		
		if (self.subTitle.length != 0) {
			
			CGRect frame				= CGRectMake(self.messageRight + self.iconWidth + self.messageHMargin, CGRectGetMaxY(self.titleLabel.frame) + self.messageVMargin, self.titleLabel.frame.size.width, 40);
			self.subTitleLabel			= [[UILabel alloc] init];
			self.subTitleLabel.font		= [UIFont systemFontOfSize:12];
			self.subTitleLabel.numberOfLines = 0;
			self.subTitleLabel.text		= subTitle;
			self.subTitleLabel.frame	= frame;
			self.subTitleLabel.textColor = [UIColor whiteColor];
			[self.subTitleLabel sizeToFit];
			[self addSubview:self.subTitleLabel];

			self.messageHeight = CGRectGetMaxY(self.subTitleLabel.frame) + 10;
		}
		
		if (self.icon.length != 0) {
			CGRect frame = CGRectMake(self.messageLeft, self.messageTop, self.iconWidth, self.iconWidth);
			self.iconView = [[UIButton alloc] initWithFrame:frame];
			if (self.messageHeight < (CGRectGetMaxY(self.iconView.frame) + self.messageBottom)) {
				self.messageHeight = (CGRectGetMaxY(self.iconView.frame) + self.messageBottom);
			}
			
			[self.iconView addTarget:self action:@selector(didClicked) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:self.iconView];
		}

		UIImage *image = nil;
		if (self.type == JRMessageViewTypeSuccess) {
			image = [UIImage imageNamed:@"icon-success"];
			self.backgroundColor = [UIColor greenColor];
		} else if (self.type == JRMessageViewTypeError) {
			self.backgroundColor = [UIColor redColor];
			image = [UIImage imageNamed:@"icon-error"];
		} else if (self.type == JRMessageViewTypeWarning || self.type == JRMessageViewTypeMessage) {
			image = [UIImage imageNamed:@"icon-info"];
			self.backgroundColor = [UIColor blueColor];
		} else if (self.type == JRMessageViewTypeCustom && self.icon.length != 0) {
			image = [UIImage imageNamed:self.icon];
		}
		[self.iconView setBackgroundImage:image forState:UIControlStateNormal];
		[self.iconView setBackgroundImage:image forState:UIControlStateHighlighted];

		[self.viewController.view addSubview:self];
		
		UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
		[self addGestureRecognizer:pan];
	
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
		[self addGestureRecognizer:tap];
		
//		self.hidden = YES;
	}
	return self;
}

- (instancetype)initWithTitle:(NSString *)title
					 subTitle:(NSString *)subTitle
					 iconName:(NSString *)icon
				  messageType:(JRMessageViewType)type
			  messagePosition:(JRMessagePosition)position
					 duration:(CGFloat)duration {
	
	self.title			= title;
	self.subTitle		= title;
	self.icon			= icon;
	self.duration		= duration;
	self.type			= type;
	self.messagePosition = position;
	
	if (self = [self init]) {
		
		if (self.title.length != 0) {
			
			self.titleLabel			= [[UILabel alloc] init];
			self.titleLabel.text	= title;
			self.titleLabel.font	= [UIFont systemFontOfSize:14];
			[self.titleLabel sizeToFit];
			CGRect frame			= self.titleLabel.frame;
			frame.size.width		= SCREEN_W - (self.iconWidth + self.messageRight + self.messageHMargin * 2);
			frame.origin.x			= self.messageRight + self.iconWidth + self.messageHMargin;
			frame.origin.y			= self.messageTop;
			self.titleLabel.frame	= frame;
			self.titleLabel.textColor = [UIColor whiteColor];
			[self addSubview:self.titleLabel];
		}
		
		if (self.subTitle.length != 0) {
			
			CGRect frame				= CGRectMake(self.messageRight + self.iconWidth + self.messageHMargin, CGRectGetMaxY(self.titleLabel.frame) + self.messageVMargin, self.titleLabel.frame.size.width, 40);
			self.subTitleLabel			= [[UILabel alloc] init];
			self.subTitleLabel.font		= [UIFont systemFontOfSize:12];
			self.subTitleLabel.numberOfLines = 0;
			self.subTitleLabel.text		= subTitle;
			self.subTitleLabel.frame	= frame;
			self.subTitleLabel.textColor = [UIColor whiteColor];
			[self.subTitleLabel sizeToFit];
			[self addSubview:self.subTitleLabel];
			
			self.messageHeight = CGRectGetMaxY(self.subTitleLabel.frame) + 10;
		}
		
		if (self.icon.length != 0) {
			CGRect frame = CGRectMake(self.messageLeft, self.messageTop, self.iconWidth, self.iconWidth);
			self.iconView = [[UIButton alloc] initWithFrame:frame];
			if (self.messageHeight < (CGRectGetMaxY(self.iconView.frame) + self.messageBottom)) {
				self.messageHeight = (CGRectGetMaxY(self.iconView.frame) + self.messageBottom);
			}
			
			[self.iconView addTarget:self action:@selector(didClicked) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:self.iconView];
		}
		
		UIImage *image = nil;
		if (self.type == JRMessageViewTypeSuccess) {
			image = [UIImage imageNamed:@"icon-success"];
			self.backgroundColor = [UIColor greenColor];
		} else if (self.type == JRMessageViewTypeError) {
			self.backgroundColor = [UIColor redColor];
			image = [UIImage imageNamed:@"icon-error"];
		} else if (self.type == JRMessageViewTypeWarning || self.type == JRMessageViewTypeMessage) {
			image = [UIImage imageNamed:@"icon-info"];
			self.backgroundColor = [UIColor blueColor];
		} else if (self.type == JRMessageViewTypeCustom && self.icon.length != 0) {
			image = [UIImage imageNamed:self.icon];
		}
		[self.iconView setBackgroundImage:image forState:UIControlStateNormal];
		[self.iconView setBackgroundImage:image forState:UIControlStateHighlighted];
		
//		[self.viewController.view addSubview:self];
		[[UIApplication sharedApplication].keyWindow addSubview:self];
		
		// 添加滑动手势
		UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
		[self addGestureRecognizer:pan];
		
		// 添加点击手势
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
		[self addGestureRecognizer:tap];
		
//		self.hidden = YES;
		self.userInteractionEnabled = YES;
	}
	return self;
}

// 屏幕方向监听
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation {
	[self layoutIfNeeded];
}

// 刷新布局
- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (self.messagePosition != JRMessagePositionBottom) {
		self.frame = CGRectMake(0, -self.messageHeight, SCREEN_W, self.messageHeight);
	} else {
		self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, self.messageHeight);
	}
	CGPoint center = self.iconView.center;
	center.y = self.messageHeight * 0.5;
	self.iconView.center = center;
	
	
	if (self.messagePosition == JRMessagePositionTop) {
		self.messageOriginY = 64;
		self.messageSimY = -self.messageHeight;
		self.messageMaxY = 64;
	} else if(self.messagePosition == JRMessagePositionNavBarOverlay) {
		self.messageOriginY = 0;
		self.messageSimY = -self.messageHeight;
		self.messageMaxY = 0;
	} else if(self.messagePosition == JRMessagePositionBottom) {
		if (self.viewController.tabBarController) {
			self.messageOriginY = [UIScreen mainScreen].bounds.size.height - 49 - self.messageHeight;
			self.messageSimY	= [UIScreen mainScreen].bounds.size.height - 49 - self.messageHeight;
			self.messageMaxY	= [UIScreen mainScreen].bounds.size.height;
		} else {
			self.messageOriginY = [UIScreen mainScreen].bounds.size.height - self.messageHeight;
			self.messageSimY	= [UIScreen mainScreen].bounds.size.height - self.messageHeight;
			self.messageMaxY	= [UIScreen mainScreen].bounds.size.height;
		}
	}
}

- (void)didClicked {
	[self hidedMessageView];
}

#pragma mark - Show/Hided Methond
- (void)showMessageView {

	self.startLoaction	= CGPointZero;
	self.endLoaction	= CGPointZero;
	self.nowLoaction	= CGPointZero;
	self.proPoint		= 0.0;

	if (self.isShow == NO) {
		self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calc) userInfo:nil repeats:YES];
		self.timerInt = 0;
		[self.timer fire];
//		self.hidden = NO;
		[UIView animateWithDuration:0.6
							  delay:0
			 usingSpringWithDamping:0.8
			  initialSpringVelocity:0.0
							options:UIViewAnimationOptionShowHideTransitionViews
						 animations:^{
							 self.isShow	= YES;
							 CGRect frame	= self.frame;
							 frame.origin.y = self.messageOriginY;
							 self.frame		= frame;
						 } completion:^(BOOL finished) {
							 
						 }];
	}
}

- (void)showMessageViewAuto {
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calc) userInfo:nil repeats:YES];
	self.timerInt = 0;
	[self.timer fire];
	//		self.hidden = NO;
	[UIView animateWithDuration:0.6
						  delay:0
		 usingSpringWithDamping:0.8
		  initialSpringVelocity:0.0
						options:UIViewAnimationOptionShowHideTransitionViews
					 animations:^{
						 self.isShow	= YES;
						 CGRect frame	= self.frame;
						 frame.origin.y = self.messageOriginY;
						 self.frame		= frame;
					 } completion:^(BOOL finished) {
						 
					 }];
}

- (void)hidedMessageView {
	
	if (self.isShow) {
		
		[self.timer invalidate];
		self.timer = nil;
		self.timerInt = 0;
		[UIView animateWithDuration:0.8
							  delay:0
			 usingSpringWithDamping:0.8
			  initialSpringVelocity:0
							options:UIViewAnimationOptionShowHideTransitionViews
						 animations:^{
							 self.isShow	= NO;
							 CGRect frame	= self.frame;
							 
							 if (self.messagePosition != JRMessagePositionBottom) {
								 frame.origin.y = -self.messageHeight;
							 } else {
								 frame.origin.y = SCREEN_H + self.messageHeight;
							 }
							 self.frame		= frame;
						 } completion:^(BOOL finished) {
//							 self.hidden = YES;
						 }];
	}
}

- (void)hidedMessageViewAuto {

	if (self.isShow && self.timerInt >= 4) {
		[self.timer invalidate];
		self.timer = nil;
		self.timerInt = 0;
		[UIView animateWithDuration:0.8
							  delay:0
			 usingSpringWithDamping:0.8
			  initialSpringVelocity:0
							options:UIViewAnimationOptionShowHideTransitionViews
						 animations:^{
							 self.isShow	= NO;
							 CGRect frame	= self.frame;
							 if (self.messagePosition != JRMessagePositionBottom) {
								 frame.origin.y = -self.messageHeight;
							 } else {
								 frame.origin.y = SCREEN_H + self.messageHeight;
							 }
							 self.frame		= frame;
						 } completion:^(BOOL finished) {
//							 self.hidden = YES;
						 }];
	}
}

- (void)calc {
	self.timerInt += 1;
	[self hidedMessageViewAuto];
}

#pragma mark - Did Some Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
}

- (void)tapAction:(id)sender {
}

- (void)panAction:(UIPanGestureRecognizer *)recognizer {
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		self.startLoaction = [recognizer locationInView:self.viewController.view];
		self.proPoint = self.startLoaction.y;
		[self.timer invalidate];
		self.timer = nil;
	}
	
	if (recognizer.state == UIGestureRecognizerStateChanged) {
		self.nowLoaction = [recognizer locationInView:self.viewController.view];
		
		self.proPoint = self.nowLoaction.y - self.proPoint;
		CGRect frame = self.frame;
		frame.origin.y = frame.origin.y + self.proPoint;
		
		if (frame.origin.y < self.messageMaxY && frame.origin.y > self.messageSimY) {
			self.frame = frame;
		}
		self.proPoint = self.nowLoaction.y;
	}
	
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		self.endLoaction = [recognizer locationInView:self.viewController.view];
		CGFloat longPan = self.endLoaction.y - self.startLoaction.y;
		if (longPan < 0) {
			longPan = -longPan;
		}
		if (longPan >= self.messageHeight * 0.35) {
			[self hidedMessageView];
		} else {
			[self showMessageViewAuto];
		}
	}
}

#pragma mark - Message View Dealloc
- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIDeviceOrientationDidChangeNotification
												  object:nil
	];
}

@end






