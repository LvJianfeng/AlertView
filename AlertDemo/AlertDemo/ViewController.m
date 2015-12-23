//
//  ViewController.m
//  AlertDemo
//
//  Created by LvJianfeng on 15/12/23.
//  Copyright © 2015年 LvJianfeng. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"



@interface ViewController ()
{
    NSArray *languages;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    languages = [[NSArray alloc] initWithObjects:@"语言1", @"语言2", @"语言3", @"语言4", @"语言5", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)touchAction:(id)sender {
    
    //点击弹出view
    CustomAlertView *alertView = [[CustomAlertView alloc] initWithListData:languages];
    alertView.tapDoneAction = ^(NSInteger tag){
        if (tag==999) {
            NSLog(@"999:你没有选择啊",tag);
        }else{
            NSLog(@"你选中的数据在数组中下标-->Array[index=%ld]",tag);
        }
        
    };
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:alertView];
    
}

@end
