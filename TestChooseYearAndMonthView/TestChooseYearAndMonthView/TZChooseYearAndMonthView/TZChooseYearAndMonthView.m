//
//  TZChooseYearAndMonthView.m
//
//  Created by Tonin on 16/5/13.
//  Copyright © 2016年 TZmf. All rights reserved.
//

#import "TZChooseYearAndMonthView.h"

@interface TZChooseYearAndMonthView()<UIPickerViewDelegate, UIPickerViewDataSource>
/**
 *  屏幕的宽
 */
#define TZScreenBoundsWidth [UIScreen mainScreen].bounds.size.width

/**
 *  屏幕的高
 */
#define TZScreenBoundsHeight [UIScreen mainScreen].bounds.size.height
/**
 *  视图高度
 */
#define DatePickViewHeight 280

/**
 *  记录选择的时间
 */
@property (nonatomic, copy) NSString *dateStr;
/**
 *  记录选择的年份
 */
@property (nonatomic, assign) NSInteger selectedYear;
/**
 *  记录选择的月份
 */
@property (nonatomic, assign) NSInteger selectedMonth;
/**
 *  记录现在的年份
 */
@property (nonatomic, assign) NSInteger nowYear;
/**
 *  记录现在的月份
 */
@property (nonatomic, assign) NSInteger nowMonth;

/**
 *  最小年份
 */
@property (nonatomic, assign) NSInteger minYear;
/**
 *  最小月份
 */
@property (nonatomic, assign) NSInteger minMonth;
/**
 *  最大年份
 */
@property (nonatomic, assign) NSInteger maxYear;
/**
 *  最大月份
 */
@property (nonatomic, assign) NSInteger maxMonth;
@end
@implementation TZChooseYearAndMonthView
- (void)setMinYearAndMonth:(NSString *)minYearAndMonth
{
    _minYearAndMonth = minYearAndMonth;
    NSArray *array = [minYearAndMonth componentsSeparatedByString:@"-"];
    _minYear = [array[0] integerValue];
    _minMonth = [array[1] integerValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _nowYear = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
    
    [dateFormatter setDateFormat:@"MM"];
    _nowMonth = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
    
    [_datePicker selectRow:(_nowYear - _minYear) inComponent:0 animated:YES];
    _selectedYear = _nowYear;
    [_datePicker selectRow:_nowMonth - 1 inComponent:1 animated:YES];
    _selectedMonth = _nowMonth;
    
}
- (void)setMaxYearAndMonth:(NSString *)maxYearAndMonth
{
    _maxYearAndMonth = maxYearAndMonth;
    NSArray *array = [maxYearAndMonth componentsSeparatedByString:@"-"];
    _maxYear = [array[0] integerValue];
    _maxMonth = [array[1] integerValue];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpChildView];
    }
    return self;
}
#pragma mark - 创建子视图
- (void)setUpChildView
{
    self.backgroundColor = [UIColor clearColor];
    //点击其他区,隐藏时间选择器
    UIButton *hideBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, TZScreenBoundsWidth, TZScreenBoundsHeight - DatePickViewHeight)];
    hideBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [hideBtn addTarget:self action:@selector(hideDateView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hideBtn];
    
    //时间选择器view
    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0, TZScreenBoundsHeight - DatePickViewHeight, TZScreenBoundsWidth, DatePickViewHeight)];
    dateView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dateView];
    
    self.minYearAndMonth = @"1970-01";
    self.maxYearAndMonth = @"2030-12";
    
    UIPickerView *datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, TZScreenBoundsWidth, DatePickViewHeight - 30)];
    _datePicker = datePicker;
    datePicker.delegate = self;
    datePicker.dataSource = self;
    [dateView addSubview:datePicker];
    
    //dataPicker上方的按钮视图
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TZScreenBoundsWidth, 30)];
    btnView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1];
    [dateView addSubview:btnView];
    
    /**
     取消按钮
     */
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    cancleBtn.backgroundColor = [UIColor clearColor];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor colorWithRed:100 / 255.0 green:186 / 255.0 blue:204 / 255.0 alpha:1] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hideDateView) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:cancleBtn];
    
    /**
     确定按钮
     */
    UIButton *doBtn = [[UIButton alloc]initWithFrame:CGRectMake(TZScreenBoundsWidth - 50, 0, 40, 30)];
    doBtn.backgroundColor = [UIColor clearColor];
    [doBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doBtn setTitleColor:[UIColor colorWithRed:100 / 255.0 green:186 / 255.0 blue:204 / 255.0 alpha:1] forState:UIControlStateNormal];
    [doBtn addTarget:self action:@selector(doChoooseTime) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:doBtn];
    
}
#pragma mark - pickerView 代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger numberOfRows = 0;
    switch (component) {
        case 0:
            numberOfRows = _maxYear - _minYear + 1;
            break;
        case 1:
            numberOfRows = 12;
            break;
        default:
            break;
    }
    return numberOfRows;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *titleStr;
    switch (component) {
        case 0:
            titleStr = [NSString stringWithFormat:@"%04ld", _minYear + row];
            break;
        case 1:
            titleStr = [NSString stringWithFormat:@"%02ld", 1 + row];
            break;
        default:
            break;
    }
    return titleStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        _selectedYear = _minYear + row;
        if (_selectedYear == _minYear) {
            [pickerView selectRow:(_minMonth - 1) inComponent:1 animated:YES];
            _selectedMonth = _minMonth;
        }else
        {
            [pickerView selectRow:0 inComponent:1 animated:YES];
            _selectedMonth = 1;
        }

    }else if(component == 1)
    {
        _selectedMonth = 1 + row;
        /**
         *  限制选择时间的逻辑,用户可自行选择.列如:今天是2016-05 不能选择2016-06,如果选择2016-06,自动回滚2016-05
         */
        if (_selectedYear == _maxYear && _selectedMonth > _maxMonth) {
            [pickerView selectRow:(_maxMonth - 1) inComponent:1 animated:YES];
            _selectedMonth = _maxMonth;
        }
        if (_selectedYear == _minYear && _selectedMonth < _minMonth) {
            [pickerView selectRow:(_minMonth - 1) inComponent:1 animated:YES];
            _selectedMonth = _minMonth;
        }
    }
}
#pragma mark - 隐藏view
- (void)hideDateView
{
    self.hidden = YES;
}
#pragma mark - 显示View
- (void)showSelectView
{
    self.hidden = NO;
}
- (void)doChoooseTime
{
    self.hidden = YES;
    
    if ([self.delegate respondsToSelector:@selector(getSelectionTime:)]) {
        [self.delegate getSelectionTime:[NSString stringWithFormat:@"%ld-%02ld", _selectedYear, _selectedMonth]];
    }
}

@end
