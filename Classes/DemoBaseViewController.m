//
//  DemoBaseViewController.m
//  ChartsDemo
//
//  Created by Daniel Cohen Gindi on 13/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

#import "DemoBaseViewController.h"

@interface DemoBaseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *optionsTableView;

@end

@implementation DemoBaseViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    months = @[
        @"2015-7-3", @"2015-7-4", @"2015-7-5", @"2015-7-6", @"2015-7-7", @"2015-7-8", @"2015-7-9", @"2015-7-10", @"2015-7-11",@"2015-7-12", @"2015-7-13", @"2015-7-15",@"2015-7-16", @"2015-7-17", @"2015-7-18", @"2015-7-19", @"2015-7-20", @"2015-7-21", @"2015-7-22", @"2015-7-23", @"2015-7-24",@"2015-7-25", @"2015-7-26", @"2015-7-27",@"2015-7-27", @"2015-8-1", @"2015-8-2", @"2015-8-3", @"2015-8-4", @"2015-8-5"
        ];
    
    parties = @[
        @"Party A", @"Party B", @"Party C", @"Party D", @"Party E", @"Party F",
        @"Party G", @"Party H", @"Party I", @"Party J", @"Party K", @"Party L",
        @"Party M", @"Party N", @"Party O", @"Party P", @"Party Q", @"Party R",
        @"Party S", @"Party T", @"Party U", @"Party V", @"Party W", @"Party X",
        @"Party Y", @"Party Z"
    ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)optionTapped:(NSString *)key
{
    
}

#pragma mark - Actions

- (IBAction)optionsButtonTapped:(id)sender
{
    if (_optionsTableView)
    {
        [_optionsTableView removeFromSuperview];
        self.optionsTableView = nil;
        return;
    }
    
    self.optionsTableView = [[UITableView alloc] init];
    _optionsTableView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.9f];
    _optionsTableView.delegate = self;
    _optionsTableView.dataSource = self;
    
    _optionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_optionsTableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:40.f]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_optionsTableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:sender attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_optionsTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:sender attribute:NSLayoutAttributeBottom multiplier:1.f constant:5.f]];
    
    [self.view addSubview:_optionsTableView];
    
    [self.view addConstraints:constraints];
    
    [_optionsTableView addConstraints:@[
                                        [NSLayoutConstraint constraintWithItem:_optionsTableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.f constant:220.f]
                                        ]];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _optionsTableView)
    {
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _optionsTableView)
    {
        return self.options.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _optionsTableView)
    {
        return 40.0;
    }
    
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _optionsTableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.backgroundView = nil;
            cell.backgroundColor = UIColor.clearColor;
            cell.textLabel.textColor = UIColor.whiteColor;
        }
        
        cell.textLabel.text = self.options[indexPath.row][@"label"];
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _optionsTableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (_optionsTableView)
        {
            [_optionsTableView removeFromSuperview];
            self.optionsTableView = nil;
        }
        
        [self optionTapped:self.options[indexPath.row][@"key"]];
    }
}

@end
