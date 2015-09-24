//
//  ADVSSimpleTableViewController.swift
//  DemoAppSwift
//
//  Created by M.T.Burn on 2015/09/08.
//  Copyright (c) 2015年 M.T.Burn. All rights reserved.
//

import UIKit

class ADVSSimpleTableViewController: UITableViewController, ADVSInstreamAdLoaderDelegate {

    let contents = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    let adSpotId = "NDQ0OjMx"
    let adCount:UInt = 2
    let positions = [1,4]
    let instreamAdLoader = ADVSInstreamAdLoader.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Load HIKE advertisements
        instreamAdLoader.delegate = self
        instreamAdLoader.bindToTableView(tableView, adSpotId: adSpotId)
        instreamAdLoader.loadAd(adCount, positions: positions)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - tableView delegate methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")

        cell.textLabel?.text = contents[indexPath.row]
        return cell
    }
    
    // MARK: - HIKE delegate methods
    func instreamAdLoaderDidStartLoadingAd(instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("instreamAdLoaderDidStartLoadingAd")
    }
    
    func instreamAdLoaderDidFinishLoadingAd(instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("instreamAdLoaderDidFinishLoadingAd")
    }
    
    func instreamAdLoaderDidFinishLoadingAdImage(adIndexPath: NSIndexPath!) {
        NSLog("instreamAdLoaderDidFinishLoadingAdImage:row=%d:section=%d", adIndexPath.row, adIndexPath.section)
    }
    
    func instreamAdLoaderDidFinishSendingAdClick() {
        NSLog("instreamAdLoaderDidFinishSendingAdClick")
    }
    
    func instreamAdLoader(instreamAdLoader: ADVSInstreamAdLoader!, didFailToLoadAdWithError error: NSError!) {
        NSLog("instreamAdLoader:didFailToLoadAdWithError:%@", error)
    }
    
    func instreamAdLoader(adIndexPath: NSIndexPath!, didFailToLoadAdImageWithError error: NSError!) {
        NSLog("instreamAdLoader:didFailToLoadAdImageWithError:%@", error)
    }
}
