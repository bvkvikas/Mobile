//
//  SearchStopViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/11/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class SearchStopViewController: UIViewController {
    
    var action : String = "";
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var header: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch action{
        case "search":
            header.title = "Search Stop"
        case "delete":
            header.title = "Delete Stop"
            actionButton.setTitle("Delete Stop", for: .normal)
        case "update":
            header.title = "Update Stop"
        default:
            header.title = "Stop"
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        guard let sid = searchTF!.text, !sid.isEmptyOrWhitespace() else{
                   showAlert(title: "Enter Stop ID")
                   return
               }
               
               guard let stop : Stop = SingletonClass.shared.getStopByID(sid: Int(sid)!) else{
                   showAlert(title: "No Stop found")
                   return
               }
               
               if action == "delete" {
                   if SingletonClass.shared.deleteStop(sid: Int(sid)!){
                       showAlert(title: "Stop removed from schedule")
                       return
                   }else{
                       showAlert(title: "Error deleting schedule")
                       return
                   }
               }
               
               
               let SVController = StopActionsViewController();
               SVController.stops = stop;
               SVController.sn = stop.stopName
               SVController.lat = stop.latitude
               SVController.long =  stop.longitude
               SVController.add = stop.address
               SVController.action = action
        
               self.navigationController?.pushViewController(SVController, animated: true)
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func showAlert(title: String)
      {
          let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          self.present(alert, animated: true)
      }
}
