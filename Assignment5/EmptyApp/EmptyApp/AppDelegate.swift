//
//  AppDelegate.swift
//  EmptyApp
//
//  Created by rab on 02/15/20.
//  Copyright © 2020 rab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var alertView: UIAlertController?
    var window: UIWindow?
    var trainNameTF: UITextField?
    var lineIDTF: UITextField?
    var arrivalTimeTF: UITextField?
    var departureTimeTF: UITextField?
    var scheduleIDTF: UITextField?
    
    
    enum TFType{
        case trainName
        case arrivalTime
        case departureTime
        case lineID
        case scheduleID
        
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.lightGray
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
            
            renderView(.ask)
        }

        return true
    }

    func renderView(_ ch: choice, _ lineName: String = "")
       {
           var view: UIView!
           switch ch {
           case .ask:
            let buttons = [("Train options",choice.trainOptionsButton.rawValue),("Schedule Options",choice.scheduleOptionsButton.rawValue)]
               view = getView( y: 120, buttons: buttons)
               
           case .trainOptionsButton:
               let buttons = [("Add Train",choice.addTrain.rawValue),
                              ("Update Train ",choice.updateTrain.rawValue),
                              ("View all trains",choice.displayAllTrains.rawValue),
                              ("Delete Train",choice.deleteTrain.rawValue),
                              ("Main Menu",choice.ask.rawValue)]
               view = getView( y: 60, buttons: buttons)
               
           case .scheduleOptionsButton:
            let buttons = [("Add Schedule",choice.addSchedule.rawValue),
                           ("Update Schedule",choice.updateSchedule.rawValue),
                           ("View All Schedules",choice.showAllSchedules.rawValue),
                              ("Delete Schedule",choice.deleteSchedule.rawValue),
                              ("Main Menu",choice.ask.rawValue),
                              ("Schedule by train",choice.showSchedulesOfTrain.rawValue)
            ]
               view = getView( y: 60, buttons: buttons)
               
           case .addTrain:
            let textViews = [("Line Name",TFType.trainName)];
                view = addTrain(y: 60, textViews: textViews);
               
           case .updateTrain:
            let textViews = [("Line Name",TFType.trainName)];
               view = addTrain(y: 60, textViews: textViews, isUpdate: true)
               
           case .displayAllTrains:
               view = displayAllTrains()
               
           case .deleteTrain:
               let textViews = [("Train ID",TFType.lineID)]
               view = deleteTrain(y: 60, textViews: textViews)
            
           case .addSchedule:
               let textViews =     [
                ("Train",TFType.lineID),
                ("Arrival Time",TFType.arrivalTime),
                ("Departure Time",TFType.departureTime)
                                   ]
               view = addSchedule(y: 60, textViews: textViews)
            
           case .updateSchedule:
               let textViews =     [("Arrival Time",TFType.arrivalTime),
                                    ("Departure Time",TFType.departureTime),
                                    ("Train",TFType.lineID)
                                                 ]
               view = addSchedule(y: 60, textViews: textViews, isUpdate: true)
               
           case .showAllSchedules:
               view = showAllSchedules()
               
           case .deleteSchedule:
               let textViews = [("Schedule ID",TFType.scheduleID)]
               view = deleteSchedule(y: 60, textViews: textViews)
            
           case .showSchedulesOfTrain:
            let textViews = [("Line Name",TFType.trainName)];
                view = showSchedulesOfTrain(y: 60, textViews: textViews);
            
           case .showSchedulesView:
                view = showSchedulesForTrain(lineName: lineName)
               
           default:
               print("")
           }
           
           for subview in window!.subviews
           {
               subview.removeFromSuperview()
           }
           
           if view != nil
           {
               window!.addSubview(view)
           
           }
       }
    
    func getView() -> UIView
    {
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        myView.backgroundColor = .white
        myView.tag = 100
        return myView
    }
    
    func getView( y:Int, buttons: [(title: String, tag: Int)]) -> UIView
    {
        var yAxis = y
        let view = getView()
        for b in buttons
        {
            let button = createButton(yAxis: yAxis, title: b.title, tag: b.tag)
            yAxis = yAxis + 60
            view.addSubview(button)
        }
        return view
    }
    
    
    
    func createButton(yAxis:Int, title: String, tag:Int) -> UIButton
       {
           let screenSize: CGRect = UIScreen.main.bounds
           
           let button = UIButton(frame: CGRect(x: 20, y: yAxis, width: Int(screenSize.width-40), height: 40))
           button.setTitle(title, for: .normal)
           button.backgroundColor = UIColor.cyan
            //#8e44ad
           button.layer.borderWidth = 1
           button.setTitleColor(UIColor.black, for: .normal)
           button.tag = tag
           button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
           return button
       }
       
       func createTextField(yAxis:Int, placeholder: String) -> UITextField
       {
           let screenSize: CGRect = UIScreen.main.bounds
           
           let myTextField: UITextField = UITextField(frame: CGRect(x: 20, y: yAxis, width:  Int(screenSize.width-40), height: 30));
           myTextField.placeholder = placeholder
           myTextField.borderStyle = UITextField.BorderStyle.line
           myTextField.backgroundColor = UIColor.white
           myTextField.textColor = UIColor.black
        
           return myTextField
       }
    
    @objc func buttonTapped(sender: UIButton)
    {
        let ch = choice(rawValue: (sender as UIButton).tag)!
        
        switch ch {
        case .addTrainButton:
            validateTrainDetails(false)
            return
        case .updateTrainButton:
            validateTrainDetails(true)
        case .deleteTrainButton:
            validateDeleteTrain()
            return
        case .addScheduleButton:
            validateSchedule(false)
            return
        case .updateScheduleButton:
            validateSchedule(true)
            return
        case .deleteScheduleButton:
            validateDeleteSchedule()
            return
        case .showSchedulesOfTrainButton:
            validateScheduleFortrain()
            return
        default:
            print("")
            
        }
        renderView(ch)
    }
    
    func displayAllTrains() -> UIView
    {
        let view = getView()
        
        
        var str = ""
        for train in SingletonCLass.shared.trainsObj
        {
            str = str + "\n Train Name: \(train.trainLineName!)\n Line ID:\(train.lineID!)\n"
            print(str)
        }
        
//        let label = createLabel(yAxis: 50, text: str)
//        view.addSubview(label)
//
        let tv = createTextView(yAxis: 50, text: str)
        view.addSubview(tv)
        let button = createButton(yAxis: 500, title: "Close", tag:choice.ask.rawValue )
        view.addSubview(button)
        
        return view
    }
    
    func showSchedulesForTrain(lineName: String) -> UIView
        {
            let view = getView()
           
            
            var str = ""
           for schedule in SingletonCLass.shared.showSchedulesForTrain(lineName) ?? []
            {
                str = str + "\n Schedule ID : \(schedule.scheduleID!)\n Line ID:\(schedule.lineID!)\n Arrival Time:\(schedule.arrivalTime!)\n Departure Time: \(schedule.departureTime!)"
                print(str)
            }
            
    //        let label = createLabel(yAxis: 50, text: str)
    //        view.addSubview(label)
    //
            let tv = createTextView(yAxis: 50, text: str)
            view.addSubview(tv)
            let button = createButton(yAxis: 500, title: "Close", tag:choice.ask.rawValue )
            view.addSubview(button)
            
            return view
        }
    
    func deleteTrain(y:Int, textViews: [(lineID: String, tag: TFType)]) -> UIView
    {
        var yAxis = y
        let view = getView()
        
        for t in textViews
        {
            let textView = createTextField(yAxis: yAxis, placeholder: t.lineID)
            yAxis = yAxis + 50
            
            switch t.tag {
            case .lineID:
                self.lineIDTF = textView
                
            default:
                print("")
            }
            view.addSubview(textView)
        }
        
        let buttons = [("Delete", choice.deleteTrainButton.rawValue),
                       ("Close",choice.ask.rawValue)]
        for b in buttons
        {
            let button = createButton(yAxis: yAxis, title: b.0, tag: b.1)
            yAxis = yAxis + 60
            view.addSubview(button)
        }
        
        return view
        
    }
    
    func showSchedulesOfTrain(y:Int, textViews: [(trainName: String, tag: TFType)]) -> UIView
    {
        var yAxis = y
        let view = getView()
        
        for t in textViews
        {
            let textView = createTextField(yAxis: yAxis, placeholder: t.trainName)
            yAxis = yAxis + 50
            
            switch t.tag {
            case .trainName:
                self.trainNameTF = textView
                
            default:
                print("")
            }
            view.addSubview(textView)
        }
        
        let buttons = [("Show", choice.showSchedulesOfTrainButton.rawValue),
                       ("Close",choice.ask.rawValue)]
        for b in buttons
        {
            let button = createButton(yAxis: yAxis, title: b.0, tag: b.1)
            yAxis = yAxis + 60
            view.addSubview(button)
        }
        
        return view
        
    }

    func addTrain( y:Int, textViews: [(title: String, tag:
        TFType)], isUpdate: Bool = false) -> UIView
    {
        var yAxis = y
        let view = getView()
        for t in textViews
        {
            let textView = createTextField(yAxis: yAxis, placeholder: t.title)
            yAxis = yAxis + 50
            
            switch t.tag {
            case .trainName:
                self.trainNameTF = textView
            default:
                print("")
            }
            view.addSubview(textView)
        }
        
        let buttons = [(isUpdate ? "Update":"Create",isUpdate ? choice.updateTrainButton.rawValue : choice.addTrainButton.rawValue),
                       ("Close",choice.ask.rawValue)]
        for b in buttons
        {
            let button = createButton(yAxis: yAxis, title: b.0, tag: b.1)
            yAxis = yAxis + 60
            view.addSubview(button)
        }
        
        return view
    }
    
    func addSchedule( y:Int, textViews: [(title: String, tag: TFType)], isUpdate: Bool = false) -> UIView
    {
        var yAxis = y
        let view = getView()
        for t in textViews
        {
            let textView = createTextField(yAxis: yAxis, placeholder: t.title)
            yAxis = yAxis + 50
            
            switch t.tag {
            case .lineID:
                self.lineIDTF = textView
            case .arrivalTime:
                self.arrivalTimeTF = textView
            case .departureTime:
                self.departureTimeTF = textView
            default:
                print("")
            }
            view.addSubview(textView)
        }
        
        let buttons = [(isUpdate ? "Update":"Add",isUpdate ? choice.updateScheduleButton.rawValue : choice.addScheduleButton.rawValue),
                       ("Close",choice.ask.rawValue)]
        for b in buttons
        {
            let button = createButton(yAxis: yAxis, title: b.0, tag: b.1)
            yAxis = yAxis + 60
            view.addSubview(button)
        }
        
        return view
    }
    
    func showAllSchedules() -> UIView
    {
        let view = getView()
        
        var str = ""
        for schedule in SingletonCLass.shared.scheduleObj
        {
            str = str + "\n Train ID: \(schedule.lineID!)\n Schedule ID:\(schedule.scheduleID!)\n Arrival Time: \(schedule.arrivalTime!)\n Departure Time:\(schedule.departureTime!) \n"
        }
        
//        let label = createLabel(yAxis: 50, text: str)
//        view.addSubview(label)
        
        let tv = createTextView(yAxis: 50, text: str)
        view.addSubview(tv)
        
        let button = createButton(yAxis: 500, title: "Close", tag:choice.ask.rawValue )
        
        view.addSubview(button)
        
        return view
    }
    
    func deleteSchedule(y:Int, textViews: [(title: String, tag: TFType)]) -> UIView
    {
        var yAxis = y
        let view = getView()
        
        for t in textViews
        {
            let textView = createTextField(yAxis: yAxis, placeholder: t.title)
            yAxis = yAxis + 50
            
            switch t.tag {
            case .scheduleID:
                self.scheduleIDTF = textView
                
            default:
                print("")
            }
            view.addSubview(textView)
        }
        
        let buttons = [("Delete", choice.deleteScheduleButton.rawValue),
                       ("Close",choice.ask.rawValue)]
        for b in buttons
        {
            let button = createButton(yAxis: yAxis, title: b.0, tag: b.1)
            yAxis = yAxis + 60
            view.addSubview(button)
        }
        
        return view
        
    }
    
    
    func createLabel(yAxis:Int, text: String) -> UILabel
    {
        let screenSize: CGRect = UIScreen.main.bounds
        
        let label = UILabel(frame: CGRect(x: 20, y: yAxis, width: Int(screenSize.width-40), height: 40))
        label.textAlignment = .center
        
        //To set the color
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        
        //To set the font Dynamic
        label.font = UIFont(name: "Helvetica-Regular", size: 20.0)
        
        //To set the system font
        label.font = UIFont.systemFont(ofSize: 20.0)
        
        //To display multiple lines
      //   label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping //Wrap the word of label
        label.lineBreakMode = .byCharWrapping //Wrap the charactor of label
        
        label.sizeToFit()
        label.text = text
        return label
    }
    
    func createTextView(yAxis : Int, text: String) -> UITextView {
        let textView = UITextView(frame: CGRect(x: 20, y: 30, width: 250.0, height: 400.0))
        textView.text = text
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
   
        return textView
   }
//
    func validateTrainDetails(_ isUpdate : Bool)
    {
        
        var train : Train!
        
        guard let trainName = trainNameTF,let na = trainName.text, !na.isEmptyOrWhitespace() else {
            showAlert(title: "Enter correct name")
            return
        }
        
        
        if (isUpdate){
            
            guard let tr = SingletonCLass.shared.getTrain(na) else {
                showAlert(title: "Train not found")
                return
            }
            train = tr
        }
        
//
//        if let _ = SingletonCLass.shared.getTrain(Int(na)!)  {
//            showAlert(title: "Line exists already")
//            return
//        }
        
        if (!isUpdate){
            train =  SingletonCLass.shared.addTrain()
        }
        train.trainLineName = na
        
        showAlert(title: "Line succesfully created")
    }
    
    
    func validateDeleteTrain()
    {
          guard let trainName = trainNameTF,let na = trainName.text, !na.isEmptyOrWhitespace() else {
                  showAlert(title: "Enter correct train name")
                  return
              }
        if !SingletonCLass.shared.deleteTrain(na)  {
            showAlert(title: "Train name not found, please retry")
            return
        }
        showAlert(title: "Train deleted succesfully")
    }
    
    func validateScheduleFortrain()
     {
        
        guard let line = lineIDTF,let lineName = line.text, !lineName.isEmptyOrWhitespace() else {
                       showAlert(title: "Enter correct line name")
                       return
                   }
        
        renderView(.showSchedulesView, lineName)
        
     }
     
    
    func showAlert(title: String)
       {
      
       let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        //UIApplication.shared.keyWindow?.makeKeyAndVisible()
        //window?.makeKeyAndVisible()
        //window?.rootViewController?.present(alert, animated: true, completion: nil)
        //UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
     //   test.present(alert, animated: true, completion: nil)
      print(title)
        }
    
    func validateSchedule(_ isUpdate : Bool)
    {
        var schedule : Schedules!
        if isUpdate
        {
            guard let scheduleID = scheduleIDTF,let sid = scheduleID.text, !sid.isEmptyOrWhitespace() else {
                showAlert(title: "Enter correct id")
                return
            }
            
            guard let sch = SingletonCLass.shared.getSchedule(Int(sid)!) else {
                showAlert(title: "Schedule not found, please try again")
                return
            }
            schedule = sch
        }
        guard let lineID = lineIDTF, let lid = lineID.text ,!lid.isEmptyOrWhitespace()  else {
            
            showAlert(title: "Enter train id")
            return
        }
        guard let train = SingletonCLass.shared.getTrain(lid) else {
            showAlert(title: "Train not found")
            return
        }

        guard let arr = arrivalTimeTF, let at = arr.text ,at.isValidTime() else {
            showAlert(title: "Enter correct arrival time format in HH:mm")
            return
        }
        guard let dep = departureTimeTF, let dt = dep.text ,dt.isValidTime() else {
            showAlert(title: "Enter correct departure time format in HH:mm")
            return
        }
        
        if (!isUpdate){
            schedule =  SingletonCLass.shared.addSchedule(train: train)
        }
        schedule.lineID = train.lineID
        schedule.arrivalTime = at
        schedule.departureTime = dt
        
        showAlert(title: "Schedule succesfully added for train : \(schedule.scheduleID!) ")
        
    }
    
    func validateDeleteSchedule()
    {
          guard let scheduleID = scheduleIDTF,let sid = scheduleID.text, !sid.isEmptyOrWhitespace() else {
                  showAlert(title: "Enter correct schedule ID")
                  return
              }
        if !SingletonCLass.shared.deleteTrain(sid)  {
            showAlert(title: "Schedule ID not found, please retry")
            return
        }
        showAlert(title: "Schedule deleted succesfully")
    }
    
 
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

