//
//  StackTableViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class StackTableViewController: UIViewController,
UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var breakfastTable: UITableView!
    
    let testData = ["data1","data2","data1","data2","data1","data2","data1","data2"]
    let breakfastCell = "breakfastCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breakfastTable.dataSource = self
        breakfastTable.delegate = self
        breakfastTable.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return testData.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = breakfastTable.dequeueReusableCell(withIdentifier: breakfastCell, for: indexPath)
          cell.textLabel?.text = testData[indexPath.row]
          return cell
      }
      
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }

    
   
}
