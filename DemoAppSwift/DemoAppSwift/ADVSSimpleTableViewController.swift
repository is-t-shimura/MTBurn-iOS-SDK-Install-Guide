//
//  ADVSSimpleTableViewController.swift
//  DemoAppSwift
//
//  Created by M.T.Burn on 2015/09/08.
//  Copyright (c) 2015年 M.T.Burn. All rights reserved.
//

import UIKit

class ADVSSimpleTableViewController: UITableViewController {

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
        instreamAdLoader.advSbind(to: tableView, adSpotId: adSpotId)
        instreamAdLoader.advSloadAd(adCount, positions: positions)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - tableView delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")

        cell.textLabel?.text = contents[indexPath.row]
        return cell
    }
}

extension ADVSSimpleTableViewController: ADVSInstreamAdLoaderDelegate {
    func advSinstreamAdLoaderDidStartLoadingAd(_ instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidStartLoadingAd")
    }
    
    func advSinstreamAdLoaderDidFinishLoadingAd(_ instreamAdLoader: ADVSInstreamAdLoader!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAd")
    }
    
    func advSinstreamAdLoaderDidFinishLoadingAdImage(_ adIndexPath: IndexPath!) {
        NSLog("ADVSinstreamAdLoaderDidFinishLoadingAdImage:row=%d:section=%d", adIndexPath.row, adIndexPath.section)
    }
    
    func advSinstreamAdLoaderDidFinishSendingAdClick() {
        NSLog("ADVSinstreamAdLoaderDidFinishSendingAdClick")
    }
    
    @objc(ADVSinstreamAdLoader:didFailToLoadAdWithError:)
    func advSinstreamAdLoader(_ instreamAdLoader: ADVSInstreamAdLoader!, didFailToLoadAdWithError error: Error!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdWithError:%@", error as NSError)
    }
    
    @objc(ADVSinstreamAdLoader:didFailToLoadAdImageWithError:)
    func advSinstreamAdLoader(_ adIndexPath: IndexPath!, didFailToLoadAdImageWithError error: Error!) {
        NSLog("ADVSinstreamAdLoader:didFailToLoadAdImageWithError:%@", error as NSError)
    }
}
