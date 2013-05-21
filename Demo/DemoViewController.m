//
//  DemoViewController.m
//  Demo
//
//  Created by Dmitry Egorov on 8/13/11.
//  Copyright 2011 Mobion. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) MoSegmentedControl *segmentedControl;

@end

@implementation DemoViewController


- (void) updateColor {    
    _colorView.backgroundColor = [UIColor colorWithRed:[_segmentedControl isSegmentSelected:0]
                                                 green:[_segmentedControl isSegmentSelected:1]
                                                  blue:[_segmentedControl isSegmentSelected:2]
                                                 alpha:1.];
}

- (void)loadView
{    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.view = view;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 40)];
    label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"RGB color components";
    [self.view addSubview:label];
    
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, 280, 290)];
    _colorView.backgroundColor = [UIColor blackColor];
    _colorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_colorView];
    
    NSArray *items = [NSArray arrayWithObjects:@"Red", @"Green",  @"Blue", nil];
    _segmentedControl = [[MoSegmentedControl alloc] initWithItems:items];
    _segmentedControl.frame = CGRectMake(30, 60, 280, 30);
    _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_segmentedControl makeSegment:0 selected:YES];
    [_segmentedControl makeSegment:2 selected:YES];
    [_segmentedControl addTarget:self action:@selector(updateColor) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    [self updateColor];

} 

- (void) viewDidUnload {
    self.colorView = nil;
    self.segmentedControl = nil;
    self.view = nil;
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
