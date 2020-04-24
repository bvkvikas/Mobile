//
//  ItemsPickerViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/18/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
import FirebaseAuth


class ItemsPickerViewController: UITableViewController {
    var items = [Items]()
    
    var mealType : String?
    var selectedItems = [String]()
    var dateToAdd : String?
    var totalCalories: Int = 0
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet var itemsPickerTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsPickerTable.isEditing = true
        self.itemsPickerTable.allowsMultipleSelectionDuringEditing = true
        FireStoreServices.shared.getItems(from: .items, returning: Items.self, completion: {
            (items) in
            self.items = items
            self.tableView.reloadData()
        })
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemPickerCell",for: indexPath) as? ItemPickViewController
        cell?.header.text = item.itemName
        let cellText = "Total Calories: \(String(item.totalCalories))"
        cell?.detail.text = cellText
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDeselectCell(tableView: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectDeselectCell(tableView: tableView, indexPath: indexPath)
    }
     
    func selectDeselectCell(tableView : UITableView, indexPath: IndexPath){
        self.selectedItems.removeAll()
        if let arr = tableView.indexPathsForSelectedRows{
            for index in arr{
                print(items[index.row])
                selectedItems.append(items[index.row].itemID!)
                totalCalories += items[index.row].totalCalories
            }
            print("selected arrays :::: \(selectedItems.count)")
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        print(selectedItems)

        FireStoreServices.shared.updateMeal(dateToUpdate: dateToAdd!, typeOfMeal: mealType!, totalCalories: Double(totalCalories), items: selectedItems, in: .users)
        
        
        
    }
    
}
