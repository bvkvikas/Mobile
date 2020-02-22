//
//  main.swift
//  Assignment4
//
//  Created by Krishna Vikas on 2/13/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation

enum choice : Int {
    case addCustomer
    case deleteCustomer
    case displayCustomers
    case addMusic
    case updateMusicDetails
    case viewMusicDetails
    case searchById
    case createOrder
    case deleteOrder
    case viewOrders
    case exit
    case ask
}

enum TypeEnum
{
    case date
    case other
}

print("Hello, Please enter the number key of the action");
var customersObj : [Customer] = [];
var musicObj : [Music] = [];
var orderObj : [Order] = [];

func selectChoice(choice:choice,_ emailID: String = "", customer: Customer? = nil, music: Music? = nil, musicID: Int = 0, orderID : Int = 55 )
{
    switch choice {
    case .addCustomer:
        addCustomer();
    
    case .deleteCustomer:
    deleteCustomer(emailID);
        
    case .displayCustomers:
        displayCustomers();
    
    case .addMusic, .updateMusicDetails:
        addMusic(music);
        
    case .viewMusicDetails:
        viewMusicDetails();
        
    case .searchById:
        print("\nMusic ID: \(String(describing: music?.ID!)) \nName:\(music?.musicName! ?? "default") \nArtist:\(music?.musicArtist! ?? "default") \nPrie:\(music!.price ?? 0) \nAvailable Quantity:\(music?.availableQuantity! ?? 0)")
        selectChoice(choice: .ask)
    case .createOrder:
        createOrder();
        
    case .deleteOrder:
        deleteOrder(orderID);
        
    case .viewOrders:
        viewOrders();
        
     case .exit:
            return
        default:
            print("""
                \n Select an option.
                 1 Add customer
                 2 Delete Customer
                 3 Display all customer details
                 4 Add music
                 5 Update music
                 6 View all music details
                 7 Search music by ID
                 8 Create Order
                 9 Delete Order
                 10 View Orders
                 11 Exit
    """)
            let choice = getInput(.other, "choice");
            if choice == "1" {
                selectChoice(choice: .addCustomer)
            }
            else if choice == "2"{
                print("Please enter the customer email ID")
                let email = getInput(.other, "email")
                selectChoice(choice: .deleteCustomer, email)
            }
            else if choice == "3"{
                selectChoice(choice: .displayCustomers)
            }
            else if choice == "4"{
                selectChoice(choice: .addMusic)
            }
            else if choice == "5" || choice == "7" {
                print("Enter music ID");
                let inp = getInput(.other, "Music ID");
                if let music = getMusic(inp)
                {
                    if choice == "5"{
                        selectChoice(choice: .updateMusicDetails, music:music)
                    }else{
                        selectChoice(choice: .searchById, music: music)
                    }
                }
                else{
                    print("Music not found")
                    selectChoice(choice: .ask)
                }
            }
            else if choice == "6"{
                selectChoice(choice: .viewMusicDetails)
            }
            else if choice == "8"{
                selectChoice(choice: .createOrder)
        }
            else if choice == "9"{
                print("Please enter the order ID")
                let ord = getInput(.other, "orderID");
                selectChoice(choice: .deleteOrder,orderID : Int(ord)!);
        }
            else if choice == "10"{
                selectChoice(choice: .viewOrders)
        }
        }
}

func addCustomer() {
    print("Please enter customer name");
    let customerName = getInput(.other, "Customer Name");
    
    print("Please enter customer email");
    let customerEmail = getInput(.other, "Customer Email");
    
    let customer = Customer(customerName: customerName, customerEmail:customerEmail)
    customersObj.append(customer);
    print("Created customer with ID: \(customer.customerID) Wohoo!");
    selectChoice(choice:.ask);
}

func deleteCustomer(_ emailID: String)
{
    if let _ = getCustomer(emailID) {
        customersObj.removeAll(where:{ $0.customerEmail == emailID })
        print("Customer removed")
    }
    else
    {
        print("Invalid email ID, try again")
        
    }
    selectChoice(choice: .ask)
    
}
func deleteOrder(_ orderID: Int){
          if let _ = getOrder(orderID) {
            orderObj.removeAll(where:{ $0.orderID == orderID })
            print("Order deleted!!")
        }
        else
        {
            print("Invalid order ID, try again")
            
        }
        selectChoice(choice: .ask)
    
}


func displayCustomers()
{
    if customersObj.count == 0
    {
        print("No customers found")
    }
    for customer in customersObj
    {
        print("\nCustomer ID: \(customer.customerID) \nCustomer Name:\(customer.customerName) \nCustomer Email:\(customer.customerEmail) ")
    }
    selectChoice(choice:.ask)
}

func addMusic(_ musicID : Music?){
    var music : Music
    
    if musicID != nil
    {
        music = musicID!
    }
    else
    {
        music = Music()
        musicObj.append(music);
    }
    
        print("enter music name");
        let musicName = getInput(.other, "musicName");
        
        print("enter artist name");
        let musicArtist = getInput(.other, "artist");
        
        print("Enter price")
        let price = getInput(.other, "price");
        
        print("Available quantity")
        let availableQuantity = Int(getInput(.other,"Initial Quantity"));
        
        music.musicName = musicName;
        music.musicArtist = musicArtist;
        music.price = Double(price)!;
        music.availableQuantity = availableQuantity;
        print("Music \(music.ID!) \(musicID == nil ? "Created": "Updated") successfully ")
           
        selectChoice(choice:.ask);
          
    
}

func viewMusicDetails(){
        if musicObj.count == 0
        {
            print("No music details found")
        }
        for music in musicObj
        {
            print("\nMusic ID: \(music.ID!) \nName:\(music.musicName!) \nArtist:\(music.musicArtist!) \nPrie:\(music.price ?? 0) \nAvailable Quantity:\(music.availableQuantity!)")
        }
        selectChoice(choice:.ask)
    
}


func getInput(_ type:TypeEnum, _ field: String) -> String
{
    guard let input = readLine(), !input.isEmptyOrWhitespace() else {
        print("Please enter the correct \(field)")
        return getInput(type, field)
    }
    // Return to main menu
    if input == "0"
    {
        selectChoice(choice: .ask)
    }
    switch type {
    case .date:
        if input.isValidDate()
        {
            return input
        }
        else{
            print("Please enter the correct date(mm-dd-yyyy)")
            return  getInput(type, field)
        }
    case .other:
        return input
    }
    
}
func getCustomer(_ emailID: String) -> Customer? {
    
    guard let customer = customersObj.first(where: { $0.customerEmail == emailID }) else {
        return nil
    }
    return customer
}

func getOrder(_ orderID: Int) -> Order? {
    print(orderID);
    guard let order = orderObj.first(where: { $0.orderID == orderID }) else {
         return nil
     }
    print(order);
     return order
}

func getMusic(_ musicID: String) -> Music? {
    
    guard let music = musicObj.first(where: { $0.ID == musicID }) else {
        return nil
    }
    return music
}

func canQuatityBeUsed(_ music: Music, _ requestedQuantity: Int) -> Bool? {
    
    if music.availableQuantity >= requestedQuantity {
        return true
    }
    else {
        return false
    }
}

func reduceQuantity(_ music: Music, orderedQuantity : Int ){
    let a = music.availableQuantity;
    music.availableQuantity = a! - orderedQuantity;
}

func createOrder() {
    print("Enter customer email")
    let customerID = getInput(.other, "customerID");
    if let customer = getCustomer(customerID){
        print("Enter music ID");
        let musicID = getInput(.other, "music ID");
        if let music = getMusic(musicID){
            print("Enter quantity")
            let quantity: Int = Int(getInput(.other , "Quantity")) ?? 0;
            if canQuatityBeUsed(music, quantity ) ?? false{
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "yyyy-MM-dd"
                let formattedDate = format.string(from: date)
                let price : Double = music.price ;
                let order = Order()
                orderObj.append(order);
                order.music = music;
                order.customer = customer;
                order.orderDate = formattedDate;
                order.orderPrice = (Double(quantity) * price);
                reduceQuantity(music, orderedQuantity: quantity);
               
                print("Order \(order.orderID) placed!!");
                selectChoice(choice: .ask)
            }else{
                print("Requested quantity is greater than available quantity , please try again")
                selectChoice(choice: .createOrder)
            }
        }else{
            print("Invalid music , please try again")
            selectChoice(choice: .createOrder)
        }
    }else{
        print("Invalid customer , please try again")
        selectChoice(choice: .createOrder)
    }
}


func viewOrders(){
    if orderObj.count == 0
    {
        print("No orders found")
    }
    for order in orderObj
    {
        print("Order ID: \(String(describing: order.orderID))");
        print("Order Date: \(String(describing: order.orderDate))");
        print("Customer: \n Customer Name : \(order.customer.customerName) \nCustomer Email: \(order.customer.customerEmail)");
        print("Music:\n Music name: \(String(describing: order.music.musicName)) \nArtist: \(String(describing: order.music.musicArtist))");
        print("Price: \(String(describing: order.orderPrice))");
    }
    selectChoice(choice:.ask)
}

extension String {
    
    func isValidDate() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm-dd-yyyy"
        
        if dateFormatter.date(from: self) != nil {
            return true
        }
        return false
    }
    
    func isEmptyOrWhitespace() -> Bool {
           if(self.isEmpty) {
               return true
           }
           return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
       }
}

selectChoice(choice:.ask)
