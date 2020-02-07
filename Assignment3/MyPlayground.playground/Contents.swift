import Cocoa

var str = "Hello, playground"


//Exercise: Swift Classes

//1.    Create a class named Flight with 3 properties: airlineName, number of seats, number of customers with confirmed seats
//2.    Create a custom initializer in the class to set its properties
//3.    Create a method that returns the number of seats available after booking
//4.    Create another class named Boeing as subclass of Flight and initialize it using the custom initializer in the flight class
//5.    Calculate number of seats available in the Boeing flight and print its details

class Flight{
    var airlineName : String;
    var noOfSeats : Int;
    var numberOfCustomersWithConfirmedSeats : Int;
    init(airlineName : String, noOfSeats : Int,numberOfCustomersWithConfirmedSeats : Int){
        self.airlineName = airlineName;
        self.noOfSeats = noOfSeats
        self.numberOfCustomersWithConfirmedSeats = numberOfCustomersWithConfirmedSeats;
    }
    
    func noOfSeatsAvailable(noOfSeats :Int, noOfBookedSeats : Int) -> Int{
        return noOfSeats - noOfBookedSeats;
    }
}

class Boeing : Flight{
    override func noOfSeatsAvailable(noOfSeats: Int, noOfBookedSeats: Int) -> Int {
        let res = noOfSeats - noOfBookedSeats;
        print(noOfSeats - noOfBookedSeats);
        return res;
    }
}

var fl = Boeing(airlineName: "Boeing",noOfSeats: 100,numberOfCustomersWithConfirmedSeats: 20);
fl.noOfSeatsAvailable(noOfSeats: fl.noOfSeats, noOfBookedSeats: fl.numberOfCustomersWithConfirmedSeats);

class Airbus : Flight{
    override func noOfSeatsAvailable(noOfSeats: Int, noOfBookedSeats: Int) -> Int {
        return noOfSeats - noOfBookedSeats - 2;
    }
}

var fl2 = Airbus(airlineName: "Boeing",noOfSeats: 500,numberOfCustomersWithConfirmedSeats: 200);
fl2.noOfSeatsAvailable(noOfSeats: fl.noOfSeats, noOfBookedSeats: fl.numberOfCustomersWithConfirmedSeats);

class Airbus2 : Airbus{
    override func noOfSeatsAvailable(noOfSeats: Int, noOfBookedSeats: Int) -> Int {
        return noOfSeats - noOfBookedSeats - 10;
    }
}

var fl3 = Airbus2(airlineName: "Boeing",noOfSeats: 500,numberOfCustomersWithConfirmedSeats: 200);
fl3.noOfSeatsAvailable(noOfSeats: fl.noOfSeats, noOfBookedSeats: fl.numberOfCustomersWithConfirmedSeats);


//Exercise: Enum

//1.    Define an enum Month which consists of all the months in a year.

enum months{
    case January
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case Decmeber
}


//2.    Next, define a function NumberOfDays() which accepts the month and prints out “Number of Days” for that month. {Use switch case statement}

func noOfDays(month : months ) {
    switch month{
    case .January, .March, .May, .July, .August, .October, .Decmeber:
        print(31)
    case .April, .June, .September, .November:
        print(30)
    case .February:
        print("28 days in a common year and 29 days in leap years")
    }
}

noOfDays(month: months.January)
noOfDays(month: months.February)


//Exercise: Structures

//1.    Define a structure, Cube, having 3 parameters length, breadth and height to encapsulate the data
//2.    Create an area function inside struct that calculates the cube’s area
//3.    Instantiate cube1 with values of length, breadth and height.
//4.    Assign cube1 to cube2
//5.    Set length of cube2 to some other value
//6.    Calculate and print area of both cubes

struct Cube{
    var length, breadth, height : Int
    
}

var myCube = Cube(length: 10, breadth: 20, height: 30)

func area(length : Int, breadth: Int, height: Int) -> Int{
    return length * breadth * height;
}

var myCube2 = myCube;
myCube2.length = 100;

print(area(length: myCube.length, breadth: myCube.breadth, height: myCube.height));
print(area(length: myCube2.length, breadth: myCube2.breadth, height: myCube2.height));


//Exercise: Protocols

//1.    Define a protocol MastersDegree, define following functions inside this protocol:
//
//•    printGPA() - This should print the GPA
//
//•    isSmartphonesCourseCompleted() - This should print if the student has completed smartphones course or not
//
//2.    Now define a class Student which adopt MastersDegree protocol and provide the actual implementation

protocol MastersDegree{
    func printGPA(GPA : Double) -> ()
    func isSmartphonesCourseCompleted(hasCompleted : Bool) -> ()
}

class Student :MastersDegree{
    var hasCompleted : Bool
    var GPA : Double
    init(hasCompleted : Bool, GPA : Double){
        self.GPA=GPA;
        self.hasCompleted=hasCompleted;
    }
    func isSmartphonesCourseCompleted(hasCompleted: Bool) {
        if hasCompleted {
            print("Completed")
        }else{
            print("Not completed")
        }
    }
    func printGPA(GPA: Double) {
        print("Your GPA is \(GPA)")
    }
}

var myStudent = Student(hasCompleted: true, GPA: 4.0);
myStudent.isSmartphonesCourseCompleted(hasCompleted: myStudent.hasCompleted)
myStudent.printGPA(GPA: myStudent.GPA)

//Exercise: Extensions

//1.    Extending the datatype String add methods: stringLength() and concatenateString (Use another string as “Smartphones”)



extension String {
    func stringLength() -> Int {
        return self.count
    }
    func concatenateString(myStr1 : String) -> String {
        return "Smartphones" + myStr1;
    }
}

//2.    Next, create a constant named stringExtension of String initializing it to a string of your choice. Use the extended functionality in point 1 and print out the values in the console.

var stringExtension : String = "HAHAHA"

print(stringExtension.stringLength())
print(stringExtension.concatenateString(myStr1: "Subject"))

//3.    Complete the code below:

class division {

var number: Int = 0

}

extension division {

//Define a method to divide 2 numbers and print the result
    func dividedBy(num1 : Double, num2 : Double){
        print(num1/num2)
    }
}

let div = division()
div.dividedBy(num1: 4, num2: 2)

