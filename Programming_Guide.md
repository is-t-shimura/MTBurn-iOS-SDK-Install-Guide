#目次

* [まずはじめに](#start)
    * [Media Id の取得](#start/media_id)
    * [コード内初期化](#start/init)
* [インタースティシャル広告](#interstitial)
    * [インタースティシャル広告の表示](#interstitial/display)
    * [インタースティシャル広告表示時のイベント取得](#interstitial/event)
    * [インターステイシャル広告の表示頻度の制御](#interstitial/freq)
* [インフィード広告](#infeed)
    * [広告枠IDの取得](#infeed/adspot_id)
    * [簡易版インフィード広告](#infeed/simple)
        * [簡易版インフィード広告の表示](#infeed/simple/display)
        * [簡易版インフィード広告の表示時のイベント取得](#infeed/simple/event)
        * [簡易版インフィード広告の追加ロード](#infeed/simple/additional_load)
        * [簡易版インフィード広告フォーマット](#infeed/simple/format)
        * [簡易版インフィード広告を使う上での注意点](#infeed/simple/caution)
    * [カスタムインフィード広告](#infeed/custom)
        * [カスタムインフィード広告のロード](#infeed/custom/load)
        * [カスタムインフィード広告の表示](#infeed/custom/display)
        * [カスタムインフィード広告のインプレッション通知](#infeed/custom/imp)
        * [カスタムインフィード広告のクリック時の遷移処理](#infeed/custom/click)
        * [カスタムインフィード広告のロードと各種通知時のイベント取得](#infeed/custom/event)
        * [カスタムインフィード広告パラメータ](#infeed/custom/param)
        * [SDKがデフォルトで提供する広告フォーマットの任意利用](#infeed/custom/format)
* [更新履歴](#update)

<a name="start"></a>
#まずはじめに

本ガイドは SDK の使い方の概略を示したものです。

詳細な API 仕様などについては、framework内の各ヘッダーファイルのコメントも参照ください。

<a name="start/media_id"></a>
##Media Id の取得

管理画面より登録し、Media Id を発行します。

この Media Id はアプリの識別に用いるものですので、忘れない様にして下さい。

###テスト用 ID

テスト用の Media Id 1 をご利用いただくことができます。ダミーデータが表示され、動作確認が可能です。
インターステイシャル広告以外では、Media Id 2 を使うこともできます。本番データが表示されるので、見た目の確認に使えます。

<a name="start/init"></a>
##コード内初期化

上記で取得した media_id を引数に、 AppDavis を初期化します。

特別な理由が無い限り、

[UIApplicationDelegate -application:didFinishLaunchingWithOptions:](https://developer.apple.com/library/ios/documentation/uikit/reference/UIApplicationDelegate_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UIApplicationDelegate/application:didFinishLaunchingWithOptions:)

に記述して下さい。

```objc
// (1) ヘッダファイルの指定
#import <AppDavis/AppDavis.h>

// (2) 初期化メソッドの呼び出し
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AppDavis initMedia:@"your_media_id"];

    // ...
}
```

この**初期化を行わない限り、後述する広告の取得全般を行う事ができません**ので注意して下さい。

<a name="interstitial"></a>
#インタースティシャル広告

<a name="interstitial/display"></a>
##インタースティシャル広告の表示

### 広告枠IDの取得
管理画面から広告枠 ID を発行します。

インタースティシャル広告の表示に必要なファイルは以下です。

```
ADVSInterstitialAdLoader.h
```

ADVSInterstitialAdLoader を用いて以下の様に実装し、インタースティシャル広告を表示します。

```objc

//(1) ヘッダーをインポート
#import <AppDavis/ADVSInterstitialAdLoader.h>

@interface YourViewController ()
@end


- (void)viewDidLoad
{
    [super viewDidLoad];

    //(2) 広告枠 ID を設定
    [[ADVSInterstitialAdLoader sharedInstance] setAdSpotId:adspot_id];

    //(3) ADVSInterstitialAdLoader シングルトンを取得して、delegate を設定
    [ADVSInterstitialAdLoader sharedInstance].delegate = self;

    //(4) インタースティシャル広告ロードの呼び出し
    [[ADVSInterstitialAdLoader sharedInstance] loadRequest];
}

//(5) インターステイシャル広告表示準備の完了
- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    //(6) インターステイシャル広告表示の呼び出し
    [[ADVSInterstitialAdLoader sharedInstance] displayAd];
}

```

上記のように実装する事で、インターステイシャル広告を表示する事が出来ます。

<a name="interstitial/event"></a>
##インタースティシャル広告表示時のイベント取得

インタースティシャル広告を表示する際に、そのイベントを受け取りたい場合があります。

その場合は ADVSInterstitialAdLoader のプロパティである delegate が、

ADVSInterstitialAdLoaderDelegate に準拠しているので、それ経由で受信する事が出来ます。

```objc
- (void)viewDidLoad
{
    //(1) delegate を設定
    [ADVSInterstitialAdLoader sharedInstance].delegate = self;
}

//(2)広告のロード開始時
- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(3)広告のロード完了時
- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(4)広告 View のロード完了時
- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(5)広告のクリック時
- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(6)広告のロード失敗時
- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error
{
}

//(7)広告 View のロード失敗時
- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error
{
}

//(8)広告のロードスキップ時
- (void)interstitialAdLoaderDidSkipLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}
```

<a name="interstitial/freq"></a>
##インターステイシャル広告の表示頻度の制御

インターステイシャル広告を表示する頻度を制御することができます。

頻度については、「間隔時間」と「スキップ回数」の設定が可能です。

間隔時間を設定した場合は、一度広告が表示された後、指定された時間の間に`loadRequest`を呼び出しても、広告が表示されなくなります。

スキップ回数を設定した場合は、設定した回数分、`loadRequest`を呼び出しても、スキップされます。

また、アプリを起動してから最初に広告が表示されるまでの頻度についても、別途設定することができます。

これによって、次のようなケースに対応することができます。
- case 1.
	- 設定なし（毎回呼ばれます）
- case 2.
	- 初回起動後 6 回目の API call で表示、それ以降は前回表示後 11 回目の API call ごとに表示
	- 広告枠 ID に `OTM0OjQ1Ng`  をセットして試すことができます
- case 3.
	- 初回起動後 11 秒後の API call で表示、それ以降は前回表示後 21 秒後の API call ごとに表示
	- 広告枠 ID に `Mjg5OjQ1Nw`  をセットして試すことができます
- case 4.
	- 初回起動後 6 回目の API call で表示、それ以降は前回表示後  21 秒後の API call ごとに表示
	- 広告枠 ID に `ODA5OjQ1OA`  をセットして試すことができます
- case 5.
	- 初回起動後 11 秒後の API call で表示、それ以降は前回表示後  11 回目の API call ごとに表示
	- 広告枠 ID に `MzIzOjQ1OQ`  をセットして試すことができます

この機能を実装するには、ADVSInterstitialAdLoader のプロパティである adSpotId に広告枠 ID をセットしてください。スキップ時は delegate の `interstitialAdLoaderDidFinishLoadingAdView:interstitialAdLoader` の代わりに、`interstitialAdLoaderDidSkipLoadingAd:interstitialAdLoader` が呼び出されます。

```objc
[ADVSInterstitialAdLoader sharedInstance].adSpotId = @"your_adspot_id";
```

<a name="infeed"></a>
#インフィード広告

<a name="infeed/adspot_id"></a>
## 広告枠IDの取得
管理画面から広告枠 ID を発行します。次の情報を設定し、広告枠IDが払い出されます。

- 広告枠名
- 広告画像サイズ
- [広告フォーマット](#簡易版インフィード広告フォーマット)（後述する簡易版インフィード広告のみ必要）
- 広告案件数
- 広告位置配列
- HTML, width, height （WebView 上で描画するフォーマットを選択した場合のみ必要）

現在はテスト用に、次の情報が設定されています（テスト用途に必要な範囲で記載します）。
本物の案件とリンクしているため、下記案件数を下回る場合があります。その際は、担当者までご連絡ください。

media_id に 2 をセットした上で、下記広告枠 ID (adspot_id) をセットしてください

```
広告枠ID: NDQ0OjMx
広告画像サイズ: 114x114 pixel
広告フォーマット: ThumnailMiddle
1リクエストあたりの広告案件数: 2
広告位置配列: 3,6
```

```
広告枠ID: OTA2OjMy
広告画像サイズ: 114x114 pixel
広告フォーマット: ThumnailSmall
1リクエストあたりの広告案件数: 1
広告位置配列: 4
```

```
広告枠ID: ODEzOjMz
広告画像サイズ: 640x200 pixel
広告フォーマット: LandscapePhoto
1リクエストあたりの広告案件数: 3
広告位置配列: 0,1,2
```

```
広告枠ID: OTIyOjM0
広告画像サイズ: 640x320 pixel
広告フォーマット: PhotoBottom
1リクエストあたりの広告案件数: 4
広告位置配列: 5,7,9,10
```

```
広告枠ID: NzA2OjM1
広告画像サイズ: 640x320 pixel
広告フォーマット: PhotoMiddle
1リクエストあたりの広告案件数: 6
広告位置配列: 2,4,6,8,10,12
```

```
広告枠ID: MzA3OjM2
広告画像サイズ: 114x114 pixel
広告フォーマット: TextOnly
1リクエストあたりの広告案件数: 6
広告位置配列: 5,10,15,20,25,30
```

```
広告枠ID: MTI2OjU1
広告画像サイズ: 114x114 pixel
広告フォーマット: WebView（小）
1リクエストあたりの広告案件数: 3
広告位置配列: 5,10,15
HTML: <html><head><META http-equiv="Content-Type" content="text/html";charset="UTF-8"><styl
e type="text/css"> .box1,.box2{display: table-cell;vertical-align:top;}.box1{width: 40px;}</style></head><body><div class="box1"><img width="32" height="32" src="[% AD_ICON_IMAGE
_URL %]"/></div><div class="box2"><span style="font-size:14.5px;"><font color="#0066cc">[% AD_TITLE %]</font></span></div><div class="desc"><span style="font-size:11.5px;">[% AD_
DESCRIPTION %]</span></div></body></html>
width: NULL(画面横幅いっぱい)
height:80
```

```
広告枠ID: OTkzOjU2
広告画像サイズ: 640x200 pixel
広告フォーマット: WebView（中）
1リクエストあたりの広告案件数: 3
広告位置配列: 5,10,15
HTML:<html><head><META http-equiv="Content-Type" content="text/html";charset="UTF-8"><styl
e type="text/css"> .box1,.box2{display: table-cell;vertical-align:top;}.box1{width: 22px;}.main_img{text-align: center;}</style></head><body><div class="main_img"><img width="300
" height="94" src="[% AD_MAIN_IMAGE_URL %]"/></div><div class="desc"><span style="font-size:13px;">[% AD_DESCRIPTION %]</span></div><div class="box1"><img width="18" height="18"
src="[% AD_ICON_IMAGE_URL %]"/></div><div class="box2"><span style="font-size:14.0px;"><font color="#0066cc">[% AD_TITLE %]</font></span></div></body></html>
width: NULL(画面横幅いっぱい)
height:165
```

```
広告枠ID: MzEzOjU3
広告画像サイズ: 640x320 pixel
広告フォーマット: WebView（大）
1リクエストあたりの広告案件数: 3
広告位置配列: 5,10,15
HTML:<html><head><META http-equiv="Content-Type" content="text/html";charset="UTF-8"><styl
e type="text/css"> .box1,.box2{display: table-cell;vertical-align:top;}.box1{width: 40px;}.main_img{text-align: center;}</style></head><body><div class="box1"><img width="32" height="32" src="[% AD_ICON_IMAGE_URL %]"/></div><div class="box2"><span style="font-size:14.5px;"><font color="#0066cc">[% AD_TITLE %]</font></span></div><div class="desc"><span style="font-size:11.5px;">[% AD_DESCRIPTION %]</span></div><div class="main_img"><img width="300" height="150" src="[% AD_MAIN_IMAGE_URL %]"/></div></body></html>
width: NULL(画面横幅いっぱい)
height:230
```

**現在は、新規広告枠の登録設定については担当者へお問い合わせください。**

<a name="infeed/simple"></a>
##簡易版インフィード広告

簡易版インフィード広告は`UITableView`の利用を前提としています。

それ以外での利用については、後述するカスタムインフィード広告を参照してください。

<a name="infeed/simple/display"></a>
###簡易版インフィード広告の表示
In-Feed広告の表示に必要なファイルは以下です。

```
ADVSInstreamAdLoader.h
```

上記ファイルを用いて以下の様に実装し、In-Feed広告をロードします。

```objc

//(1) ヘッダーをインポート
#import <AppDavis/ADVSInstreamAdLoader.h>

@interface YourViewController ()
//(2) プロパティを定義
@property(nonatomic) ADVSInstreamAdLoader *instreamAdLoader;
@end

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //(3) ADVSInstreamAdLoader をインスタンス化。delegate を設定
    self.instreamAdLoader = [ADVSInstreamAdLoader new];
    self.instreamAdLoader.delegate = self;

    //(4) In-Feed広告を挿入したいtableViewと広告枠IDを設定
    [self.instreamAdLoader bindToTableView:self.tableView adSpotId:@"NDQ0OjMx"];

    // 媒体様のデータ取得完了を待って
    ...

    //(5) In-Feed広告ロードを呼び出し
    [self.instreamAdLoader loadAd];
}

```

上記のように実装する事で、In-Feed広告を表示する事が出来ます。
`[your_tableView reloadData]`を呼ぶ必要はありません。`[your_tableView reloadData]`を呼ぶ必要がある場合は、`[self.instreamAdLoader reloadData];`を呼んでください。

1リクエストあたりの広告案件数と広告位置配列は、`[self.instreamAdLoader loadAd:6 positions:@[@2,@4,@6,@8,@10,@12]];`などのAPIを使ってコントロールすることも出来ます。

<a name="infeed/simple/event"></a>
###簡易版インフィード広告の表示時のイベント取得
In-Feed広告の表示をする際に、そのイベントを受け取りたい場合があります。

その場合は `ADVSInstreamAdLoader ` のプロパティである delegate が、`ADVSInstreamAdLoaderDelegate` に準拠しているので、それ経由で受信する事が出来ます。

```objc
- (void)viewDidLoad
{
    //(1) delegate を設定
    self.instreamAdLoader.delegate = self;
}

//(2)広告のロード開始時
- (void)instreamAdLoaderDidStartLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
}

//(3)広告のロード完了時
- (void)instreamAdLoaderDidFinishLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
}

//(4)広告Viewのロード完了時
- (void)instreamAdLoaderDidFinishLoadingAdImage:(NSIndexPath *)adIndexPath
{
}

//(5)広告のクリック処理完了時
- (void)instreamAdLoaderDidFinishSendingAdClick
{
}

//(6)広告のロード失敗時
- (void)instreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error
{
}

//(7)広告Viewのロード失敗時
- (void)instreamAdLoader:(NSIndexPath *)adIndexPath didFailToLoadAdImageWithError:(NSError *)error
{
}

```

<a name="infeed/simple/additional_load"></a>
###簡易版インフィード広告の追加ロード
ユーザーがサイト下部に到達した際に追加フィードを読み込むような UI の場合に、追加で広告ロードを行うことも可能です。

```objc
- (void)loadMore
{
	// 追加の広告をロードして、広告位置配列をもとにテーブル内の適切な位置に挿入します
    [self.instreamAdLoader loadAd];
}
```

<a name="infeed/simple/format"></a>
###簡易版インフィード広告フォーマット

現状、7つの広告フォーマットを利用できます。設定は[こちら](##広告枠IDの取得)になります。

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
	- HTML を入稿することで、アプリ内 WebView 上で描画することが出来ます。

<a name="infeed/simple/caution"></a>
###簡易版インフィード広告を使う上での注意点

`- (void)bindToTableView:adSpotId:`に渡す`UITableView`は、section数が1つである場合のみ動作保証されます。

<a name="infeed/custom"></a>
##カスタムインフィード広告

簡易版インフィード広告よりも柔軟な表示を行いたい場合などに、カスタム型のインフィード広告機能を利用することが出来ます。

下記のガイドでは、`UITableView`を前提とした例を示しますが、`UIView`などその他の場合でも利用が可能です。

<a name="infeed/custom/load"></a>
###カスタムインフィード広告のロード
In-Feed広告のロードに必要なファイルは以下です。

```
ADVSInstreamAdLoader.h
ADVSInstreamInfoModel.h
```

上記ファイルを用いて以下の様に実装し、In-Feed広告をロードします。

```objc

//(1) ヘッダーをインポート
#import <AppDavis/ADVSInstreamAdLoader.h>
#import <AppDavis/ADVSInstreamInfoModel.h>

@interface YourViewController ()<ADVSInstreamAdLoaderDelegate>
//(2) プロパティを定義
@property(nonatomic) ADVSInstreamAdLoader *instreamAdLoader;
@end

@implementation YourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //(3) ADVSInstreamAdLoader をインスタンス化。delegate を設定
    self.instreamAdLoader = [ADVSInstreamAdLoader new];
    self.instreamAdLoader.delegate = self;

    //(4) In-Feed広告ロードを呼び出し
    [self.instreamAdLoader loadAdWithReturn:@"NDQ0OjMx" adCount:6 positions:@[@3,@6,@9,@12,@15,@18]];
}

//(5) In-Feed広告ロードの完了
- (void)instreamAdLoaderDidFinishLoadingAdWithReturn:(ADVSInstreamAdLoader *)instreamAdLoader
                                  instreamInfoModels:(NSArray*)instreamInfoModels
{
	//(6) Instrea広告情報を受け取る
    for (ADVSInstreamInfoModel *info in instreamInfoModels) {
        [_items insertObject:info atIndex:[info.position integerValue]];
    }
	//(7) 表示を更新する
    [self.tableView reloadData];
}

```

上記のように実装する事で、In-Feed広告をロードする事が出来ます。

<a name="infeed/custom/display"></a>
###カスタムインフィード広告の表示
`ADVSInstreamInfoModel.h`から取り出した情報をもとに、広告を表示させます。`position`は、広告の成果分析に使われるため、画面内の位置を決める参考にしてください。

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

    [infoModel loadIconImage:self.adIconImageView completion:^(NSError *iconImageLoadError) {
        [infoModel loadImage:self.adImageView completion:^(NSError *imageLoadError) {
            if (iconImageLoadError || imageLoadError) {
                NSLog(@"error");
            } else {
                NSLog(@"ok, start sending an impression log");
			     [self.instreamAdLoader measureImp:infoModel];
            }
        }];
    }];

```

<a name="infeed/custom/imp"></a>
###カスタムインフィード広告のインプレッション通知
広告の表示が完了したら、インプレッションを通知してください。
`ADVSInstreamAdLoader.h`の`measureImp:`を呼び出してください。


<a name="infeed/custom/click"></a>
###カスタムインフィード広告のクリック時の遷移処理
広告がクリックされたら、以下のメソッドを呼び出すことで、適切にユーザーを遷移させることができます。
`ADVSInstreamAdLoader.h`の`sendClickEvent:`を呼び出してください。

<a name="infeed/custom/event"></a>
###カスタムインフィード広告のロードと各種通知時のイベント取得
In-Feed広告のロードや各種通知をする際に、そのイベントを受け取りたい場合があります。

その場合は `ADVSInstreamAdLoader ` のプロパティである delegate が、`ADVSInstreamAdLoaderDelegate` に準拠しているので、それ経由で受信する事が出来ます。

```objc
- (void)viewDidLoad
{
    //(1) delegate を設定
    self.instreamAdLoader.delegate = self;
}

//(2)広告のロード開始時
- (void)instreamAdLoaderDidStartLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
}

//(3)広告のロード完了時
- (void)instreamAdLoaderDidFinishLoadingAdWithReturn:(ADVSInstreamAdLoader *)instreamAdLoader
                                  instreamInfoModels:(NSArray*)instreamInfoModels
{
}

//(4)広告のインプレッション通知完了時
- (void)instreamAdLoaderDidFinishSendingAdImp
{
}

//(5)広告のクリック処理完了時
- (void)instreamAdLoaderDidFinishSendingAdClick
{
}

//(6)広告のロード失敗時
- (void)instreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error
{
}

//(7)広告のインプレッション通知失敗時
- (void)instreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendImpWithError:(NSError *)error
{
}

//(8)広告のクリック処理失敗時
- (void)instreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendClickWithError:(NSError *)error
{
}

```

<a name="infeed/custom/param"></a>
###カスタムインフィード広告パラメータ
`ADVSInstreamInfoModel.h`を合わせて参照ください。

| パラメータ名 | 説明 | 例 |
| --- | --- | --- |
| title | タイトル文言(全角20文字以内) | `TestAd` |
| content | 説明・紹介文(全角40~70文字以内) | `テスト広告です。` |
| position | 広告案件の 相対位置 | `3` |
| displayedAdvertiser | 表記広告主名 | `飲料会社 A社` |
| iconImageURL | アイコン型の正方形画像(114x114 pixel固定)リソース | NSURL オブジェクトです |
| mainImageURL | バナー型の矩形画像(広告枠IDごとにサイズ可変)リソース | NSURL オブジェクトです |

- アイコン型の正方形画像とバナー型の矩形画像は次のメソッドを使っても取得することができます。このメソッドは内部的に画像をキャッシュしてくれるため、利用を推奨します。
 - `- (void)loadIconImage:(UIImageView*)iconImageView completion:(void (^)(NSError *error)) completion;`
 - `- (void)loadImage:(UIImageView*)imageView completion:(void (^)(NSError *error)) completion;`
- `説明・紹介文` は `content` プロパティです。NSObject の [description](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSObject_Class/index.html#//apple_ref/occ/clm/NSObject/description) メソッドではありません。ご注意ください。

<a name="infeed/custom/format"></a>
###SDKがデフォルトで提供する広告フォーマットの任意利用

現状、7つの広告フォーマットを自由に利用できます。`UITableViewCell`のサブクラスです。

デフォルト広告フォーマットの利用に必要なファイルは以下です。

```
ADVSInstreamAdCellThumbnailMiddle.h
ADVSInstreamAdCellThumbnailSmall.h
ADVSInstreamAdCellLandscapePhoto.h
ADVSInstreamAdCellPhotoBottom.h
ADVSInstreamAdCellPhotoMiddle.h
ADVSInstreamAdCellTextOnly.h
ADVSInstreamAdCellWebView.h
のうち、利用するフォーマットのものを選択する
```

[簡易版インフィード広告から利用できるフォーマット](#簡易版インフィード広告フォーマット)を利用することができます。

上記ファイル を用いて以下の様に実装し、デフォルト広告フォーマットを表示します。

```objc
//(1) 利用したいヘッダーをインポート
#import <AppDavis/ADVSInstreamAdCellThumbnailMiddle.h>

- (void)viewDidLoad
{
	//(2) 利用したい広告フォーマットのクラスを事前に登録する
    [self.tableView registerClass:[ADVSInstreamAdCellThumbnailMiddle class] forCellReuseIdentifier:@"ADVSInstreamAdCellThumbnailMiddle"];
	...
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// 広告枠かどうかの判定は、媒体様実装
    BOOL isAd = [self isAdCellAt:indexPath];
    if (isAd) {
        ADVSInstreamInfoModel *adItem = (ADVSInstreamInfoModel*)_items[indexPath.row];

		//(3) 事前に登録した広告フォーマットのクラスを取り出す
	    UITableViewCell<ADVSInstreamAdCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:@"ADVSInstreamAdCellThumbnailMiddle" forIndexPath:indexPath];

		//(4) ロードした広告の情報をもとにセルを描画する
	    [cell updateCell:adItem completion:^(NSError *error) {

			//(5) 描画が完了後、インプレッションログを送信する
    	    [self.instreamAdLoader measureImp:adItem];
	    }];

    	return cell;
    }

    ...
}
```

<a name="update"></a>
# 更新履歴

[CHANGELOG](../CHANGELOG.md) をご確認ください
