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
@property (nonatomic, strong) UIImageView	*iconView;
@property (nonatomic, assign) CGFloat		messageHeight;
@property (nonatomic, assign) CGFloat		iconWidth;

@property (nonatomic, strong) NSTimer		*timer;
@property (nonatomic, assign) NSTimeInterval timerInt;

@property (nonatomic, assign) CGFloat		messageOriginY;

@end

@implementation JRMessageView

- (instancetype)initWithTitle:(NSString *)title
					 subTitle:(NSString *)subTitle
					 iconName:(NSString *)icon
				  messageType:(JRMessageViewType)type
			  messagePosition:(JRMessagePosition)position
					  superVC:(UIViewController *)superVC
					 duration:(CGFloat)duration {
	
	self.messageLeft	= 15;
	self.messageTop		= 15;
	self.messageBottom	= 10;
	self.messageRight	= 10;
	self.iconWidth		= 30;
	self.messageHMargin = 10;
	self.messageVMargin = 2;
	
	self.title			= title;
	self.subTitle		= title;
	self.icon			= icon;
	self.viewController = superVC;
	self.duration		= duration;
	self.type			= type;
	self.messagePosition = position;
	
	if (self = [super init]) {
	
		if (self.title.length != 0) {

			self.titleLabel = [[UILabel alloc] init];
			self.titleLabel.text = title;
			self.titleLabel.font = [UIFont systemFontOfSize:14];
			[self.titleLabel sizeToFit];
			CGRect frame = self.titleLabel.frame;
			frame.size.width = SCREEN_W - (self.iconWidth + self.messageRight + self.messageHMargin * 2);
			frame.origin.x = self.messageRight + self.iconWidth + self.messageHMargin;
			frame.origin.y = self.messageTop;
			self.titleLabel.frame = frame;
			[self addSubview:self.titleLabel];
			
			self.titleLabel.backgroundColor = [UIColor yellowColor];
		}
		
		if (self.subTitle.length != 0) {
			
			CGRect frame = CGRectMake(self.messageRight + self.iconWidth + self.messageHMargin, CGRectGetMaxY(self.titleLabel.frame) + self.messageVMargin, self.titleLabel.frame.size.width, 40);
			self.subTitleLabel = [[UILabel alloc] init];
			self.subTitleLabel.font = [UIFont systemFontOfSize:12];
			self.subTitleLabel.numberOfLines = 0;
			self.subTitleLabel.text = subTitle;
			self.subTitleLabel.frame = frame;
			[self.subTitleLabel sizeToFit];
			[self addSubview:self.subTitleLabel];
			
			self.subTitleLabel.backgroundColor = [UIColor yellowColor];
			self.messageHeight = CGRectGetMaxY(self.subTitleLabel.frame) + 10;
		}
		
		if (self.icon.length != 0) {
			CGRect frame = CGRectMake(self.messageLeft, self.messageTop, self.iconWidth, self.iconWidth);
			self.iconView = [[UIImageView alloc] initWithFrame:frame];
			self.iconView.backgroundColor = [UIColor redColor];
			
			if (self.messageHeight < (CGRectGetMaxY(self.iconView.frame) + self.messageBottom)) {
				self.messageHeight = (CGRectGetMaxY(self.iconView.frame) + self.messageBottom);
			}
			
			[self addSubview:self.iconView];
		}
		
		if (self.messagePosition == JRMessagePositionTop) {
			self.messageOriginY = 64;
		} else if(self.messagePosition == JRMessagePositionNavBarOverlay) {
			self.messageOriginY = 0;
		} else if(self.messagePosition == JRMessagePositionBottom) {
			
			if (self.viewController.tabBarController) {
				self.messageOriginY = [UIScreen mainScreen].bounds.size.height - 49 - self.messageHeight;
			} else {
				self.messageOriginY = [UIScreen mainScreen].bounds.size.height - self.messageHeight;
			}
		}
		
		self.backgroundColor = [UIColor grayColor];
		[self.viewController.view addSubview:self];
	}
	return self;
}

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
}

- (void)showMessageView {

	if (self.isShow == NO) {
		
		self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(calc) userInfo:nil repeats:YES];
		self.timerInt = 0;
		[self.timer fire];
		
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
							 NSLog(@"------------- %@", NSStringFromCGRect(frame));
						 } completion:^(BOOL finished) {
							 
						 }];
	}
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
							 
						 }];
	}
}

- (void)calc {
	self.timerInt += 1;
	NSLog(@"------- %lf  --- %zd", self.timerInt, self.isShow);
	[self hidedMessageViewAuto];
}


@end






