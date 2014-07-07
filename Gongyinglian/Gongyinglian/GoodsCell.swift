//
//  GoodsCell.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-7.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import UIKit

class GoodsCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel
    @IBOutlet var codeLabel: UILabel
    @IBOutlet var countLabel: UILabel
    @IBOutlet var sellButton: UIButton

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
