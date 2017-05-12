//
//  ADVSInstreamAdCellWebView.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/07/16.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSInstreamAdCellProtocol.h"
#import "ADVSExceptionDelegate.h"

@class ADVSInstreamWebViewInfoModel;

/**
 @see `ADVSInstreamAdCellInternalProtocol`
 */

@interface ADVSInstreamAdCellWebView : UITableViewCell<ADVSInstreamAdCellInternalProtocol>
@property(nonatomic, weak) id<ADVSExceptionDelegate> exceptionDelegate;
- (void)ADVSupdateCell:(ADVSInstreamWebViewInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;

@end
