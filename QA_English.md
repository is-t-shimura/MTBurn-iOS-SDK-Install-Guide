# Table of Contents

* [How to Make Inquiries](#howto)
* [What Types of Information are you obtaining from the device?](#info)
* [Approach to the Crash Problem in pre-iOS 6.0 devices](#ios6)
* [What does Instream Mean within the Code?](#instream)
* [Do you have the 〇〇 function?](#function)
* [Do you have a sample project?](#sample)
* [Problems in Displaying the Advertisements (Does Not Display, Overlapped, etc.)](#not_found_ad)
* [What does the Version Number Mean?](#version)
* [Resolving Conflicts with the SDK of Other Companies](#race)
* [iOS9 ATS  Support](#ats)
* [SDK Exception Handling](#exception)

<a name="howto"></a>
# How to Make Inquiries

### Point of Inquiry

- Please utilize [issues](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/issues)
- Where for some reason, it is difficult to inquire using `issues`, inquire via your representative
 - In this case as well, refer to this item for methods other than using your point of inquiry

<a name="info"></a>
# What Type of Information are you obtaining from the device?
- The following information is obtained

| Name | API | Details |
| --- | --- | --- |
| IDFA | `ASIdentifierManager advertisingIdentifier` | This is not obtained when the user has the opt-out setting |
| OS | `UIDevice systemName` | `iPhone OS` etc. |
| OS  version | `UIDevice systemVersion` | `5.0.1` , `7.1` etc. |
| Device name | `utsname machine` | `iPhone 4.1` , `iPhone 7.1` etc. |
| Language settings | `NSLocale preferredLanguages [0]` | `ja` , `en` etc. |
| Country code | `NSLocale NSLocaleCountryCode` | `JP` , `US` etc. |

<a name="ios6"></a>
# Approach to the Crash Problem in pre-iOS 6.0 devices
As the supported OS for this SDK is 6.0 or later, advertisements cannot be displayed on pre-6.0 devices.

However, as SDK has not yet implemented crash avoidance measures, the procedure for dealing with the developer applications will be described here.

- Only iOS version 6.0 or later will attempt to call the SDK method

```objc
 if (NSFoundationVersionNumber_iOS_6_0 <= floor(NSFoundationVersionNumber)) {
        [AppDavis initMedia:@"1"];
}
...
```

Linking of AdSupport and Foundation to the developer application is optional.

<a name="instream"></a>
# What does Instream Mean within the Code?
In this guide, it has the same meaning as `In-feed`.

<a name="function"></a>
# Does it have a 〇〇 function?
Public APIs are collected within the [Headers](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/tree/master/AppDavis.framework/Headers) or the [API specification page](http://mtburn.github.io/MTBurn-iOS-SDK-Install-Guide/appledoc/latest/)

<a name="sample"></a>
# Do You Have a Sample Project?
Refer to the [DemoApp](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/tree/master/DemoApp)

<a name="not_found_ad"></a>
# Problems in displaying the advertisements (does not display, overlapped, etc.)
The cause can be generally analyzed in the following order. The method of handling each of the respective causes is shown.

1. There is a problem with the account
2. There is a problem with the method of calling the application

### There is a problem with the account

Here, `account` refers to the `media ID (media_id)` and the linked `adspot ID (adspot_id)`.

First, there may be a problem with the settings of the issued `account`. In order to confirm this, please try using a different `account`. For this second account, refer to the respective `adspot IDs` linked to `media_id 1 or media_id 2` in this document.

When doing this, `media_id 2` and its respective `adspot ID` (hereafter, `the test account displaying the main advertisement`) may in rare cases be unable to obtain the advertisement. This is because of the nature of the main advertisement being obtained. When the advertisement cannot be displayed even with `the test account used for displaying the main advertisement`, try using `a test account to display a test advertisement`.

`The test account for displaying test advertisements` is the `media_id` `1`, with `the following advertisement IDs`:

| Ad Spot ID corresponding to media_id 1 | Ad Spot ID corresponding to media_id 2 | Advertisement image size | Advertisement format |
| --- | --- | --- | --- |
| NDgzOjE | NDQ0OjMx | 114x114 pixel | ThumnailMiddle |
| Njc4OjI | OTA2OjMy | 114x114 pixel | ThumnailSmall |
| NzA3OjM | ODEzOjMz | 640x200 pixel | LandscapePhoto |
| MTY5OjQ | OTIyOjM0	640x320 pixel | PhotoBottom |
| OTMzOjU | NzA2OjM1 | 640x320 pixel | PhotoMiddle |
| MzUxOjk | MzA3OjM2 | 114x114 pixel | TextOnly |
| OTgxOjUy | MTI2OjU1 | 114x114 pixel | WebView (Small) |
| MjQxOjUz | OTkzOjU2 | 640x200 pixel | WebView (Medium) |
| NjA0OjU0 | MzEzOjU3 | 640x320 pixel | WebView (Large) |

### There is a problem with the method for calling the application

If the problem is not resolved even after trying with all three issued accounts, i.e., `the test account for displaying the main advertisement` and `the test account for displaying the test advertisement`, check whether there is a problem with the account, with the application, or with SDK.

[The demo project](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/blob/master/DemoApp) that came with SDK uses `the test account for displaying the main advertisement` by default. By starting and displaying using this account, you can ascertain whether there is a problem in the method for calling the application. As `the account` can be reset using `ADVSAppDelegate.m`, use this to check whether there is a problem with `the account`.

Contact your representative if there is a problem with `your account`.

<a name="version"></a>
# What does the Version Number Mean?
This follows [semver](http://semver.org/)

<a name="race"></a>
# Resolving Conflicts with the SDKs of Other Companies
If you are using Hike SDK and the advertisement SDKs from other companies, conflicts may occur. Cases where some of the functionalities of the Hike SDK have not been available have been reported.

To resolve this, separate the initialization processing calls (in the case of Hike, `initMedia` function). This may avoid conflicts.

### Known Conflicts and Problems and Methods of Resolution

We have confirmed that conflicts occur prior to `i-mobile ios sdk 1.30`

- We have also confirmed that the problem is resolved by upgrading to a newer version.

<a name="ats"></a>
# iOS9 ATS Support
The SDK version must be v2.0.1 or greater.

It is not necessary to disable ATS separately on the application side.

<a name="exception"></a>
# SDK Exception Handling

From v3.1.0, if exceptions generated inside the SDK occurs, you can receive information as NSError using ADVSExceptionDelegate on the application side.
See each header files and `DemoApp` for usage.

- Note: Even if the application does not deal with it, it is designed not to cause crashes by exception as much as possible
