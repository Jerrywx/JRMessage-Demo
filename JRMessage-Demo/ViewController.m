//
//  ViewController.m
//  JRMessage-Demo
//
//  Created by wxiao on 15/12/28.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "ViewController.h"
#import "JRMessageView.h"
#import "TestViewController.h"

#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()
@property (nonatomic, strong) JRMessageView *message;
@property (nonatomic, strong) JRMessageView *messgae1;
@property (nonatomic, strong) JRMessageView *messgae2;
@property (nonatomic, strong) JRMessageView *messgae3;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];
	
	self.messgae1 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"subtitle ssubtitle s btitle "
												iconName:@"11"
											 messageType:0
										 messagePosition:JRMessagePositionTop
												 superVC:self
												duration:3];
	
	self.messgae2 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"stle subti btit"
												iconName:@"11"
											 messageType:0
										 messagePosition:JRMessagePositionBottom
												 superVC:self
												duration:3];
	
	self.messgae3 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"stle sule sub te subtitle sub te subtitle sub te subtitle sub te subtitle sub tle s btit"
												iconName:@"11"
											 messageType:0
										 messagePosition:JRMessagePositionNavBarOverlay
												 superVC:self.navigationController
												duration:3];

	UIButton *btn1			= [[UIButton alloc] initWithFrame:CGRectMake(20, 180, SCREEN_W - 40, 30)];
	btn1.tag				= 1;
	btn1.backgroundColor	= [UIColor grayColor];
	[self.view addSubview:btn1];
	[btn1 setTitle:@"JRMessagePositionTop" forState:UIControlStateNormal];
	[btn1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btn2			= [[UIButton alloc] initWithFrame:CGRectMake(20, 220, SCREEN_W - 40, 30)];
	btn2.tag				= 2;
	btn2.backgroundColor	= [UIColor grayColor];
	[self.view addSubview:btn2];
	[btn2 setTitle:@"JRMessagePositionBottom" forState:UIControlStateNormal];
	[btn2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btn3			= [[UIButton alloc] initWithFrame:CGRectMake(20, 260, SCREEN_W - 40, 30)];
	btn3.tag				= 3;
	btn3.backgroundColor	= [UIColor grayColor];
	[self.view addSubview:btn3];
	[btn3 setTitle:@"JRMessagePositionNavBarOverlay" forState:UIControlStateNormal];
	[btn3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btn4			= [[UIButton alloc] initWithFrame:CGRectMake(20, 300, SCREEN_W - 40, 30)];
	btn4.tag				= 4;
	btn4.backgroundColor	= [UIColor grayColor];
	[self.view addSubview:btn4];
	[btn4 setTitle:@"Show All" forState:UIControlStateNormal];
	[btn4 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *btn5			= [[UIButton alloc] initWithFrame:CGRectMake(20, 340, SCREEN_W - 40, 30)];
	btn5.tag				= 5;
	btn5.backgroundColor	= [UIColor grayColor];
	[self.view addSubview:btn5];
	[btn5 setTitle:@"Hided All" forState:UIControlStateNormal];
	[btn5 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	TestViewController *test = [[TestViewController alloc] init];
	[self.navigationController pushViewController:test animated:YES];
	
//	[self test2];
}

- (void)test1 {
	//	[UIView animateWithDuration:0.8 animations:^{
	//		CGRect frame = self.message.frame;
	//		frame.origin.y = 64;
	//		self.message.frame = frame;
	//	}];
	
	//	[UIView animateWithDuration:0.6
	//						  delay:0
	//						options:UIViewAnimationOptionOverrideInheritedOptions
	//					 animations:^{
	//						 CGRect frame = self.message.frame;
	//						 frame.origin.y = 64;
	//						 self.message.frame = frame;
	//	} completion:^(BOOL finished) {
	//
	//	}];
	
	[UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
		CGRect frame = self.message.frame;
		frame.origin.y = 64;
		self.message.frame = frame;
	} completion:^(BOOL finished) {
		
		[UIView animateWithDuration:0.8 delay:2 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
			CGRect frame = self.message.frame;
			frame.origin.y = -64;
			self.message.frame = frame;
		} completion:^(BOOL finished) {
		}];
	}];
}

- (void)test2 {
	[self.messgae2 showMessageView];
}

- (void)show:(UIButton *)button {
	button.selected = !button.selected;
	
	if (button.tag == 1) {
		if (self.messgae1.isShow) {
			[self.messgae1 hidedMessageView];
		} else {
			[self.messgae1 showMessageView];
		}
	} else if (button.tag == 2) {
		if (self.messgae2.isShow) {
			[self.messgae2 hidedMessageView];
		} else {
			[self.messgae2 showMessageView];
		}
	} else if (button.tag == 3) {
		if (self.messgae3.isShow) {
			[self.messgae3 hidedMessageView];
		} else {
			[self.messgae3 showMessageView];
		}
	} else if (button.tag == 4) {
		[self.messgae1 showMessageView];
		[self.messgae2 showMessageView];
		[self.messgae3 showMessageView];
	} else if (button.tag == 5) {
		[self.messgae1 hidedMessageView];
		[self.messgae2 hidedMessageView];
		[self.messgae3 hidedMessageView];
	}
}

@end
