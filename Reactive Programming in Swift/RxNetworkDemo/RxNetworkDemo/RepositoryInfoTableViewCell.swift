//
//  RepositoryInfoTableViewCell.swift
//  RxNetworkDemo
//
//  Created by Song Zixin on 2020/2/7.
//  Copyright © 2020 Song Zixin. All rights reserved.
//

import UIKit

class RepositoryInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
