//
//  ShowStopsViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ShowStopsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchResultsUpdating{
    
    var stops : [Stop] = SingletonClass.shared.stops
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stops.count
    }
    @IBOutlet weak var tableObject: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              let stop = self.stops[indexPath.row]
              let result =  StopActionsViewController()
              result.stops = stop
            result.action = "search"
              self.navigationController?.pushViewController(result, animated: true)
              
          }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellViewController
          
        let stopsList = SingletonClass.shared.stops[indexPath.row]
          
        cell.label.text = "Stop Name : \(stopsList.stopName ?? "nil") \n StopID : \(stopsList.stopID ?? -100)\n Address : \(stopsList.address ?? "Error")\n Latitude: \(stopsList.latitude ?? "Error")\n Longitude: \(stopsList.longitude ?? "Error")\n "
          
          return cell;
      }
      
    
     
      func updateSearchResults(for searchController: UISearchController) {
                  
          if let searchText = searchController.searchBar.text, !searchText.isEmpty {
              self.stops = SingletonClass.shared.stops.filter { stop in
                return stop.stopName.lowercased().contains(searchText.lowercased())
              }
          } else {
              self.stops  = SingletonClass.shared.stops
          }
          self.tableObject.reloadData()
      }

        
    
    var search = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableObject.delegate = self
        tableObject.dataSource = self
        let cell = UINib(nibName: "CustomCellViewController", bundle: nil)
        tableObject.register(cell, forCellReuseIdentifier: "cell")
        tableObject.reloadData()
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
        search = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableObject.tableHeaderView = controller.searchBar
            
            return controller
        })()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
      }
      
      override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
      }
     
     @objc func addTapped() {
         
         let CTViewController = StopActionsViewController();
         CTViewController.action = "create"
         self.present(CTViewController, animated: true, completion: nil)
         
     }
     
     @objc func refresh() {
         
          stops = SingletonClass.shared.stops
          tableObject.reloadData()
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
