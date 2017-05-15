//
//  ADVSCustomTableViewController.swift
//  DemoAppSwift
//
//  Created by M.T.Burn on 2015/09/11.
//  Copyright © 2015年 M.T.Burn. All rights reserved.
//

import UIKit

class ADVSCustomTableViewController: UITableViewController {
    
    var contents:[AnyObject] = ["Sunday" as AnyObject, "Monday" as AnyObject, "Tuesday" as AnyObject, "Wednesday" as AnyObject, "Thursday" as AnyObject, "Friday" as AnyObject, "Saturday" as AnyObject]
    
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
        instreamAdLoader.advSloadAd(withReturn: adSpotId, adCount: adCount, positions: positions)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - tableView delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if isAdCellAt(indexPath) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "AdCell")
            let item:ADVSInstreamInfoModel = contents[indexPath.row] as! ADVSInstreamInfoModel
            cell.textLabel?.text = item.title
            cell.textLabel?.textColor = UIColor.blue
            cell.detailTextLabel?.text = item.content + " [\(item.displayedAdvertiser)提供]"
            cell.detailTextLabel?.sizeToFit()
            cell.detailTextLabel?.numberOfLines = 0
            
            instreamAdLoader.advSmeasureImp(item)
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = String(describing: contents[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isAdCellAt(indexPath) {
            return
        }
        let item:ADVSInstreamInfoProtocol = contents[indexPath.row] as! ADVSInstreamInfoProtocol
        instreamAdLoader.advSsendClickEvent(item)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isAdCellAt(indexPath) {
            return UITableViewAutomaticDimension
        }
        
        return 74
    }
    
    func isAdCellAt(_ indexPath:IndexPath) -> Bool {
        let item:AnyObject = contents[indexPath.row]
        
        if item is ADVSInstreamInfoProtocol {
            return true
        }
        return false
    }
}

extension ADVSCustomTableViewController: ADVSInstreamAdLoaderDelegate {
    func advSinstreamAdLoaderDidStartLoadingAd(_ instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidStartLoadingAd")
    }
    
    @objc(ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:instreamInfoModels:)
    func advSinstreamAdLoaderDidFinishLoadingAd(withReturn instreamAdLoader: ADVSInstreamAdLoader!, instreamInfoModels: [Any]!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAdWithReturn:instreamInfoModels adCount=%d", instreamInfoModels.count);
        
        if instreamInfoModels.count < 1 {
            NSLog("_items is invalid. Something wrong occur");
            return
        }
        
        for info:ADVSInstreamInfoProtocol in instreamInfoModels as! [ADVSInstreamInfoModel] {
            contents.insert(info, at: info.position.intValue)
        }
        
        tableView.reloadData()
    }
    
    func advSinstreamAdLoaderDidFinishSendingAdImp() {
        NSLog("ADVSinstreamAdLoaderDidFinishSendingImp")
    }
    
    func advSinstreamAdLoaderDidFinishSendingAdClick() {
        NSLog("ADVSinstreamAdLoaderDidFinishSendingAdClick")
    }
    
    @objc(ADVSinstreamAdLoader:didFailToLoadAdWithError:)
    func advSinstreamAdLoader(_ instreamAdLoader: ADVSInstreamAdLoader!, didFailToLoadAdWithError error: Error!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdWithError:%@", error as NSError)
    }
    
    @objc(ADVSinstreamAdLoader:didFailToSendImpWithError:)
    func advSinstreamAdLoader(_ instreamAdLoader: ADVSInstreamAdLoader!, didFailToSendImpWithError error: Error!) {
        NSLog("ADVSinstreamAdLoader:didFailToSendImpWithError:%@", error as NSError)
    }
    
    @objc(ADVSinstreamAdLoader:didFailToSendClickWithError:)
    func advSinstreamAdLoader(_ instreamAdLoader: ADVSInstreamAdLoader!, didFailToSendClickWithError error: Error!) {
        NSLog("ADVSinstreamAdLoader:didFailToSendClickWithError:%@", error as NSError)
    }
}
