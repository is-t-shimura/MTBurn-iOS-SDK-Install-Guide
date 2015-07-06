//
//  ADVSViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2/11/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import "ADVSViewController.h"
#import "ADVSAppDelegate.h"
#import <AppDavis/AppDavis.h>

@interface ADVSViewController ()
@end

@implementation ADVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

- (IBAction)interstitialButtonTapped:(id)sender
{
    // if you want to display interstitial ad when the button tapped, delete this comment out and edit storyboard
    //[self.interstitialAdLoader loadRequest];
}

#pragma mark - Private

- (NSString *)interstitialAdSpotId
{
    ADVSAppDelegate *delegate = (ADVSAppDelegate *) [[UIApplication sharedApplication] delegate];
    return [delegate adspotIdDict][@"interstitial"];
}

@end
