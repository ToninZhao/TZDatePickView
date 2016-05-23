//
//  ViewController.m
//  TestChooseYearAndMonthView
//
//  Created by ToninZhao on 16/5/23.
//  Copyright © 2016年 ToninZhao. All rights reserved.
//

#import "ViewController.h"
#import "TZChooseYearAndMonthView.h"
@interface ViewController ()<TZChooseYearAndMonthViewDelegate>
/**
 *  显示选择的时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) TZChooseYearAndMonthView *chooseYearAndMonthView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TZChooseYearAndMonthView *chooseYearAndMonthView = [[TZChooseYearAndMonthView alloc] initWithFrame:self.view.bounds];
    chooseYearAndMonthView.maxYearAndMonth = @"2017-11";
    chooseYearAndMonthView.minYearAndMonth = @"1999-06";
    chooseYearAndMonthView.delegate = self;
    _chooseYearAndMonthView = chooseYearAndMonthView;
    chooseYearAndMonthView.hidden = YES;
    [self.view addSubview:chooseYearAndMonthView];
}


/**
 *  点击按钮选择时间
 */
- (IBAction)clickToChooseTime:(id)sender {
    _chooseYearAndMonthView.hidden = NO;
}
- (void)getSelectionTime:(NSString *)time
{
    _timeLabel.text = time;
}

@end
