//
//  ADVSExceptionDelegate.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2017/05/08.
//  Copyright (c) 2017年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `ADVSExceptionDelegate` is delegate protocol for getting info about an exception.
 */

@protocol ADVSExceptionDelegate <NSObject>

@optional

/**
 Tells event just occuring an exception.
 
 @param error NSError instance
 */

- (void)ADVSexceptionOccured:(NSError *)error;

@end