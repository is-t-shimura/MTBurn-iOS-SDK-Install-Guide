//
//  ADVSInstreamAdLoader.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/04/17.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSInstreamAdLoaderDelegate.h"
#import "ADVSExceptionDelegate.h"

@protocol ADVSInstreamInfoProtocol;

/**
 `ADVSInstreamAdLoader` is for loading instream type advertisements.
 if you want to do so,
 
 2 ways to be prepared by our sdk to load advertisements.
 
 1) full control by sdk
  1. instantiate this class.
  2. call - ADVSbindToTableView
  3. call - ADVSloadAd or ADVSloadAd:adCount:positions
  4. call when your tableview is reloaded - ADVSreloadData
 
 2) some control by sdk
  1. instantiate this class.
  2. call - ADVSloadAdWithReturn:adCount:positions
  3. call when an advertisement is displayed - ADVSmeasureImp
  4. call when an advertisement is clicked   - ADVSsendClickEvent
 
 That's it!
 */

@interface ADVSInstreamAdLoader : NSObject
/**
 This delegate tells loading instream advertisement results.
 
 @see ADVSInstreamAdLoaderDelegate.h
 */
@property(nonatomic, weak) id<ADVSInstreamAdLoaderDelegate> delegate;

/**
 This exceptionDelegate tells an exception.
 
 @see ADVSExceptionDelegate.h
 */
@property(nonatomic, weak) id<ADVSExceptionDelegate> exceptionDelegate;

/**
 binds this loader to your table view.
 
 @param tableView tableView to be binded by this loader
 @param adSpotId  adSpotId to be registered in advance
 
 */

- (void)ADVSbindToTableView:(UITableView *)tableView adSpotId:(NSString *)adSpotId;

/**
 starts loading advertisements for inserting cells to binded tableview and then reload your tableview
 Use it if you want to use parameters registered at the management webpage in advance.
 */

- (void)ADVSloadAd;

/**
 starts loading advertisements for inserting limited cells to binded tableview and then reload your tableview,
 if you want to do so.
 
 @param adCount   advertisement cell count to be put in tableView. If 0 is given, registered is selected.
 @param positions each advertisement cell are put at the position in tableView. If nil is given, registered is selected.
 */

- (void)ADVSloadAd:(NSUInteger)adCount positions:(NSArray*)positions;

/**
 starts loading advertisements for receiving advertisement informations,
 if you want to do so.
 
 @param adSpotId  adSpotId to be registered in advance
 @param adCount   advertisement information count to be received in the callback. If 0 is given, registered is selected.
 @param positions each position to be added into `ADVSInstreamInfoModel` in order to control ad position. If nil is given, registered is selected.
 
 ex. [self.instreamAdLoader ADVSloadAdWithReturn:6 adCount:5 positions:@[@3,@6,@9,@12,@15]];
 */

- (void)ADVSloadAdWithReturn:(NSString *)adSpotId adCount:(NSUInteger)adCount positions:(NSArray*)positions;

/**
 send an impression record to log advertising performance.

 @param instreamInfoModel advertisement information model to be received in ADVSloadAd:adCount:positions
 */

- (void)ADVSmeasureImp:(id<ADVSInstreamInfoProtocol>)instreamInfoProtocol;

/**
 send an click record to log advertising performance.
 
 @param instreamInfoModel advertisement information model to be received in ADVSloadAd:adCount:positions
 */

- (void)ADVSsendClickEvent:(id<ADVSInstreamInfoProtocol>)instreamInfoProtocol;

/**
 reload data in your binded tableview.
 if you used `bindToTableView:adSpotId:`, invoke this method instead of [your_table_view reloadData].
 
 ADVSloadAd and ADVSloadAd:adCount:positions methods invoke this method internally, so you don't have to invoke
 this method explicitly in normal use case.
 
 */
- (void)ADVSreloadData;

/**
 sets an adSpotId.
 if you change an adSpotId dynamically, you can use it.
 
 @param adSpotId  adSpotId to be registered in advance
 
 */
- (void)ADVSsetAdSpotId:(NSString *)adSpotId;
@end
