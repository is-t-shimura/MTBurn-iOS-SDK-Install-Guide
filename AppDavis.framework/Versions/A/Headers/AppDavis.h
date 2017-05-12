//
//  AppDavis.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2/10/14.
//  Copyright (c) 2014 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ADVSExceptionDelegate.h"

/**
 `AppDavis` is entry point class for starting using AppDavis.framework.
 
 If you want use some of AppDavis function, write `initMedia` first of all.
 
 */

@interface AppDavis : NSObject

///------------------------------------
/// @name Initialize AppDavis task
///------------------------------------

/**
 Sets the given mediaId from administrator.
 You should describe this method in [AppDelegate -application:didFinishLaunchingWithOptions:]
 Unless you have specific requirements.
 
 @param mediaId The number which was given by administrator.
*/

+ (void)ADVSinitMedia:(NSString *)mediaId;

+ (void)ADVSinitMedia:(NSString *)mediaId params:(NSDictionary*)params;

+ (void)ADVSinitMedia:(NSString *)mediaId delegate:(id<ADVSExceptionDelegate>)delegate;

+ (void)ADVSinitMedia:(NSString *)mediaId params:(NSDictionary*)params delegate:(id<ADVSExceptionDelegate>)delegate;

@end
