//
//  MKMViewController.m
//  MapKit Me
//
//  Created by Justin Miller on 4/30/12.
//  Copyright (c) 2012 MapBox / Development Seed. All rights reserved.
//

#import "MKMViewController.h"

#import <MapKit/MapKit.h>

@interface MKMViewController ()

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@end

#pragma mark -

@implementation MKMViewController

@synthesize mapView;
@synthesize segmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MapKit Me";

    [self.segmentedControl addTarget:self action:@selector(toggleMode:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setSelectedSegmentIndex:0];

    self.navigationItem.rightBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    self.mapView.showsUserLocation = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

#pragma mark -

- (void)toggleMode:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
        self.mapView.mapType = MKMapTypeStandard;
    else if (sender.selectedSegmentIndex == 1)
        self.mapView.mapType = MKMapTypeHybrid;
    else if (sender.selectedSegmentIndex == 2)
        self.mapView.mapType = MKMapTypeSatellite;
}

@end