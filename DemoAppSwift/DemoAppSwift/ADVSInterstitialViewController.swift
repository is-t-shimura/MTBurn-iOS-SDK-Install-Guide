//
//  ADVSInterstitialViewController.swift
//  DemoAppSwift
//
//  Created by M.T.Burn on 2015/09/11.
//  Copyright © 2015年 M.T.Burn. All rights reserved.
//

import UIKit

class ADVSInterstitialViewController: UIViewController, ADVSInterstitialAdLoaderDelegate {
    
    let adSpotId = "OTM0OjQ2MQ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load HIKE advertisements
        ADVSInterstitialAdLoader.sharedInstance().delegate = self;
        ADVSInterstitialAdLoader.sharedInstance().loadRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - HIKE delegate methods
    func interstitialAdLoaderDidStartLoadingAd(interstitialAdLoader: ADVSInterstitialAdLoader!) {
        NSLog("interstitialAdLoaderDidStartLoadingAd")
    }
    
    func interstitialAdLoaderDidFinishLoadingAd(interstitialAdLoader: ADVSInterstitialAdLoader!) {
        NSLog("interstitialAdLoaderDidFinishLoadingAd")
    }
    
    func interstitialAdLoaderDidFinishLoadingAdView(interstitialAdLoader: ADVSInterstitialAdLoader!) {
        NSLog("interstitialAdLoaderDidFinishLoadingAdView")
        
        ADVSInterstitialAdLoader.sharedInstance().displayAd()
    }
    
    func interstitialAdLoaderDidSkipLoadingAd(interstitialAdLoader: ADVSInterstitialAdLoader!) {
        NSLog("interstitialAdLoaderDidSkipLoadingAd")
    }
    
    func interstitialAdLoaderDidClickIntersititialAdView(interstitialAdLoader: ADVSInterstitialAdLoader!) {
        NSLog("interstitialAdLoaderDidClickIntersititialAdView")
    }
    
    func interstitialAdLoaderDidCloseIntersititialAdView(interstitialAdLoader: ADVSInterstitialAdLoader!) {
        NSLog("interstitialAdLoaderDidCloseIntersititialAdView")
    }
    
    func interstitialAdLoader(interstitialAdLoader: ADVSInterstitialAdLoader!, didFailToLoadAdWithError error: NSError!) {
        NSLog("interstitialAdLoader:didFailToLoadAdWithError:%@", error)
    }
    
    func interstitialAdLoader(interstitialAdLoader: ADVSInterstitialAdLoader!, didFailToLoadAdViewWithError error: NSError!) {
        NSLog("interstitialAdLoader:didFailToLoadAdViewWithError:%@", error)
    }
}
