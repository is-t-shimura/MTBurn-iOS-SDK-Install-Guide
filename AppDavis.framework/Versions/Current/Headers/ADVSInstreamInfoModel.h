//
//  ADVSInstreamInfoModel.h
//  AppDavis-iOS-SDK
//
//  Created by M.T.Burn on 2014/04/17.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSExceptionDelegate.h"

#ifndef ADVS_INSTREAMINFO_PROTOCOL_H
#define ADVS_INSTREAMINFO_PROTOCOL_H
@protocol ADVSInstreamInfoProtocol <NSObject>
@property (nonatomic, readonly) NSNumber *position;
@end
#endif


/**
 `ADVSInstreamInfoModel` is a container to be stored instream advertisement information.
 */

@interface ADVSInstreamInfoModel : NSObject<ADVSInstreamInfoProtocol>

/**
 advertisement title to be consisted of ~20 characters in double byte character
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) NSString *title;

/**
 advertisement text to be consisted of 40~70 characters in double byte character
 (it's not a fixed specification. see our information webpage to get the latest specification)
 */
@property (nonatomic, readonly) NSString *content;

/**
 advertisement position to be put in the tableView.
 it is used by advertising performance analysis.
 */
@property (nonatomic, readonly) NSNumber *position;

/**
 advertiser name to be put in the tableView.
 it is used to show that this content is provided for PR.
 */
@property (nonatomic, readonly) NSString *displayedAdvertiser;

/**
 advertisement icon image url to be loaded in the tableView.
 you can use it directly instead of using loadIconImage
 */
@property (nonatomic, readonly) NSURL *iconImageURL;

/**
 advertisement main image url to be loaded in the tableView.
 you can use it directly instead of using loadImage
 */
@property (nonatomic, readonly) NSURL *imageURL;

/**
 starts loading advertisement icon image for assigning a UIImage to the iconImageView,
 if you want to do so.
 
 @param iconImageView  `UIImageView` instance to be assigned the icon image
 @param completion     callback block to inform an error. If the error is nil and loadImage:completion is also completed, invoke measureImp API.
 
 @see ADVSInstreamAdLoader.h
 */

- (void)ADVSloadIconImage:(UIImageView*)iconImageView completion:(void (^)(NSError *error)) completion;

/**
 starts loading advertisement icon image for assigning a UIImage to the iconImageView,
 if you want to do so.
 
 @param iconImageView  `UIImageView` instance to be assigned the icon image
 @param delegate       `id<ADVSExceptionDelegate>` instance to be informed an unexpected exception
 @param completion     callback block to inform an error. If the error is nil and loadImage:completion is also completed, invoke measureImp API.
 
 @see ADVSInstreamAdLoader.h
 */

- (void)ADVSloadIconImage:(UIImageView*)iconImageView delegate:(id<ADVSExceptionDelegate>) delegate completion:(void (^)(NSError *error)) completion;

/**
 starts loading advertisement main image for assigning a UIImage to the imageView,
 if you want to do so.
 
 @param imageView   `UIImageView` instance to be assigned the main image
 @param completion  callback block to inform an error. If the error is nil and loadIconImage:completion is also completed, invoke measureImp API.
 
 @see ADVSInstreamAdLoader.h
 */

- (void)ADVSloadImage:(UIImageView*)imageView completion:(void (^)(NSError *error)) completion;

/**
 starts loading advertisement main image for assigning a UIImage to the imageView,
 if you want to do so.
 
 @param imageView   `UIImageView` instance to be assigned the main image
 @param delegate       `id<ADVSExceptionDelegate>` instance to be informed an unexpected exception
 @param completion  callback block to inform an error. If the error is nil and loadIconImage:completion is also completed, invoke measureImp API.
 
 @see ADVSInstreamAdLoader.h
 */

- (void)ADVSloadImage:(UIImageView*)imageView delegate:(id<ADVSExceptionDelegate>) delegate completion:(void (^)(NSError *error)) completion;
@end
