//
//  CustomAlertView.m
//  AlertDemo
//
//  Created by LvJianfeng on 15/12/23.
//  Copyright © 2015年 LvJianfeng. All rights reserved.
//

#import "CustomAlertView.h"

//配置默认参数
#define PADDINT_TOP_BOTTOM 15.f
#define CELL_HEIGHT 40.f
#define VIEW_WIDTH 300.f
#define MAX_VIEW_HEIGHT (SCREEN_HEIGHT-60.f)
#define MIN_VIEW_HEIGHT 40.f
#define TOOL_BUTTON_HEIGHT 60.F
//button 高度宽度
#define BUTTON_WIDTH (VIEW_WIDTH*0.5)-(PADDINT_TOP_BOTTOM*2)
#define BUTTON_HEIGHT (TOOL_BUTTON_HEIGHT-20.f)
@interface CustomAlertView() <UITableViewDataSource, UITableViewDelegate>
{
    CGRect viewFrame;
    NSIndexPath *tempIndexPath;
}
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) UIButton *doneButton;
@end

@implementation CustomAlertView

- (instancetype)initWithListData:(NSArray *)data{
    self.data = [NSArray new];
    self.data = data;
    //view高度计算
    CGFloat view_height = CELL_HEIGHT*data.count + TOOL_BUTTON_HEIGHT + PADDINT_TOP_BOTTOM*2;
    view_height = view_height > MAX_VIEW_HEIGHT ? MAX_VIEW_HEIGHT : view_height;
    //设置view frame
    viewFrame = CGRectMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5, 0, 0);
    //init
    self = [super initWithFrame:viewFrame];
    if (self) {
        //容器view（显示的自定义view）
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        //完成按钮背景view
        UIView *button_done_view = [[UIView alloc] initWithFrame:CGRectMake(0, view_height-TOOL_BUTTON_HEIGHT, VIEW_WIDTH*0.5, TOOL_BUTTON_HEIGHT)];
        button_done_view.backgroundColor = [UIColor whiteColor];
        [self addSubview:button_done_view];
        //设置按钮4分之一的布局
        UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(PADDINT_TOP_BOTTOM, (TOOL_BUTTON_HEIGHT-BUTTON_HEIGHT)*0.5, BUTTON_WIDTH, BUTTON_HEIGHT)];
        doneButton.backgroundColor = [UIColor blueColor];
        doneButton.layer.cornerRadius = BUTTON_HEIGHT/2;
        doneButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneButton setTitle:@"确认" forState:UIControlStateNormal];
        doneButton.tag = 999;
        [doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button_done_view addSubview:doneButton];
        self.doneButton = doneButton;
        
        //取消按钮背景view
        UIView *button_cancel_view = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH*0.5, view_height-TOOL_BUTTON_HEIGHT, VIEW_WIDTH*0.5, TOOL_BUTTON_HEIGHT)];
        button_cancel_view.backgroundColor = [UIColor whiteColor];
        [self addSubview:button_cancel_view];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(PADDINT_TOP_BOTTOM, (TOOL_BUTTON_HEIGHT-BUTTON_HEIGHT)*0.5, BUTTON_WIDTH, BUTTON_HEIGHT)];
        cancelButton.backgroundColor = [UIColor blueColor];
        cancelButton.layer.cornerRadius = BUTTON_HEIGHT/2;
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [button_cancel_view addSubview:cancelButton];
        
        //数据表
        
        UITableView *dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(PADDINT_TOP_BOTTOM, PADDINT_TOP_BOTTOM, VIEW_WIDTH - PADDINT_TOP_BOTTOM * 2, view_height - PADDINT_TOP_BOTTOM*2 - TOOL_BUTTON_HEIGHT)];
        dataTableView.backgroundColor = [UIColor whiteColor];
        dataTableView.layoutMargins = UIEdgeInsetsZero;
        dataTableView.delegate = self;
        dataTableView.dataSource = self;
        [self addSubview:dataTableView];
        self.dataTableView = dataTableView;
        [self.dataTableView reloadData];
        
        [UIView animateWithDuration:0.4 animations:^{
            [self setFrame:CGRectMake((SCREEN_WIDTH-VIEW_WIDTH)*0.5, (SCREEN_HEIGHT-view_height)*0.5, VIEW_WIDTH, view_height)];
        } completion:^(BOOL finished) {
        }];
        
    }
    return self;
}

#pragma mark 取消事件
- (void)cancelAction
{
    [UIView animateWithDuration:0.2 animations:^{
        [self setFrame:viewFrame];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark 确认事件
- (void)doneAction:(UIButton *)sender{
    if (self.tapDoneAction) {
        self.tapDoneAction(sender.tag);
    }
}
 
#pragma mark UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data) {
        return self.data.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlertViewTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALERTCELL"];
    if (!cell) {
        cell = [[AlertViewTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ALERTCELL"];
    }
    cell.tipLabel.text = self.data[indexPath.row];
    return cell;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlertViewTableCell *cell;
    if (tempIndexPath) {
        if (tempIndexPath != indexPath) {
            cell = (AlertViewTableCell *)[self.dataTableView cellForRowAtIndexPath:tempIndexPath];
            cell.selectedImage.image = [UIImage imageNamed:@"icon_big_unselect"];
        }
    }
    cell = (AlertViewTableCell *)[self.dataTableView cellForRowAtIndexPath:indexPath];
    cell.selectedImage.image = [UIImage imageNamed:@"icon_big_selected"];
    
    tempIndexPath = indexPath;
    //点击个将数组下标设置为确认按钮的tag值
    self.doneButton.tag = tempIndexPath.row;
}
@end


#pragma mark UITableViewCell
@implementation AlertViewTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        
        CGFloat width = (VIEW_WIDTH - PADDINT_TOP_BOTTOM * 2);
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, width - 40, 20)];
        tipLabel.font = [UIFont systemFontOfSize:15.f];
        tipLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:tipLabel];
        self.tipLabel = tipLabel;
        
        UIImageView *selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width-40, 10, 20, 20)];
        selectImageView.image = [UIImage imageNamed:@"icon_big_unselect"];
        [self.contentView addSubview:selectImageView];
        self.selectedImage =  selectImageView;
    }
    return self;
}

@end


