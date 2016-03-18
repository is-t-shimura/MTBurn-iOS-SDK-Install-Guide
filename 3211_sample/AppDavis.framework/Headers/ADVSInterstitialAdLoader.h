//
//  ADVSInterstitialAdLoader.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/03/19.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSInterstitialAdLoaderDelegate.h"

@interface ADVSInterstitialAdLoader : NSObject

@property (nonatomic, weak) id<ADVSInterstitialAdLoaderDelegate> delegate;

/**
 adSpotId is registered in advance and used for skip control
 */
@property (nonatomic) NSString *adSpotId;

/**
 Get an adLoader of sharedInstance.
 Prefer it to the way to create an instance manually for avoiding a crash.
 */
+ (instancetype)sharedInstance;

/**
 Loads a institial type advertisement request asynchronously.
 
 @see ADVSInterstitialAdLoaderDelegate.h
 */

- (void)loadRequest;

/**
 Display a institial type advertisement instantly.
 The background color of interstitial ad is picked as default one.
 
 @see ADVSInterstitialAdLoaderDelegate.h
 */

- (void)displayAd;

/**
 Display a institial type advertisement instantly with specific color.

 @param backgroundColor  color to be applied background of interstitial ad
 
 @see ADVSInterstitialAdLoaderDelegate.h
 */

- (void)displayAd:(UIColor*)backgroundColor;

@end
