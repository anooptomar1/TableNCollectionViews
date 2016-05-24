//
//  FoldingTableViewController.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 3/13/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import UIKit

class FoldingTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let kCloseCellHeight: CGFloat = 120.0
    let kOpenCellHeight: CGFloat = 400.0
    
    var cellHeights = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for _ in 0...10{
            cellHeights.append(kCloseCellHeight)
        }
    }

   
}

extension FoldingTableViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DemoFoldingCell
        cell.itemCount = 3
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        if cell.isAnimating(){
            return
        }
        
        //cell.itemCount = 4
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight{ // open cell animation
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        }else{ // close cell animation
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animateWithDuration(duration) { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell is FoldingCell{
            let foldingCell = cell as! FoldingCell
            
            if cellHeights[indexPath.row] == kCloseCellHeight{
                foldingCell.selectedAnimation(false, animated: false, completion: nil)
            }else{
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
}
