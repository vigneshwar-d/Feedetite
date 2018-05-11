//
//  FeedCell.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 01/05/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
