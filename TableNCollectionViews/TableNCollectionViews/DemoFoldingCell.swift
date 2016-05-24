//
//  DemoFoldingCell.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 3/13/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import UIKit

class DemoFoldingCell: FoldingCell {

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    override func animationDuration(itemIndex: NSInteger, type: AnimationType) -> NSTimeInterval {
        let duration = [0.26, 0.2, 0.2]
        return duration[itemIndex]
    }
}
