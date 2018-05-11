//
//  SourceCell.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 10/05/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {

    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var sourceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
