//
//  LineChart1ViewController.m
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

#import "LineChart1ViewController.h"
#import "ChartsDemo-Swift.h"

@interface LineChart1ViewController () <ChartViewDelegate>

@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;

@end

@implementation LineChart1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Line Chart 1 Chart";
//    
//    self.options = @[
//                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
//                     @{@"key": @"toggleFilled", @"label": @"Toggle Filled"},
//                     @{@"key": @"toggleCircles", @"label": @"Toggle Circles"},
//                     @{@"key": @"toggleCubic", @"label": @"Toggle Cubic"},
//                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
//                     @{@"key": @"toggleStartZero", @"label": @"Toggle StartZero"},
//                     @{@"key": @"animateX", @"label": @"Animate X"},
//                     @{@"key": @"animateY", @"label": @"Animate Y"},
//                     @{@"key": @"animateXY", @"label": @"Animate XY"},
//                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
//                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
//                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
//                     ];
//    
    _chartView.delegate = self;
    
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"You need to provide data for the chart.";
    
    _chartView.dragEnabled = NO;
    _chartView.highlightEnabled =NO;
    _chartView.clipsToBounds = NO;
    [_chartView setScaleEnabled:NO];
    _chartView.pinchZoomEnabled = NO;
    _chartView.scaleXEnabled = NO;
    _chartView.scaleYEnabled= NO;
    _chartView.drawGridBackgroundEnabled = NO;
    //_chartView.drawGridLinesEnabled = YES;
    _chartView.xAxis.drawGridLinesEnabled = NO;
        ChartXAxis *xAxis1  = _chartView.xAxis;
    //  NSArray *temp =xAxis1.limitLines;
    [xAxis1 setXOffset:-30];
    //[xAxis1 setLabelsToSkip:15];
    [xAxis1 setAvoidFirstLastClippingEnabled:TRUE];
  

//    // x-axis limit line
//    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:0 label:@"Index 10"];
//    llXAxis.lineWidth = 4.0;
////    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
////    llXAxis.labelPosition = ChartLimitLabelPositionRight;
////    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
//
//    [_chartView.xAxis addLimitLine:llXAxis];
//
//    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:130.0 label:@"Upper Limit"];
//    ll1.lineWidth = 4.0;
//    ll1.lineDashLengths = @[@5.f, @5.f];
//    ll1.labelPosition = ChartLimitLabelPositionRight;
//    ll1.valueFont = [UIFont systemFontOfSize:10.0];
//    
//    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
//    ll2.lineWidth = 4.0;
//    ll2.lineDashLengths = @[@5.f, @5.f];
//    ll2.labelPosition = ChartLimitLabelPositionRight;
//    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;

    //[leftAxis removeAllLimitLines];
//    [leftAxis addLimitLine:ll1];
//    [leftAxis addLimitLine:ll2];
    leftAxis.customAxisMax = 130;
    leftAxis.customAxisMin = 120;
    leftAxis.startAtZeroEnabled = NO;
    //leftAxis.needsOffset = YES;
   // leftAxis.gridLineDashLengths = @[@10.f, @10.f];
    leftAxis.drawLimitLinesBehindDataEnabled = NO;
    leftAxis.labelPosition = YAxisLabelPositionInsideChart;
    [leftAxis setYOffset:-15];
    ChartLegend * legend =_chartView.legend;
    [legend setPosition:ChartLegendPositionLeftOfChart];
    
    _chartView.rightAxis.enabled = NO;
    
    
    BalloonMarker *marker = [[BalloonMarker alloc] initWithColor:[UIColor colorWithWhite:180/255. alpha:1.0] font:[UIFont systemFontOfSize:12.0] insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    _chartView.marker = marker;
//
    //_chartView.legend.form = ChartLegendFormLine;
    
    //_sliderX.value = 44.0;
    //_sliderY.value = 100.0;
    [self slidersValueChanged:nil];
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    
    [_chartView animateWithXAxisDuration:2.5 easingOption:ChartEasingOptionEaseInOutQuart];

//    for (LineChartDataSet *set in _chartView.data.dataSets)
//    {
//        set.drawFilledEnabled = YES
//        ;
//    }
//    //
//    [_chartView setNeedsDisplay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {

            [xVals addObject:months[i % 30]];

    }
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        int mult = (range + 1);
        int val = (int) (arc4random_uniform(mult)) + 123;
        [yVals addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithYVals:yVals label:@"华夏大盘精选基金"];
    
    set1.lineDashLengths = @[@10, @10];
    [set1 setColor:UIColor.redColor];
    [set1 setCircleColor:UIColor.greenColor];
     set1.drawValuesEnabled = NO;
    set1.lineWidth = 1.0;
    set1.circleRadius = 2.0;
    set1.drawCircleHoleEnabled = NO;
    set1.valueFont = [UIFont systemFontOfSize:9.f];
    set1.fillAlpha = 65/255.0;
    set1.fillColor = UIColor.redColor;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    
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
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
