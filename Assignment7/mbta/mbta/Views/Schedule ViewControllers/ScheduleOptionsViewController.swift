//
//  ScheduleOptionsViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/22/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ScheduleOptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
              if let destinationViewController = segue.destination as? SearchScheduleViewController {
                  destinationViewController.action = segue.identifier!
              }
        
      }
}

