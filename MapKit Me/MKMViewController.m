//
//  MKMViewController.m
//  MapKit Me
//
//  Created by Justin Miller on 4/30/12.
//  Copyright (c) 2012 MapBox / Development Seed. All rights reserved.
//

#import "MKMViewController.h"

#import <MapKit/MapKit.h>

@interface MKMViewController () <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@end

#pragma mark -

@implementation MKMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MapKit Me";

    [self.segmentedControl addTarget:self action:@selector(toggleMode:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setSelectedSegmentIndex:0];

    self.navigationItem.rightBarButtonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    self.mapView.showsUserLocation = YES;

    self.mapView.delegate = self;

    [self.mapView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)]];
    [self.mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)]];
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

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state != UIGestureRecognizerStateBegan)
        return;

    for (id <MKAnnotation>annotation in self.mapView.annotations)
        if ( ! [annotation isKindOfClass:[MKUserLocation class]])
            [self.mapView removeAnnotation:annotation];

    MKPointAnnotation *annotation = [MKPointAnnotation new];

    annotation.coordinate = [self.mapView convertPoint:[recognizer locationInView:self.mapView] toCoordinateFromView:self.mapView];

    annotation.title = @"Dropped Pin";

    [self.mapView addAnnotation:annotation];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if ([self.mapView.annotations count] > 1)
        for (id <MKAnnotation>annotation in self.mapView.annotations)
            if ( ! [annotation isKindOfClass:[MKUserLocation class]])
                [self.mapView removeAnnotation:annotation];
}

#pragma mark -

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isEqual:self.mapView.userLocation])
        return nil;

    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];

    pin.animatesDrop = YES;

    pin.canShowCallout = YES;

    return pin;
}

@end