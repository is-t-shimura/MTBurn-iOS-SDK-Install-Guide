//
//  ADVSInterstitialAdLoaderDelegate.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/03/19.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `ADVSinterstitialAdLoaderDelegate` is delegate protocol for getting loading Interstitial advertisement result.
 */

@class ADVSInterstitialAdLoader;

@protocol ADVSInterstitialAdLoaderDelegate <NSObject>

@optional

/**
 Tells event just starting interstitial advertisement.
 
 @param interstitialAdLoader Object which is loading an interstitial advertisement.
 */

- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader;

/**
 Tells event just finishing interstitial advertisement.
 
 @param interstitialAdLoader Object which is loading an interstitial advertisement.
 */

- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader;

/**
 Tells event just finishing loading interstitial advertisement view.
 
 @param interstitialAdLoader Object which is loading an interstitial advertisement.
 */

- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader;

/**
 Tells event just skipping interstitial advertisement.
 
 @param interstitialAdLoader Object which is loading an interstitial advertisement.
 */

- (void)interstitialAdLoaderDidSkipLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader;

/**
 Tells event just be clicked interstitial advertisement.
 
 @param interstitialAdLoader Object which is loading an interstitial advertisement.
 */

- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader;

/**
 Tells event just be closed interstitial advertisement.
 Causion: This is not called when the advertisement is clicked.
 
 @param interstitialAdLoader Object which is loading an interstitial advertisement.
 */

- (void)interstitialAdLoaderDidCloseIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader;

/**
 Tells event just failed to load interstitial advertisement.
 
 @param interstitialAdLoader Object which is loading an interstitial advertisement.
 @param error NSError instance.
 */

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error;

/**
 Tells event just failed to display interstitial advertisement.
 
 @param interstitialAdLoader Object which is displaying an interstitial advertisement.
 @param error NSError instance.
 */

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error;
@end