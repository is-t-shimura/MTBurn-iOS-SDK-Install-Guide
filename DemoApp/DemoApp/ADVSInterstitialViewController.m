//
//  ADVSInterstitialViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/10/17.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSInterstitialViewController.h"
#import <AppDavis/ADVSInterstitialAdLoader.h>
#import "ADVSAppDelegate.h"

@interface ADVSInterstitialViewController () <ADVSInterstitialAdLoaderDelegate>
@end

@implementation ADVSInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Removed comment out if you want to stop skipping interstitial ads.
    // (Setting) adspot_id: OTM0OjQ1Nw and OTM0OjQ2MQ are set that skip count is 2 times until first display and 1 times after that.
    //  See http://gyazo.com/e279ae315a31ff32a8505528dc940782 (in japanese)
    NSString *adspot_id = [self getAdSpotId];
    if (0 < [adspot_id length]) {
        [[ADVSInterstitialAdLoader sharedInstance] setAdSpotId:adspot_id];
    }
    
    [ADVSInterstitialAdLoader sharedInstance].delegate = self;
    [[ADVSInterstitialAdLoader sharedInstance] loadRequest];
}

- (NSString*)getAdSpotId
{
    ADVSAppDelegate *delegate = (ADVSAppDelegate *) [[UIApplication sharedApplication] delegate];
    return [delegate adspotIdDict][@"interstitial"];
}

#pragma mark - ADVSInterstitialAdLoaderDelegate

- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidStartLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAdView");
    
    [[ADVSInterstitialAdLoader sharedInstance] displayAd];
    
    // Removed a comment out if you want to try setting red to background color.
    // [[ADVSInterstitialAdLoader sharedInstance] displayAd:[UIColor redColor]];
}

- (void)interstitialAdLoaderDidSkipLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidSkipLoadingAd");
}

- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidClickIntersititialAdView:");
}

- (void)interstitialAdLoaderDidCloseIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidCloseIntersititialAdView:");
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdViewWithError:%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
