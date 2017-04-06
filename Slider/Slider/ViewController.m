//
//  ViewController.m
//  Slider
//
//  Created by fei du on 2017/4/6.
//  Copyright © 2017年 fei du. All rights reserved.
//

#import "ViewController.h"
#import "CustomPickerView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) CustomPickerView *customPicker;
@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.resultLabel];
    
    weak_self;
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(wself.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wself.btn.mas_top).offset(-20);
        make.left.right.equalTo(wself.view);
        make.height.equalTo(@(30));
    }];

    [self.btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showPicker {
    self.customPicker = [[CustomPickerView alloc]initWithData:@[@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"],@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"],@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"],@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"]] withTitle:@"性别" withFirstChoose:@[@"5",@"2",@"3",@"4"]];
    [self.view addSubview:self.customPicker];
    
    
    weak_self;
    self.customPicker.chooseInfoBlock = ^(NSString *result) {
        wself.resultLabel.text = result;
    };
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btn setTitle:@"显示picker" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _btn;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc]init];
        _resultLabel.textColor = [UIColor blackColor];
        _resultLabel.font = [UIFont systemFontOfSize:14];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        _resultLabel.text = @"选择结果";
    }
    return _resultLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
