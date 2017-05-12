//
//  ADVSInstreamSample1Cell.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/04/17.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVSInstreamAdCellProtocol.h"
#import "ADVSExceptionDelegate.h"

@class ADVSInstreamInfoModel;

/**
 @see `ADVSInstreamAdCellProtocol`
 */

@interface ADVSInstreamAdCellThumbnailMiddle : UITableViewCell<ADVSInstreamAdCellProtocol>
@property(nonatomic, weak) id<ADVSExceptionDelegate> exceptionDelegate;
+ (CGFloat)ADVSheightForCell;
- (void)ADVSupdateCell:(ADVSInstreamInfoModel*)infoModel completion:(void (^)(NSError *error)) completion;
@end
