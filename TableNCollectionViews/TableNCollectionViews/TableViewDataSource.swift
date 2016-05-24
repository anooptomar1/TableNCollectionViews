//
//  TableViewDataSource.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 2/28/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as! CodedTableViewCell
        //cell.textLabel!.text = "row \(indexPath.row)"
        cell.customButton.setTitle("Hola \(indexPath.row)", forState: UIControlState.Normal)
        if indexPath.row % 2 == 0{
            cell.titleLabel.text = "A UITableViewCell of one of the four default types has a whole range of properties that you can access to configure the content. This section presents four key properties—textLabel, d"
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            cell.titleLabel.textColor = UIColor.blueColor()
        }else{
            cell.titleLabel.text = "A UITableViewCell of one of the four default types"
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            cell.titleLabel.textColor = UIColor.lightGrayColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
