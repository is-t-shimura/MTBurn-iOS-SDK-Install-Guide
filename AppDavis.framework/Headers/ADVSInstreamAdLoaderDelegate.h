//
//  ADVSInstreamAdLoaderDelegate.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/04/18.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `ADVSInstreamAdLoaderDelegate` is delegate protocol for getting loading instream advertisements result.
 */

@class ADVSInstreamAdLoader;

@protocol ADVSInstreamAdLoaderDelegate <NSObject>

@optional

/**
 Tells event just starting instream advertisement.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 */

- (void)ADVSinstreamAdLoaderDidStartLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader;

/**
 Tells event just finishing instream advertisement.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 */

- (void)ADVSinstreamAdLoaderDidFinishLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader;

/**
 Tells event just finishing, and returns `ADVSInstreamInfoModel` instances.
 
 @param instreamAdLoader   Object which is loading instream advertisement.
 @param instreamInfoModels Array  which contains `ADVSInstreamInfoModel` instances.
 */

- (void)ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:(ADVSInstreamAdLoader *)instreamAdLoader
                                  instreamInfoModels:(NSArray*)instreamInfoModels;

/**
 Tells event finished displaying each advertisement cell instances.
 
 @param adIndexPath Object which is the position of the advertisement cell instance that is being viewed.
 */

- (void)ADVSinstreamAdLoaderDidFinishLoadingAdImage:(NSIndexPath *)adIndexPath;

/**
 Tells event to send an impression just finishing.
  */

- (void)ADVSinstreamAdLoaderDidFinishSendingAdImp;

/**
 Tells event which clicked advertisement cell instances.
  */

- (void)ADVSinstreamAdLoaderDidFinishSendingAdClick;

/**
 Tells event just failed to load instream advertisement.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 @param error NSError instance.
 */

- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error;

/**
 Tells event just failed to display instream advertisement.
 
 @param adIndexPath Object which is the position of the advertisement cell instance that is being viewed.
 */

- (void)ADVSinstreamAdLoader:(NSIndexPath *)adIndexPath didFailToLoadAdImageWithError:(NSError *)error;

/**
 Tells event just failed to send an impression.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 @param error NSError instance.
 */

- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendImpWithError:(NSError *)error;

/**
 Tells event just failed to send an clickinfo.
 
 @param instreamAdLoader Object which is loading instream advertisement.
 @param error NSError instance.
 */

- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendClickWithError:(NSError *)error;

@end
