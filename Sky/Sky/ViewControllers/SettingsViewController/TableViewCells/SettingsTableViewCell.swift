//
//  SettingsTableViewCell.swift
//  Sky
//
//  Created by Song Zixin on 2019/4/30.
//  Copyright © 2019 SilkSong. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SettingsTableViewCell"
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
