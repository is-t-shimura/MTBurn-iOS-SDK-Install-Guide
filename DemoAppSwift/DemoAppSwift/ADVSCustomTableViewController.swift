//
//  ADVSCustomTableViewController.swift
//  DemoAppSwift
//
//  Created by M.T.Burn on 2015/09/11.
//  Copyright © 2015年 M.T.Burn. All rights reserved.
//

import UIKit

class ADVSCustomTableViewController: UITableViewController, ADVSInstreamAdLoaderDelegate {
    
    var contents:[AnyObject] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
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
        instreamAdLoader.ADVSloadAdWithReturn(adSpotId, adCount: adCount, positions: positions)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - tableView delegate methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if isAdCellAt(indexPath) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "AdCell")
            let item:ADVSInstreamInfoModel = contents[indexPath.row] as! ADVSInstreamInfoModel
            cell.textLabel?.text = item.title
            cell.textLabel?.textColor = UIColor.blueColor()
            cell.detailTextLabel?.text = item.content + " [\(item.displayedAdvertiser)提供]"
            cell.detailTextLabel?.sizeToFit()
            cell.detailTextLabel?.numberOfLines = 0
            
            instreamAdLoader.ADVSmeasureImp(item)
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = String(contents[indexPath.row])
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !isAdCellAt(indexPath) {
            return
        }
        let item:ADVSInstreamInfoProtocol = contents[indexPath.row] as! ADVSInstreamInfoProtocol
        instreamAdLoader.ADVSsendClickEvent(item)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if !isAdCellAt(indexPath) {
            return UITableViewAutomaticDimension
        }
        
        return 74
    }
    
    func isAdCellAt(indexPath:NSIndexPath) -> Bool {
        let item:AnyObject = contents[indexPath.row]
        
        if item is ADVSInstreamInfoProtocol {
            return true
        }
        return false
    }
    
    // MARK: - HIKE delegate methods
    func ADVSinstreamAdLoaderDidStartLoadingAd(instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidStartLoadingAd")
    }
    
    func ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn(instreamAdLoader: ADVSInstreamAdLoader!, instreamInfoModels: [AnyObject]!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:instreamInfoModels adCount=%d", instreamInfoModels.count);
        
        if instreamInfoModels.count < 1 {
            NSLog("_items is invalid. Something wrong occur");
            return
        }
        
        for info:ADVSInstreamInfoProtocol in instreamInfoModels as! [ADVSInstreamInfoModel] {
            contents.insert(info, atIndex: info.position.integerValue)
        }
        
        tableView.reloadData()
    }
    
    func ADVSinstreamAdLoaderDidFinishSendingAdImp() {
        NSLog("ADVSinstreamAdLoaderDidFinishSendingImp")
    }
    
    func ADVSinstreamAdLoaderDidFinishSendingAdClick() {
        NSLog("ADVSinstreamAdLoaderDidFinishSendingAdClick")
    }
    
    func ADVSinstreamAdLoader(instreamAdLoader: ADVSInstreamAdLoader!, didFailToLoadAdWithError error: NSError!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdWithError:%@", error)
    }
    
    func ADVSinstreamAdLoader(instreamAdLoader: ADVSInstreamAdLoader!, didFailToSendImpWithError error: NSError!) {
        NSLog("ADVSinstreamAdLoader:didFailToSendImpWithError:%@", error)
    }
    
    func ADVSinstreamAdLoader(instreamAdLoader: ADVSInstreamAdLoader!, didFailToSendClickWithError error: NSError!) {
        NSLog("ADVSinstreamAdLoader:didFailToSendClickWithError:%@", error)
    }
}

