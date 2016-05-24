//
//  CodedTableViewCell.swift
//  TableNCollectionViews
//
//  Created by Anoop tomar on 2/28/16.
//  Copyright © 2016 Devtechie. All rights reserved.
//

import UIKit

class CodedTableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    var customButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutView()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func layoutView(){
        // disable automask constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        customButton.translatesAutoresizingMaskIntoConstraints = false
        
        // add as subview
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(customButton)
        
        // properties
        titleLabel.textColor = UIColor.darkGrayColor()
        customButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        titleLabel.numberOfLines = 0
        
        titleLabel.tag = 100
        customButton.tag = 101
        
        
        let subviewConstraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraintEqualToAnchor(self.contentView.bottomAnchor, constant: -8),
            customButton.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -8),
            titleLabel.trailingAnchor.constraintEqualToAnchor(customButton.leadingAnchor, constant: 8),
            customButton.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activateConstraints(subviewConstraints)
    }

}
