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
        instreamAdLoader.ADVSbindToTableView(tableView, adSpotId: adSpotId)
        instreamAdLoader.ADVSloadAd(adCount, positions: positions)
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
    func ADVSinstreamAdLoaderDidStartLoadingAd(instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidStartLoadingAd")
    }
    
    func ADVSinstreamAdLoaderDidFinishLoadingAd(instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAd")
    }
    
    func ADVSinstreamAdLoaderDidFinishLoadingAdImage(adIndexPath: NSIndexPath!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAdImage:row=%d:section=%d", adIndexPath.row, adIndexPath.section)
    }
    
    func ADVSinstreamAdLoaderDidFinishSendingAdClick() {
        NSLog("ADVSinstreamAdLoaderDidFinishSendingAdClick")
    }
    
    func ADVSinstreamAdLoader(instreamAdLoader: ADVSInstreamAdLoader!, didFailToLoadAdWithError error: NSError!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdWithError:%@", error)
    }
    
    func ADVSinstreamAdLoader(adIndexPath: NSIndexPath!, didFailToLoadAdImageWithError error: NSError!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdImageWithError:%@", error)
    }
}
