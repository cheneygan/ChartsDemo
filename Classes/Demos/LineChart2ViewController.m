//
//  LineChart2ViewController.m
//  ChartsDemo
//
//  Created by Daniel Cohen Gindi on 17/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

#import "LineChart2ViewController.h"
#import "ChartsDemo-Swift.h"

@interface LineChart2ViewController () <ChartViewDelegate>

@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;
@property (nonatomic, strong) NSMutableArray *xVals ;
@property (nonatomic, strong) NSMutableArray *dataSets;

@end

@implementation LineChart2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Line Chart 2 Chart";
    
    self.options = @[
                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                     @{@"key": @"toggleFilled", @"label": @"Toggle Filled"},
                     @{@"key": @"toggleCircles", @"label": @"Toggle Circles"},
                     @{@"key": @"toggleCubic", @"label": @"Toggle Cubic"},
                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                     @{@"key": @"toggleStartZero", @"label": @"Toggle StartZero"},
                     @{@"key": @"animateX", @"label": @"Animate X"},
                     @{@"key": @"animateY", @"label": @"Animate Y"},
                     @{@"key": @"animateXY", @"label": @"Animate XY"},
                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
                     ];
    
    _chartView.delegate = self;
    
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"You need to provide data for the chart.";
    
    _chartView.highlightEnabled = YES;
    _chartView.dragEnabled = YES;
    //[_chartView setScaleEnabled:YES];
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.pinchZoomEnabled = NO;
    _chartView.scaleXEnabled = NO;
    _chartView.scaleYEnabled = NO;
    _chartView.highlightEnabled = false;
    
    //_chartView.backgroundColor = [UIColor colorWithWhite:204/255.f alpha:1.f];
    _chartView.backgroundColor = [UIColor whiteColor];
    
//    _chartView.legend.form = ChartLegendFormLine;
//    _chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
//    _chartView.legend.textColor = UIColor.whiteColor;
//    _chartView.legend.position = ChartLegendPositionBelowChartLeft;
    
    BalloonMarker *marker = [[BalloonMarker alloc] initWithColor:[UIColor colorWithWhite:180/255. alpha:0.5] font:[UIFont systemFontOfSize:8.0] insets: UIEdgeInsetsMake(6.0, 6.0, 15.0, 6.0)];
    //BalloonMarker *marker = [[BalloonMarker alloc] init];
    marker.minimumSize = CGSizeMake(40.f, 20.f);
   
    _chartView.marker = marker;
    
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    //xAxis.labelTextColor = UIColor.whiteColor;
    xAxis.drawGridLinesEnabled = NO;
//    xAxis.drawAxisLineEnabled = YES;
   // xAxis.spaceBetweenLabels = 1.0;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    [xAxis setAvoidFirstLastClippingEnabled:TRUE];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    //leftAxis.labelTextColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    leftAxis.customAxisMax = 252.0;
    leftAxis.customAxisMin = 80.0;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    [leftAxis setYOffset:-5];
    _chartView.leftAxis.startAtZeroEnabled =NO;

    
//
   ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled =NO;
//    rightAxis.labelTextColor = UIColor.redColor;
//    rightAxis.customAxisMax = 900.0;
//    rightAxis.startAtZeroEnabled = NO;
//    rightAxis.customAxisMin = -200.0;
//    rightAxis.drawGridLinesEnabled = NO;
    
//    _sliderX.value = 19.0;
//    _sliderY.value = 30.0;
   [self slidersValueChanged:nil];
    
    [_chartView animateWithXAxisDuration:1];
    
    for (LineChartDataSet *set in _chartView.data.dataSets)
    {
        set.drawFilledEnabled = TRUE;
        set.drawCubicEnabled =false;
    }
    
    [_chartView setNeedsDisplay];
    
    
   // [_chartView.legend setPosition:ChartLegendPositionLeftOfChartCenter]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDataCount:(int)count range:(double)range
{
    self.xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [self.xVals addObject:months[i % 30]];
    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = 50 ;
        double val = (double) (arc4random_uniform(mult)) + 150.01;
        [yVals addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"沪深300指数"];
    set1.axisDependency = AxisDependencyLeft;
    [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [set1 setCircleColor:UIColor.whiteColor];
    set1.lineWidth = 2.0;
    set1.circleRadius = 3.0;
    set1.fillAlpha = 65/255.0;
    set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set1.drawCircleHoleEnabled = YES;
    set1.drawValuesEnabled = NO;
    set1.drawCirclesEnabled = NO;
    
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = 50;
        double val = (double) (arc4random_uniform(mult)) + 100.02;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithYVals:yVals2 label:@"华夏大盘精选"];
    set2.axisDependency = AxisDependencyLeft;
    [set2 setColor:UIColor.redColor];
    [set2 setCircleColor:UIColor.whiteColor];
    set2.lineWidth = 2.0;
    set2.circleRadius = 3.0;
    set2.fillAlpha = 65/255.0;
    set2.fillColor = UIColor.redColor;
    set2.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set2.drawCircleHoleEnabled = NO;
    set2.drawValuesEnabled = NO;
    set2.drawCirclesEnabled = NO;
    [set2 setHighlightColor:[UIColor blueColor]];
    //set2.isHorizontalHighlightIndicatorEnabled = NO;
    
    self.dataSets =  [[NSMutableArray alloc] init];
  
    [self.dataSets addObject:set2];
    [self.dataSets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc] initWithXVals:self.xVals dataSets:self.dataSets];
    [data setValueTextColor:UIColor.whiteColor];
    [data setValueFont:[UIFont systemFontOfSize:9.f]];
    
    _chartView.data = data;
}



#pragma mark - Actions

- (IBAction)slidersValueChanged:(id)sender
{
//    _sliderTextX.text = [@((int)_sliderX.value + 1) stringValue];
//    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
    [self setDataCount:30 range:4];
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
   // NSLog(@"chartValueSelected, Index:%d,Value:%f",entry.xIndex,entry.value );
    LineChartDataSet * dataSet300 = (LineChartDataSet *)[self.dataSets objectAtIndex:0];
    LineChartDataSet * dataSetDP = (LineChartDataSet *)[self.dataSets objectAtIndex:1];
    ChartDataEntry * entry1 = (ChartDataEntry*)[dataSet300.yVals objectAtIndex:entry.xIndex];
    ChartDataEntry * entry2 = (ChartDataEntry*)[dataSetDP.yVals objectAtIndex:entry.xIndex];
    
    NSString *xLable = (NSString *)[self.xVals objectAtIndex:entry1.xIndex];
    dataSet300.label = [NSString stringWithFormat:@"沪深300指数:%.2f",entry1.value];
    dataSetDP.label = [NSString stringWithFormat:@"华夏大盘精选:%.2f  净值日期:%@",entry2.value,xLable];
    [self.chartView notifyDataSetChanged];

  
    
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
