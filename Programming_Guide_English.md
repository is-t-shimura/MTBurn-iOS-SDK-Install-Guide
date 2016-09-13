# Table of Contents

* [Things to Do First](#start)
    * [Acquisition of Media ID](#start/media_id)
    * [Initialization within the Code](#start/init)
* [In-feed Advertisements](#infeed)
    * [Acquiring an Ad Spot ID](#infeed/adspot_id)
    * [Simple In-feed Advertisements](#infeed/simple)
        * [Displaying Simple In-feed Advertisements](#infeed/simple/display)
        * [Acquiring Events when Displaying Simple In-feed Advertisements](#infeed/simple/event)
        * [Additional Loading of Simple In-feed Advertisements](#infeed/simple/additional_load)
        * [Simple In-feed Advertisement Format](#infeed/simple/format)
        * [Notes when Using Simple In-feed Advertisements](#infeed/simple/caution)
    * [Custom In-feed Advertisements](#infeed/custom)
        * [Loading Custom In-feed Advertisement](#infeed/custom/load)
        * [Displaying Custom In-feed Advertisements](#infeed/custom/display)
        * [Custom In-feed Advertisement Impression Notifications](#infeed/custom/imp)
        * [Transition Processing when Clicking Custom In-feed Advertisements](#infeed/custom/click)
        * [Acquiring Events during Custom In-feed Advertisements and Various Notifications](#infeed/custom/event)
        * [Custom In-feed Advertisement Parameters](#infeed/custom/param)
        * [Free Use of SDK Advertisement Formats Provided by Default in SDK](#infeed/custom/format)
* [Update History](#update)

<a name="start"></a>
# Things to Do First
This guide provides an outline of how to use SDK.

Refer to the comments in each header file within the framework for details on the API specification.

<a name="start/media_id"></a>
## Acquiring the Media ID

Register and issue the Media ID from the Management Screen.
Make sure you do not forget this Media ID as it is used to identify the application.

### Test ID

You can use Media ID 1 for test purposes. Dummy data is displayed, enabling you to confirm the operation. Media ID 2 can be used for everything except interstitial advertisements. The main data is displayed, so this can be used when confirming visually.

<a name="start/init"></a>
## Initialization within the Code

The media_id acquired above is used as a parameter to initialize AppDavis.

Unless there is any specific reason not to, specify this as

[UIApplicationDelegate -application:didFinishLaunchingWithOptions:](https://developer.apple.com/library/ios/documentation/uikit/reference/UIApplicationDelegate_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UIApplicationDelegate/application:didFinishLaunchingWithOptions:)

```objc
// (1) Specify a header file
#import <AppDavis/AppDavis.h>

// (2) Call initialization method
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AppDavis ADVSinitMedia:@"your_media_id"];

    // ...
}
```

Please be aware that **unless this initialization takes place, acquiring the advertisements will generally not be possible**. This is described below.

<a name="infeed"></a>
# In-feed Advertisements

<a name="infeed/adspot_id"></a>
## Acquiring the Ad Spot ID

The adspot_id is issued from the Management Screen. Next, set the following information to dispense the adspot_id.

- Ad spot name
- Advertisement image size
- Advertising format (only required in the case of simple In-feed advertisements, described below)
- Number of advertisements
- Advertisement location array
- HTML, width, height (only required when the drawing format in WebView has been selected)

The following information is set for test purposes only. As this is linked to actual projects, it may be less than the number of projects described below. In this case, please contact a representative.

After setting the media_id to 2, set the following advertisement ID (adspot_id)

```
Advertisement ID: NDQ0OjMx
Advertisement image size: 114x114 pixel
Advertising format: ThumnailMiddle
Number of advertisements per request: 2
Advertisement location array: 3,6
```

```
Ad spot ID: OTA2OjMy
Advertisement image size: 114x114 pixel
Advertisement format: ThumnailSmall
Number of advertisements per request: 1
Advertisement location array: 4
```

```
Ad spot ID: ODEzOjMz
Advertisement image size: 640x200 pixel
Advertisement format: LandscapePhoto
Number of advertisements per request: 3
Advertisement location array: 0,1,2
```

```
Advertisement ID: OTIyOjM0
Advertisement image size: 640x320 pixel
Advertisement format: PhotoBottom
Number of advertisements per request: 4
Advertisement location array: 5,7,9,10
```

```
Advertisement ID: NzA2OjM1
Advertisement image size: 640x320 pixel
Advertisement format: PhotoMiddle
Number of advertisements per request: 6
Advertisement location array: 2,4,6,8,10,12
```

```
Advertisement ID: MzA3OjM2
Advertisement image size: 114x114 pixel
Advertisement format: TextOnly
Number of advertisements per request: 6
Advertisement location array: 5,10,15,20,25,30
```

```
Advertisement ID: MTI2OjU1
Advertisement image size: 114x114 pixel
Advertisement format: WebView (small)
Number of advertisements per request: 3
Advertisement location array: 5,10,15
HTML: <html><head><META http-equiv="Content-Type" content="text/html";charset="UTF-8"><styl
e type="text/css"> .box1,.box2{display: table-cell;vertical-align:top;}.box1{width: 40px;}</style></head><body><div class="box1"><img width="32" height="32" src="[% AD_ICON_IMAGE
_URL %]"/></div><div class="box2"><span style="font-size:14.5px;"><font color="#0066cc">[% AD_TITLE %]</font></span></div><div class="desc"><span style="font-size:11.5px;">[% AD_
DESCRIPTION %]</span></div></body></html>
width: NULL(right up to edge of screen width)
height:80
```

```
Advertisement ID: OTkzOjU2
Advertisement image size: 640x200 pixel
Advertising format: WebView (medium)
Number of advertisements per request: 3
Advertisement location array: 5,10,15
HTML:<html><head><META http-equiv="Content-Type" content="text/html";charset="UTF-8"><styl
e type="text/css"> .box1,.box2{display: table-cell;vertical-align:top;}.box1{width: 22px;}.main_img{text-align: center;}</style></head><body><div class="main_img"><img width="300
" height="94" src="[% AD_MAIN_IMAGE_URL %]"/></div><div class="desc"><span style="font-size:13px;">[% AD_DESCRIPTION %]</span></div><div class="box1"><img width="18" height="18"
src="[% AD_ICON_IMAGE_URL %]"/></div><div class="box2"><span style="font-size:14.0px;"><font color="#0066cc">[% AD_TITLE %]</font></span></div></body></html>
width: NULL(right up to edge of screen width)
height:165
```

```
Advertisement ID: MzEzOjU3
Advertisement image size: 640x320 pixel
Advertising format: WebView (large)
Number of advertisements per request: 3
Advertisement location array: 5,10,15
HTML:<html><head><META http-equiv="Content-Type" content="text/html";charset="UTF-8"><styl
e type="text/css"> .box1,.box2{display: table-cell;vertical-align:top;}.box1{width: 40px;}.main_img{text-align: center;}</style></head><body><div class="box1"><img width="32" height="32" src="[% AD_ICON_IMAGE_URL %]"/></div><div class="box2"><span style="font-size:14.5px;"><font color="#0066cc">[% AD_TITLE %]</font></span></div><div class="desc"><span style="font-size:11.5px;">[% AD_DESCRIPTION %]</span></div><div class="main_img"><img width="300" height="150" src="[% AD_MAIN_IMAGE_URL %]"/></div></body></html>
width: NULL (screen full width)
height: 230
```

**You should contact your representative for inquiries about registering for the new ad spot**.

<a name="infeed/simple"></a>
## Simple In-feed advertisements

The simple In-feed advertisement assumes the use of `UITableView`.

For all other uses, refer to the custom In-feed advertisement described below.

<a name="infeed/simple/display"></a>
### Displaying Simple In-feed Advertisements

The files required for displaying In-feed advertisements are as follows.

```
ADVSInstreamAdLoader.h
```

Using the above files to load the In-feed advertisements, this is implemented as follows.

```objc
//(1) Import header
#import <AppDavis/ADVSInstreamAdLoader.h>

@interface YourViewController ()
//(2) Define properties
@property(nonatomic) ADVSInstreamAdLoader *instreamAdLoader;
@end

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //(3) Create instance of ADVSInstreamAdLoader and set delegate
    self.instreamAdLoader = [ADVSInstreamAdLoader new];
    self.instreamAdLoader.delegate = self;

    //(4) Set the tableView and adspot_id in which the In-feed advertisements are to be inserted
    [self.instreamAdLoader ADVSbindToTableView:self.tableView adSpotId:@"NDQ0OjMx"];

    // Wait for the media data acquisition to complete
    ...
    //(5) Call the In-feed advertisement load
    [self.instreamAdLoader ADVSloadAd];
}
```

This abovementioned process allows the In-feed advertisement to be displayed. There is no need to call `[your_tableView reloadData]`. When it is necessary to call `[your_tableView reloadData]`, call `[self.instreamAdLoader reloadData];`

The number of advertisements and the advertisement array per request can be controlled using APIs such as `[self.instreamAdLoader ADVSloadAd:6 positions:@[@2,@4,@6,@8,@10,@12]];`

<a name="infeed/simple/event"></a>
### Acquisition of Events when Displaying Simple In-Feed Advertisements

When displaying In-Feed advertisements, there may be times you want to receive these events.

In this case, `ADVSInterstitialAdLoader` is set to `ADVSInterstitialAdLoaderDelegate`.
Delegate is an `ADVSInterstitialAdLoader` property allowing the event to be received.

```objc
- (void)viewDidLoad
{
    //(1) Set delegate
    self.instreamAdLoader.delegate = self;
}

//(2)When advertisement loading begins
- (void)ADVSinstreamAdLoaderDidStartLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
}

//(3)When loading of advertisements is complete
- (void)ADVSinstreamAdLoaderDidFinishLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
}

//(4) When loading of advertisement View is complete
- (void)ADVSinstreamAdLoaderDidFinishLoadingAdImage:(NSIndexPath *)adIndexPath
{
}

//(5)When advertisement click processing is complete
- (void)ADVSinstreamAdLoaderDidFinishSendingAdClick
{
}

//(6)When loading of advertisements fails
- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error
{
}

//(7) When loading of advertisement View fails
- (void)ADVSinstreamAdLoader:(NSIndexPath *)adIndexPath didFailToLoadAdImageWithError:(NSError *)error
{
}
```
<a name="infeed/simple/additional_load"></a>
### Additional Loading of Simple In-feed Advertisements

In the case of a UI that reads in additional feeds when the user arrives at the bottom of the site, it is possible to load additional advertisements.

```objc
- (void)loadMore
{
    //Loads additional advertisements and inserts the advertising location array in an appropriate location within the table
    [self.instreamAdLoader ADVSloadAd];
}
```
<a name="infeed/simple/format"></a>
### Simple In-feed Advertisement Format

At present, seven advertisement formats can be used. The settings are [as follows](## Acquiring the Ad Spot ID):

- 1-1) ThumnailMiddle

```
    // The format looks like this
    //  -----------------------------------------------------
    // |             |  icon + name                          |
    // |   image     |  ad text                              |
    // |             |                                       |
    // |   90x90     |                                       |
    // |             |                                    PR |
    //  -----------------------------------------------------
```

- 1-2) ThumnailSmall

```
    // The format looks like this
    //  -----------------------------------------------------
    // |  -------    icon + name                             |
    // | | image |   PR                                      |
    // | | 50x50 |   ad text                                 |
    // | |       |                                           |
    // |  -------                                            |
    //  -----------------------------------------------------
```

- 1-3) LandscapePhoto

```
    // The format looks like this
    //  -----------------------------------------------------
    // |                                                     |
    // |                  ad image                           |
    // |                                                     |
    // | --------------------------------------------------- |
    // |  ad text                                            |
    // |                                                     |
    // |                                                     |
    // |                                                 PR  |
    // |  advertiser icon + name                             |
    //  -----------------------------------------------------
```

- 1-4) PhotoBottom

```
    // The format looks like this
    //  -----------------------------------------------------
    // |  advertiser |  advertiser name                      |
    // |     icon    |  PR                                   |
    // |             |  ad text                              |
    // | --------------------------------------------------- |
    // |                                                     |
    // |                                                     |
    // |                   image                             |
    // |                                                     |
    //  -----------------------------------------------------
```

- 1-5) PhotoMiddle
```
    // The format looks like this
    //  -----------------------------------------------------
    // | icon + name                                         |
    // |                                                  PR |
    // | --------------------------------------------------- |
    // |                                                     |
    // |                                                     |
    // |                      image                          |
    // |                                                     |
    // |                                                     |
    // |                                                     |
    // | --------------------------------------------------- |
    // |  text                                               |
    //  -----------------------------------------------------
```

- 1-6) TextOnly
```
    // The format looks like this
    //  -----------------------------------------------------
    // |  icon + name                                        |
    // |                                                  PR |
    // | --------------------------------------------------- |
    // |                                                     |
    // |             ad text                                 |
    // |                                                     |
    // |                                                     |
    //  -----------------------------------------------------
```
- 1-7) WebView
	- By submitting HTML, it is possible to draw in WebView within the application.

<a name="infeed/simple/caution"></a>
### Notes when Using Simple In-feed Advertisements

- Operation of `UITableView` passed to `(void)ADVSbindToTableView:adSpotId:` is guaranteed only when there is one section.

<a name="infeed/custom"></a>
## Custom In-feed Advertisements

When you need to display in a more flexible way than simple in-feed advertisements, it is possible to use the custom in-feed advertisement function.

When implementing this, be sure to include some wording to ensure that the user recognizes and understands that the advertising area is reserved for advertisements.

(Example: ”PR,” ”Sponsored,” “Ad,” “Advertisement”)

The example in the following guide assumes the use of `UITableView`, but `UIView`, etc. can also be used.

<a name="infeed/custom/load"></a>
### Loading Custom In-feed Advertisements

The files required for In-feed advertisement loading are as follows.

```
ADVSInstreamAdLoader.h
ADVSInstreamInfoModel.hT
```

Using the abovementioned files, this is implemented in the following way:

```objc
//(1)  Import header
#import <AppDavis/ADVSInstreamAdLoader.h>
#import <AppDavis/ADVSInstreamInfoModel.h>

@interface YourViewController ()<ADVSInstreamAdLoaderDelegate>
//(2) Define property
@property(nonatomic) ADVSInstreamAdLoader *instreamAdLoader;
@end

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //(3) Create an instance of ADVSInstreamAdLoader  and set delegate
    self.instreamAdLoader = [ADVSInstreamAdLoader new];
    self.instreamAdLoader.delegate = self;

    //(4) Call the In-feed advertisement
    [self.instreamAdLoader ADVSloadAdWithReturn:@"NDQ0OjMx" adCount:6 positions:@[@3,@6,@9,@12,@15,@18]];
}

//(5) Complete In-feed advertisement loading
- (void)ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:(ADVSInstreamAdLoader *)instreamAdLoader
                                  instreamInfoModels:(NSArray*)instreamInfoModels
{
    //(6) Receive Instream advertising information
    for (ADVSInstreamInfoModel *info in instreamInfoModels) {
        [_items insertObject:info atIndex:[info.position integerValue]];
    }
    //(7) Update the display
    [self.tableView reloadData];
}
```

This process allows loading of In-feed advertisements.

<a name="infeed/custom/display"></a>
### Displaying Custom In-feed advertisements

The advertisement is displayed based on the information extracted from `ADVSInstreamInfoModel.h`. The `position` is used to analyze the results of the advertising; therefore, choose a position on the screen and use this as the reference point.

```objc
    if (infoModel.title) {
        self.adNameLabel.text = infoModel.title;
    }

    if (infoModel.content) {
        self.adTextLabel.text = infoModel.content;
    }

    if (0 < [infoModel.displayedAdvertiser length]) {
        self.adIndicatorLabel.text = infoModel.displayedAdvertiser;
    } else {
        self.adIndicatorLabel.text = @"PR";
    }

    [infoModel ADVSloadIconImage:self.adIconImageView completion:^(NSError *iconImageLoadError) {
        [infoModel ADVSloadImage:self.adImageView completion:^(NSError *imageLoadError) {
            if (iconImageLoadError || imageLoadError) {
                NSLog(@"error");
            } else {
                NSLog(@"ok, start sending an impression log");
                [self.instreamAdLoader ADVSmeasureImp:infoModel];
            }
        }];
    }];
```

<a name="infeed/custom/imp"></a>
### Custom In-feed Advertisement Impression Notifications

When display of the advertisement is complete, notify the impression. Call `ADVSmeasureImp:` from `ADVSInstreamAdLoader.h`.

<a name="infeed/custom/click"></a>
### Transition Processing when Clicking Custom In-feed Advertisements

By using the following method, when an advertisement is clicked, the user can be appropriately transitioned. Call sendClickEvent `ADVSInstreamAdLoader.h` from `ADVSsendClickEvent:`

<a name="infeed/custom/event"></a>
### Loading of Custom In-feed Advertisements and Event Acquisition during Notifications

When loading In-feed advertisements and performing notifications, there are times when you want to receive those events.

In this case, `ADVSInterstitialAdLoader` is set to `ADVSInterstitialAdLoaderDelegate`.
Delegate is an `ADVSInterstitialAdLoader` property allowing the event to be received.

```objc
- (void)viewDidLoad
{
    //(1) Set the delegate
    self.instreamAdLoader.delegate = self;
}

//(2) When loading of advertisements begins
- (void)ADVSinstreamAdLoaderDidStartLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
}

//(3) When loading of advertisements  is complete
- (void)ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:(ADVSInstreamAdLoader *)instreamAdLoader
                                  instreamInfoModels:(NSArray*)instreamInfoModels
{
}

//(4) When advertising impression notification is complete
- (void)ADVSinstreamAdLoaderDidFinishSendingAdImp
{
}

//(5) When advertising click processing is complete
- (void)ADVSinstreamAdLoaderDidFinishSendingAdClick
{
}

//(6) When advertisement loading fails
- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error
{
}

//(7) When advertisement impression notification fails
- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendImpWithError:(NSError *)error
{
}

//(8)When advertising click processing fails
- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendClickWithError:(NSError *)error
{
}
```

<a name="infeed/custom/param"></a>
### Custom In-feed `Advertisement Parameters`

Reference with `ADVSInstreamInfoModel.h`.

| Parameter name | Explanation | Example |
| --- | --- | --- |
| title | Title wording (20 full-size characters or less) | `TestAd` |
| content | explanation/introductory statement (40–70 full-size characters or less ) | `text advertisement.` |
| position | Relative position of advertisement | `3 `|
| displayedAdvertiser | Cover advertising main name | `Beverage company A` |
| iconImageURL | Icon-type square image (114 × 114 pixel fixed)resource | NSURL object |
| mainImageURL | Banner-type rectangular image (size can be changed for each advertisement | framework ID) resource | NSURL  object |

- The icon-type square image and banner-type rectangular image can be obtained using the following method.  We recommend using this method as the image is cached internally.

 - `- (void)ADVSloadIconImage:(UIImageView*)iconImageView completion:(void (^)(NSError *error)) completion;`
 - `- (void)ADVSloadImage:(UIImageView*)imageView completion:(void (^)(NSError *error)) completion;`
- Please note that the `explanation` and `introductory` test is a `content` property,  not an NSObject  [description](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSObject_Class/index.html#//apple_ref/occ/clm/NSObject/description).

<a name="infeed/custom/format"></a>
### Optional Use of the Advertising Formats Provided as Defaults by SDK
At present, there are seven advertising formats that can be freely used. These are subclasses of the `UITableViewCell`.

```
The files required for the default advertisement format.
Choose the format from:
ADVSInstreamAdCellThumbnailMiddle.h
ADVSInstreamAdCellThumbnailSmall.h
ADVSInstreamAdCellLandscapePhoto.h
ADVSInstreamAdCellPhotoBottom.h
ADVSInstreamAdCellPhotoMiddle.h
ADVSInstreamAdCellTextOnly.h
ADVSInstreamAdCellWebView.h
```

The formats from [simple in-feed advertisements](### Simple In-feed Advertisement Format) can be used.

This is implemented in the following way using the above files, and the default advertising format is displayed.

```objc
//(1) Import the header you wish to use
#import <AppDavis/ADVSInstreamAdCellThumbnailMiddle.h>

- (void)viewDidLoad
{
    //(2) Register the class of advertising format you wish to use in advance
    [self.tableView registerClass:[ADVSInstreamAdCellThumbnailMiddle class] forCellReuseIdentifier:@"ADVSInstreamAdCellThumbnailMiddle"];
    ...
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Judging whether it is an advertisement frame is a media-like implementation
    BOOL isAd = [self isAdCellAt:indexPath];
    if (isAd) {
        ADVSInstreamInfoModel *adItem = (ADVSInstreamInfoModel*)_items[indexPath.row];

        //(3) Extract the advertising format class registered in advance
        UITableViewCell<ADVSInstreamAdCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:@"ADVSInstreamAdCellThumbnailMiddle" forIndexPath:indexPath];

        //(4) Draw the cell based on the loaded advertisement information
        [cell updateCell:adItem completion:^(NSError *error) {

            //(5) Once the drawing is complete, send the impression log
            [self.instreamAdLoader ADVSmeasureImp:adItem];
        }];

        return cell;
    }

    ...
}
```
<a name="update"></a>
# Update history
Check the [CHANGELOG](../CHANGELOG.md)
