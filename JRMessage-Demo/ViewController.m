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
@property (nonatomic, strong) JRMessageView *messgae4;
@property (nonatomic, strong) JRMessageView *messgae5;
@property (nonatomic, strong) JRMessageView *messgae6;

@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, strong) UILabel		*label1;
@property (nonatomic, strong) UILabel		*label2;

@property (nonatomic, strong) UIButton		*btn1;
@property (nonatomic, strong) UIButton		*btn2;
@property (nonatomic, strong) UIButton		*btn3;
@property (nonatomic, strong) UIButton		*btn4;
@property (nonatomic, strong) UIButton		*btn5;

@property (nonatomic, strong) UIButton		*btn6;
@property (nonatomic, strong) UIButton		*btn7;
@property (nonatomic, strong) UIButton		*btn8;
@property (nonatomic, strong) UIButton		*btn9;
@property (nonatomic, strong) UIButton		*btn0;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor whiteColor];
	
	self.scrollView = [[UIScrollView alloc] init];
	[self.view addSubview:self.scrollView];
	
	self.messgae1 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"subtitle ssubtitle s btitle "
												iconName:@"11"
											 messageType:JRMessageViewTypeSuccess
										 messagePosition:JRMessagePositionTop
												 superVC:self
												duration:3];
	
	self.messgae2 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"stle subti btit"
												iconName:@"11"
											 messageType:JRMessageViewTypeError
										 messagePosition:JRMessagePositionBottom
												 superVC:self
												duration:3];
	
	self.messgae3 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"stle sule sub te subtitle sub te subtitle sub te subtitle sub te subtitle sub tle s btit"
												iconName:@"11"
											 messageType:JRMessageViewTypeWarning
										 messagePosition:JRMessagePositionNavBarOverlay
												 superVC:self.navigationController
												duration:3];
	
	
	self.messgae4 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"subtitle ssubtitle s btitle "
												iconName:@"11"
											 messageType:JRMessageViewTypeSuccess
										 messagePosition:JRMessagePositionTop
												duration:3];
	
	self.messgae5 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"stle subti btit"
												iconName:@"11"
											 messageType:JRMessageViewTypeError
										 messagePosition:JRMessagePositionBottom
												duration:3];
	
	self.messgae6 = [[JRMessageView alloc] initWithTitle:@"title"
												subTitle:@"stle sule sub te subtitle sub te subtitle sub te subtitle sub te subtitle sub tle s btit"
												iconName:@"11"
											 messageType:JRMessageViewTypeWarning
										 messagePosition:JRMessagePositionNavBarOverlay
												duration:3];
	
	
	self.label1					= [[UILabel alloc]init];
	self.label1.textAlignment	= NSTextAlignmentCenter;
	self.label1.text			= @"Demo01-添加提示框到Controller中";
	[self.scrollView addSubview:self.label1];
	
	
	UIButton *btn1			= [[UIButton alloc] init];
	btn1.tag				= 1;
	btn1.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn1];
	[btn1 setTitle:@"JRMessagePositionTop" forState:UIControlStateNormal];
	[btn1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn1 = btn1;
	
	UIButton *btn2			= [[UIButton alloc] init];
	btn2.tag				= 2;
	btn2.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn2];
	[btn2 setTitle:@"JRMessagePositionBottom" forState:UIControlStateNormal];
	[btn2 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn2 = btn2;
	
	UIButton *btn3			= [[UIButton alloc] init];
	btn3.tag				= 3;
	btn3.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn3];
	[btn3 setTitle:@"JRMessagePositionNavBarOverlay" forState:UIControlStateNormal];
	[btn3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn3 = btn3;
	
	UIButton *btn4			= [[UIButton alloc] init];
	btn4.tag				= 4;
	btn4.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn4];
	[btn4 setTitle:@"Show All" forState:UIControlStateNormal];
	[btn4 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn4 = btn4;
	
	UIButton *btn5			= [[UIButton alloc] init];
	btn5.tag				= 5;
	btn5.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn5];
	[btn5 setTitle:@"Hided All" forState:UIControlStateNormal];
	[btn5 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn5 = btn5;
	
	self.label2					= [[UILabel alloc]init];
	self.label2.textAlignment	= NSTextAlignmentCenter;
	self.label2.text			= @"Demo02-添加提示框到Window中";
	[self.scrollView addSubview:self.label2];
	
	UIButton *btn6			= [[UIButton alloc] init];
	btn6.tag				= 6;
	btn6.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn6];
	[btn6 setTitle:@"JRMessagePositionTop" forState:UIControlStateNormal];
	[btn6 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn6 = btn6;

	UIButton *btn7			= [[UIButton alloc] init];
	btn7.tag				= 7;
	btn7.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn7];
	[btn7 setTitle:@"JRMessagePositionBottom" forState:UIControlStateNormal];
	[btn7 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn7 = btn7;
	
	

	UIButton *btn8			= [[UIButton alloc] init];
	btn8.tag				= 8;
	btn8.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn8];
	[btn8 setTitle:@"JRMessagePositionNavBarOverlay" forState:UIControlStateNormal];
	[btn8 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn8 = btn8;

	UIButton *btn9			= [[UIButton alloc] init];
	btn9.tag				= 9;
	btn9.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn9];
	[btn9 setTitle:@"Show All" forState:UIControlStateNormal];
	[btn9 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn9 = btn9;
	
	UIButton *btn0			= [[UIButton alloc] init];
	btn0.tag				= 10;
	btn0.backgroundColor	= [UIColor grayColor];
	[self.scrollView addSubview:btn0];
	[btn0 setTitle:@"Hided All" forState:UIControlStateNormal];
	[btn0 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
	self.btn0 = btn0;

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"PUSH"
																			  style:UIBarButtonItemStylePlain
																			 target:self
																			 action:@selector(openVC)];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	
	self.scrollView.frame = CGRectMake(0, 80, SCREEN_W, SCREEN_H - 100);
	self.scrollView.contentSize = CGSizeMake(SCREEN_W, 480);

	self.label1.frame	= CGRectMake(20, 0,	  SCREEN_W - 40, 30);
	self.btn1.frame		= CGRectMake(20, 40,  SCREEN_W - 40, 30);
	self.btn2.frame		= CGRectMake(20, 80,  SCREEN_W - 40, 30);
	self.btn3.frame		= CGRectMake(20, 120, SCREEN_W - 40, 30);
	self.btn4.frame		= CGRectMake(20, 160, SCREEN_W - 40, 30);
	self.btn5.frame		= CGRectMake(20, 200, SCREEN_W - 40, 30);
	
	self.label2.frame	= CGRectMake(20, 240, SCREEN_W - 40, 30);
	self.btn6.frame		= CGRectMake(20, 280, SCREEN_W - 40, 30);
	self.btn7.frame		= CGRectMake(20, 320, SCREEN_W - 40, 30);
	self.btn8.frame		= CGRectMake(20, 360, SCREEN_W - 40, 30);
	self.btn9.frame		= CGRectMake(20, 400, SCREEN_W - 40, 30);
	self.btn0.frame		= CGRectMake(20, 440, SCREEN_W - 40, 30);
}

- (void)openVC {
	TestViewController *test = [[TestViewController alloc] init];
	[self.navigationController pushViewController:test animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self openVC];
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
	} else if (button.tag == 6) {
		if (self.messgae4.isShow) {
			[self.messgae4 hidedMessageView];
		} else {
			[self.messgae4 showMessageView];
		}
	} else if (button.tag == 7) {
		if (self.messgae5.isShow) {
			[self.messgae5 hidedMessageView];
		} else {
			[self.messgae5 showMessageView];
		}
	} else if (button.tag == 8) {
		if (self.messgae6.isShow) {
			[self.messgae6 hidedMessageView];
		} else {
			[self.messgae6 showMessageView];
		}
	} else if (button.tag == 9) {
		[self.messgae4 showMessageView];
		[self.messgae5 showMessageView];
		[self.messgae6 showMessageView];
	} else if (button.tag == 10) {
		[self.messgae4 hidedMessageView];
		[self.messgae5 hidedMessageView];
		[self.messgae6 hidedMessageView];
	}
}

@end
