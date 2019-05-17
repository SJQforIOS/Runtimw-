//
//  ViewController.m
//  SendMsgDemo
//
//  Created by SJQ on 2018/1/18.
//  Copyright © 2018年 孙佳其. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UILabel *telephooneLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupTelephoneLabel];
}

- (void)setupTelephoneLabel
{
    _telephooneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 20)];
    _telephooneLabel.text = @"18895959595";
    _telephooneLabel.textColor = [UIColor blackColor];
    _telephooneLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_telephooneLabel];
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [_telephooneLabel addGestureRecognizer:labelTapGestureRecognizer];
    _telephooneLabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
}

- (void)labelClick
{
    //方法一
    //    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13888888888"]];
    //参数phones：发短信的手机号码的数组，数组中是一个即单发,多个即群发
    [self showMessageView:[NSArray arrayWithObjects:_telephooneLabel.text, nil] title:@"test" body:@"你是土豪么，么么哒"];
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - MFMessageComposeViewController

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
