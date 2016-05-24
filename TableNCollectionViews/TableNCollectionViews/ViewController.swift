//
//  ViewController.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 2/20/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let tableVDataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.registerNib(UINib(nibName: "tableXibCell", bundle: nil), forCellReuseIdentifier: "basicCell")
        tableView.registerClass(CodedTableViewCell.self, forCellReuseIdentifier: "basicCell")
        
        // delegate and datasource
        tableView.delegate = tableVDataSource
        tableView.dataSource = tableVDataSource
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }

}

