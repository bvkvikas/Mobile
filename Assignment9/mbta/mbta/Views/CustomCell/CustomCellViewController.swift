//
//  CustomCellViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/22/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//
import UIKit

class CustomCellViewController: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

