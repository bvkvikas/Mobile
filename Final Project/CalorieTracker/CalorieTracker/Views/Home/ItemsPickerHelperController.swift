//
//  ItemsPickerHelperController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/21/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ItemsPickerHelperController : UINavigationController {
    
    var dateToAdd : String?
    var mealType: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationViewController = segue.destination as? ItemsPickerViewController {
            destinationViewController.mealType = segue.identifier!
            destinationViewController.dateToAdd = dateToAdd
            
            
        }
    }
}
