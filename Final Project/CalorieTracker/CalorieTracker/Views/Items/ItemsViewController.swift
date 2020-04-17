//
//  RecipeViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/16/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var items = [Items]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FireStoreServices.shared.getItems(from: .items, returning: Items.self, completion: {
            (items) in
            self.items = items
            self.tableView.reloadData()
        })
        
    }
    
    @IBAction func onAddTapped(_ sender: Any) {
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? ItemCellViewController
        cell?.header?.text = item.itemName
        let cellText = "Total Calories: \(String(item.totalCalories))"
        cell?.detail?.text = cellText
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateItemsViewController") as? CreateItemsViewController
        vc?.action = "search"
        vc?.item = item
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        let update = updateAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete,update])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let item = items[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Delete"){ (action,view,completion) in
            FireStoreServices.shared.delete(item, in: .items)
            completion(true)
        }
        action.image = UIImage(named: "delete")
        action.backgroundColor = .red
        return action
    }
    
    func updateAction(at indexPath: IndexPath) -> UIContextualAction{
        let item = items[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Update"){ (action,view,completion) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateItemsViewController") as? CreateItemsViewController
            vc?.action = "update"
            vc?.item = item
            self.navigationController?.pushViewController(vc!, animated: true)
            completion(true)
        }
        action.image = UIImage(named: "edit")
        action.backgroundColor = .purple
        return action
    }
    
}

