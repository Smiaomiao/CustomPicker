//
//  CustomPickerView.m
//  InvestApp
//
//  Created by fei du on 2017/4/5.
//  Copyright © 2017年 Zhangjc. All rights reserved.
//

#import "CustomPickerView.h"

#define LeftDistance 15
#define RightDistance -15
#define PickerHeight 200
#define TitleHeight 50
#define LeftBtnWidth 20
#define TitleFont 18

#define BgAlphaColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]
#define TitleColor [UIColor darkGrayColor]

#define CloseImg @""
#define ChooseImg @""

@interface CustomPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *pickerBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *chooseBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *resultMutArr;

@end

@implementation CustomPickerView

- (instancetype)initWithData:(NSArray *)dataArr withTitle:(NSString *)title withFirstChoose:(NSArray *)firstChooseArr{
    self = [super init];
    self.frame = CGRectMake(0, 0, kMainScreen_width, kMainScreen_height);

    
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.pickerBgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.closeBtn];
        [self.bgView addSubview:self.chooseBtn];
        [self.bgView addSubview:self.lineView];
        [self.bgView addSubview:self.picker];
        self.titleLabel.text = title;
        
        self.dataArr = [NSArray arrayWithArray:dataArr];
        self.resultMutArr = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.dataArr.count; i++) {
            [self.resultMutArr addObject:@"0"];
        }
        
        weak_self;
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wself);
        }];
        
        [self.pickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(wself.bgView);
            make.height.equalTo(@(PickerHeight));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(wself.pickerBgView);
            make.height.equalTo(@(TitleHeight));
        }];
        
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wself.titleLabel);
            make.left.equalTo(@(LeftDistance));
            make.width.height.equalTo(@(LeftBtnWidth));
        }];
        
        [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wself.titleLabel);
            make.right.equalTo(@(RightDistance));
            make.width.height.equalTo(wself.closeBtn);
        }];

        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(wself.titleLabel);
            make.height.equalTo(@(0.5));
        }];
        
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wself.titleLabel.mas_bottom).offset(-20);
            make.left.right.bottom.equalTo(wself.pickerBgView);
        }];
        
        UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closePicker:)];
        self.bgView.userInteractionEnabled = YES;
        [self.bgView addGestureRecognizer:tapBg];
        
        [self.closeBtn addTarget:self action:@selector(removePicker) forControlEvents:UIControlEventTouchUpInside];
        [self.chooseBtn addTarget:self action:@selector(choosePickerInfo) forControlEvents:UIControlEventTouchUpInside];
        
        
        for (int i = 0; i < firstChooseArr.count; i++) {
            NSString *resultstr = firstChooseArr[i];
            for (int j = 0; j < [self.dataArr[i] count]; j++) {
                NSString *string = self.dataArr[i][j];
                if ([string isEqualToString:resultstr]) {
                    [self.picker selectRow:j inComponent:i animated:YES];
                    [self.resultMutArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",j]];
                }
            }
            

        }
    }
    return self;
}

- (void)closePicker:(UITapGestureRecognizer *)tap{
    [self removePicker];
}

- (void)removePicker{
    [self removeFromSuperview];
}

- (void)choosePickerInfo{
    NSString *str = @"";
    for (int i = 0; i < self.dataArr.count; i++) {
        str = [str stringByAppendingString:self.dataArr[i][[self.resultMutArr[i] intValue]]];
    }
    self.chooseInfoBlock(str);
    [self removePicker];
}

#pragma mark UIPickerView DataSource Method 数据源方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataArr.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return [self.dataArr[component] count];
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = self.dataArr[component][row];
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.resultMutArr replaceObjectAtIndex:component withObject:[NSString stringWithFormat:@"%d",(int)row]];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = BgAlphaColor;
    }
    return _bgView;
}

- (UIView *)pickerBgView {
    if (!_pickerBgView) {
        _pickerBgView = [[UIView alloc]init];
        _pickerBgView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:TitleFont];
        _titleLabel.textColor = TitleColor;
        _titleLabel.text = @"";
         _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        if (CloseImg.length > 0) {
            [_closeBtn setBackgroundImage:[UIImage imageNamed:CloseImg] forState:UIControlStateNormal];
        } else {
            [_closeBtn setTitle:@"X" forState:UIControlStateNormal];
        }
    }
    return _closeBtn;
}

- (UIButton *)chooseBtn {
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        if (ChooseImg.length > 0) {
            [_chooseBtn setBackgroundImage:[UIImage imageNamed:ChooseImg] forState:UIControlStateNormal];
        } else {
            [_chooseBtn setTitle:@"√" forState:UIControlStateNormal];
        }
    }
    return _chooseBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc]init];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
