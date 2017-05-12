//
//  ADVSInstreamAdCellTextOnly.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/05/27.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVSInstreamAdCellProtocol.h"
#import "ADVSExceptionDelegate.h"

@class ADVSInstreamInfoModel;

/**
 @see `ADVSInstreamAdCellProtocol`
 */

@interface ADVSInstreamAdCellTextOnly : UITableViewCell<ADVSInstreamAdCellProtocol>
@property(nonatomic, weak) id<ADVSExceptionDelegate> exceptionDelegate;
+ (CGFloat)ADVSheightForCell;
- (void)ADVSupdateCell:(ADVSInstreamInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;
@end
