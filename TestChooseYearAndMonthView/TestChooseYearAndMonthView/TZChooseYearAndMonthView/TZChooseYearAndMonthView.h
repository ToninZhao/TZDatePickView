//
//  TZChooseYearAndMonthView.h
//
//  Created by Tonin on 16/5/13.
//  Copyright © 2016年 TZmf. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  只能选择年和月的pickView, 视图默认高度280, 宽度为屏幕的宽
 */
@protocol TZChooseYearAndMonthViewDelegate <NSObject>

- (void)getSelectionTime:(NSString *)time;

@end
@interface TZChooseYearAndMonthView : UIView

@property (nonatomic, weak) id<TZChooseYearAndMonthViewDelegate> delegate;
/**
 *  将datePicker暴露出去,可以修改datePicker属性
 */
@property (nonatomic, weak) UIPickerView *datePicker;
/**
 *  最小年限 默认1970-01
 */
@property (nonatomic, copy) NSString *minYearAndMonth;
/**
 *  最大年限 默认2030-12
 */
@property (nonatomic, copy) NSString *maxYearAndMonth;
@end
