## 自定义弹出view
### view 中展示数组数据，使用简单，可扩展性强。

### git展示
![](https://github.com/LvJianfeng/AlertView/blob/master/AlertDemo/1.gif "") 

## 使用
将*CustomAlertView.h*跟*CustomAlertView.m*文件Add到你的工程中即可。
Controller中调用

        CustomAlertView *alertView = [[CustomAlertView alloc] initWithListData:languages];
        alertView.tapDoneAction = ^(NSInteger tag){
            if (tag==999) {
                NSLog(@"999:你没有选择啊",tag);
            }else{
                NSLog(@"你选中的数据在数组中下标-->Array[index=%ld]",tag);
            }
        };
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:alertView];
  
  
😂😂😂

