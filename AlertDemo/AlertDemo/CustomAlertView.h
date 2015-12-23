//
//  CustomAlertView.h
//  AlertDemo
//
//  Created by LvJianfeng on 15/12/23.
//  Copyright © 2015年 LvJianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//get the size of the Screen
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface CustomAlertView : UIView

@property (weak, nonatomic) UITableView *dataTableView;
@property (copy, nonatomic) void (^tapDoneAction)(NSInteger tag);

- (instancetype)initWithListData:(NSArray *)data;
@end


#pragma mark UITableViewCell
@interface AlertViewTableCell : UITableViewCell

@property (weak, nonatomic) UILabel *tipLabel;
@property (weak, nonatomic) UIImageView *selectedImage;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end