//
//  ViewController.swift
//  3211_sample
//
//  Created by Yohei Yoshimuta on 2016/03/17.
//  Copyright © 2016年 Yohei Yoshimuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ADVSInterstitialAdLoaderDelegate {

    
    let adSpotId = "OTM0OjQ2MQ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load HIKE advertisements
        ADVSInterstitialAdLoader.sharedInstance().delegate = self;
        ADVSInterstitialAdLoader.sharedInstance().loadRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

