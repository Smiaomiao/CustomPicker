//
//  CustomPickerView.h
//  InvestApp
//
//  Created by fei du on 2017/4/5.
//  Copyright © 2017年 Zhangjc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
picker确定按钮点击事件
 */
typedef void(^ChoosePickerInfo)(NSString *result);

@interface CustomPickerView : UIView

@property (nonatomic, copy) ChoosePickerInfo chooseInfoBlock;

/**
 创建picker
 dataArr 表示要显示的数据源 以数组的形式传入@[@[],@[],@{]]
 title   表示要显示在picker上的内容
 firstChooseArr 表示默认选择项 默认选择第一项
 */
- (instancetype)initWithData:(NSArray *)dataArr withTitle:(NSString *)title withFirstChoose:(NSArray *)firstChooseArr;

@end
