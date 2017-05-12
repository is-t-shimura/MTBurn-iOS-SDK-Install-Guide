//
//  ADVSInstreamAppTableViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/05/21.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSInstreamAppTableViewController.h"
#import <AppDavis/ADVSInstreamAdLoader.h>
#import <AppDavis/ADVSInstreamInfoModel.h>
#import <AppDavis/ADVSInstreamWebViewInfoModel.h>
#import <AppDavis/ADVSInstreamAdCellProtocol.h>
#import <AppDavis/ADVSInstreamAdCellWebView.h>
#import "ADVSSmartAppArticleModel.h"
#import "ADVSInstreamAppArticleTableViewCell.h"
#import "ADVSAppDelegate.h"

@interface ADVSInstreamAppTableViewController () <ADVSInstreamAdLoaderDelegate, ADVSExceptionDelegate,
    NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) ADVSInstreamAdLoader *instreamAdLoader;
@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) ADVSSmartAppArticleModel *item;
@property(nonatomic, strong) NSXMLParser *parser;
@property(nonatomic, strong) NSString *elementName;
@property(nonatomic, strong) Class adCellClass;
@property(nonatomic) NSUInteger index;
@end

@implementation ADVSInstreamAppTableViewController

#pragma mark - LifyCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.instreamAdLoader = [ADVSInstreamAdLoader new];
    self.instreamAdLoader.delegate = self;
    self.instreamAdLoader.exceptionDelegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ADVSInstreamAppArticleTableViewCell class]) bundle:nil]
         forCellReuseIdentifier:@"ADVSInstreamAppArticleTableViewCell"];
    
    self.items   = [[NSMutableArray alloc] init];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(startDownload) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self startDownload];
}

#pragma mark - Public
- (void)setupAdCell:(Class)adCellClass index:(NSUInteger) index
{
    _adCellClass = adCellClass;
    self.index = index;
    [self.tableView registerClass:_adCellClass forCellReuseIdentifier:NSStringFromClass(_adCellClass)];
}

#pragma mark - Private
- (void)startDownload
{
    [_items removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"http://rss.asahi.com/rss/asahi/newsheadlines.rdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
        _parser = [[NSXMLParser alloc] initWithData:data];
        _parser.delegate = self;
        [_parser parse];
    }];
}

- (BOOL)isAdCellAt:(NSIndexPath*)indexPath
{
    id item = _items[indexPath.row];
    if ([item isKindOfClass:[ADVSSmartAppArticleModel class]]) {
        return NO;
    }
    return YES;
}

- (UITableViewCell *)adCell:(UITableView *)tableView indexPath:(NSIndexPath*)indexPath
{
    UITableViewCell<ADVSInstreamAdCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(_adCellClass)
                                                                                        forIndexPath:indexPath];
    cell.exceptionDelegate = self;
    
    id item = _items[indexPath.row];
    
    if ([item isKindOfClass:[ADVSInstreamInfoModel class]]) {
        
        ADVSInstreamInfoModel *adItem = (ADVSInstreamInfoModel*)item;
        [cell ADVSupdateCell:adItem completion:^(NSError *error) {
            [_instreamAdLoader ADVSmeasureImp:adItem];
        }];
    } else if ([item isKindOfClass:[ADVSInstreamWebViewInfoModel class]]) {
        
        ADVSInstreamWebViewInfoModel *adItem = (ADVSInstreamWebViewInfoModel*)item;
        [(ADVSInstreamAdCellWebView *)cell ADVSupdateCell:adItem completion:^(NSError *error) {
            [_instreamAdLoader ADVSmeasureImp:adItem];
        }];
    }
    
    return cell;
}

- (void)requestAds
{
    ADVSAppDelegate *delegate = (ADVSAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSArray *adSpotIdDictForInstream = [delegate adspotIdDict][@"custom_instream"];
    
    switch (self.index) {
        case 0:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[0] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 1:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[0] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 2:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[1] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 3:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[2] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 4:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[2] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 5:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[0] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 6:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[3] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 7:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[4] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        case 8:
            [self.instreamAdLoader ADVSloadAdWithReturn:adSpotIdDictForInstream[5] adCount:6 positions:@[@7,@14,@21,@28,@35,@42]];
            break;
        default:
            NSAssert(NO, @"invalid conditions!");
            break;
    }
}

#pragma mark - ADVSInstreamAdLoaderDelegate
- (void)ADVSinstreamAdLoaderDidStartLoadingAd:(ADVSInstreamAdLoader *)instreamAdLoader
{
    NSLog(@"ADVSinstreamAdLoaderDidStartLoadingAd");
}

- (void)ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:(ADVSInstreamAdLoader *)instreamAdLoader
                                  instreamInfoModels:(NSArray*)instreamInfoModels
{
    NSLog(@"ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:instreamInfoModels adCount=%d", (int)[instreamInfoModels count]);
    
    if ([_items count] < 1) {
        NSLog(@"_items is invalid. Something wrong occur");
        return;
    }
    
    for (id<ADVSInstreamInfoProtocol> info in instreamInfoModels) {
        if ([info.position integerValue] < [_items count]) {
            [_items insertObject:info atIndex:[info.position integerValue]];
        }
    }
    [self.tableView reloadData];
}

- (void)ADVSinstreamAdLoaderDidFinishSendingAdImp
{
    NSLog(@"ADVSinstreamAdLoaderDidImpInstreamAd");
}

- (void)ADVSinstreamAdLoaderDidFinishSendingAdClick
{
    NSLog(@"ADVSinstreamAdLoaderDidClickInstreamAd");
}

- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"ADVSinstreamAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendImpWithError:(NSError *)error
{
    NSLog(@"ADVSinstreamAdLoader:didFailToSendImpWithError:%@", error);
}

- (void)ADVSinstreamAdLoader:(ADVSInstreamAdLoader *)instreamAdLoader didFailToSendClickWithError:(NSError *)error
{
    NSLog(@"ADVSinstreamAdLoader:didFailToSendClickWithError:%@", error);
}

#pragma mark - ADVSExceptionDelegate

- (void)ADVSexceptionOccured:(NSError *)error
{
    NSLog(@"ADVSexceptionOccured:%@", error);
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _elementName = elementName;
    if ([_elementName isEqualToString:@"item"]) {
        _item             = [[ADVSSmartAppArticleModel alloc] init];
        _item.title       = @"";
        _item.content     = @"";
        _item.link        = @"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_elementName isEqualToString:@"title"]) {
        _item.title       = [_item.title stringByAppendingString:string];
    } else if ([_elementName isEqualToString:@"description"]){
        _item.content     = [_item.content stringByAppendingString:string];
    } else if ([_elementName isEqualToString:@"link"]){
        _item.link        = [_item.link stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        [_items addObject:_item];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        [self requestAds];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isAd = [self isAdCellAt:indexPath];
    if (!isAd) {
        ADVSSmartAppArticleModel *articleItem = (ADVSSmartAppArticleModel*)_items[indexPath.row];
        ADVSInstreamAppArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ADVSInstreamAppArticleTableViewCell"
                                                                                    forIndexPath:indexPath];
        
        cell.content.text = articleItem.title;
        return cell;
    }
    
    return [self adCell:tableView indexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isAd = [self isAdCellAt:indexPath];
    if (!isAd) {
        return 74.f;
    }
    
    id item = _items[indexPath.row];
    
    if ([item isKindOfClass:[ADVSInstreamInfoModel class]]) {
        
        return [_adCellClass ADVSheightForCell];
    } else if ([item isKindOfClass:[ADVSInstreamWebViewInfoModel class]]) {
        
        ADVSInstreamWebViewInfoModel *adItem = (ADVSInstreamWebViewInfoModel*)item;
        return adItem.height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isAd = [self isAdCellAt:indexPath];
    if (!isAd) {
        return;
    }
    
    id<ADVSInstreamInfoProtocol> adItem = (id<ADVSInstreamInfoProtocol>)_items[indexPath.row];
    [_instreamAdLoader ADVSsendClickEvent:adItem];
}

@end
