//
//  ItemPickViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/18/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ItemPickViewController: UITableViewCell {

    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
          super.awakeFromNib()
      }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
}
