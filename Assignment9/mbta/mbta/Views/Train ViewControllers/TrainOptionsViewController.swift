//
//  TrainOptionsViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/22/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class TrainOptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let destinationViewController = segue.destination as? SearchUpdateDeleteViewController {
                destinationViewController.action = segue.identifier!
            }
      
    }
    

}
