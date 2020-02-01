import Cocoa


//  main.swift
//  Assignment1
//
//  Created by Krishna Vikas on 1/30/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

//Exercise: Swift Variables


//1.    Declare 2 variables/constants with some random values and any name of your choice

let radius = 55;
let pi = 3.14;


//2.    Considering these 2 variables, one as a value of PI and other as a radius of circle, find the area of circle

let area = pi * Double(pow(Double(radius),Double(2)));

//3.    Print the area of circle

print("Area of circle is : \(area) ");

//4.    Declare a string variable explicitly with value “Northeastern”.
var explicitString : String = "Northeastern";

//5.    Declare a string variable implicitly with value “Smartphone”.
var implicitString = "Smartphone"

//6.    Concatenate both the strings and print it
var concactenatedString = explicitString + implicitString;

print(concactenatedString)

//7.    Declare a variable explicitly with a value of 12
var explicitInt : Int = 12;

//8.    Declare a variable implicitly with a value of 2
var implicitInt = 2;

//9.    Calculate the value of 12 to the power of 2 and print it
var power = pow(Double(explicitInt),Double(implicitInt));

print(power);

//10.    Declare an emoji (any emoji of your choice: command + control + space to access emojis) variable with the value “iPhone”.

var iPhone = "👻";

//11.    Declare another emoji variable with the value “iPhone\u{301}”
var emoji = "iPhone\u{301}";

//12.    Declare a variable that stores the value you get after applying the == operator on the emojis declared in 10) and 11).
var result = iPhone == emoji;

print(result)




//Exercise: Swift Arrays

//1.    Declare an empty Array of type String and initialize it with 3 values
var myArray : [String] = ["Apple", "MackBook", "Pro"];

//2.    Append the array with [“Boston” “New York”] to the array declared above
myArray.append("Boston")
myArray.append("NewYork")

//3.    Insert the string “San Francisco” at the 3rd index without overwriting the already existing value (Rearrange the indices)

var p = myArray[2];
myArray[2] = "San Fransico";
myArray.append(p)

//4.    Use removeAt to remove any value from the array.

myArray.remove(at: 2);

//5.    Print the final count of the array

print(myArray.count);




//Exercise: Swift Loops
//1-    Declare an empty Array of Integers.
var intArray : [Int] = [];


//2-    Initialize the array with even numbers between 1 and 100.
var sumOfDigits = 0;
for number in 1...100{
    if(number % 2 == 0){
        intArray.append(number);
        sumOfDigits += number;
    }
}

//3-    Using the for-in loop print out all the numbers along with the sum of their digits.
for nums in intArray{
   print(nums);
}
print("Sum of Digits: \(sumOfDigits)");

//4-    Using a repeat while loop add 3 to each number.
var ind = 0;

repeat{
    intArray[ind] += 3;
    ind += 1;
}
    while ind<intArray.count;

//5-    Declare a string and cast it to an Array of characters. Iterate over this array to print out the characters along with their indices.

let myString = "hello";

let myCharArray : [Character] = Array(myString);
var charIndex = 0;

for char in myCharArray{
    print("Char is : \(char) and it's index is : \(charIndex)")
    charIndex += 1;
}





//Exercise: Swift Functions

//1.    Create a function named “add” that takes two parameters of type double and returns the sum of the two numbers

func add(inp1: Double, inp2 : Double) -> Double{
    return inp1+inp2
}

//2.    Create a function named “subtract” that takes two parameters of type int and returns the difference of the two numbers
func subtract(inp1: Int, inp2 : Int) -> Int{
    return inp2-inp1
}

//3.    Create a function name “multiply” that takes two parameters of type Float and returns the product of the two numbers
func multiply(inp1: Float, inp2 : Float) -> Float{
    return inp2*inp1
}


//4.    Make sure that the three functions created above work by testing them
print(add(inp1: 2,inp2: 4))
print(subtract(inp1: 2,inp2: 4))
print(multiply(inp1: 2,inp2: 4))

//5.    Create a function named “test” that takes a parameter of type Int and returns sum, difference and multiplication of its digits(The function must return multiple parameters)
func test(inp1: Int, inp2: Int) ->(Double, Int, Float){
    return (add(inp1: Double(inp1),inp2: Double(inp2)),subtract(inp1: inp1,inp2: inp2),multiply(inp1: Float(inp1), inp2: Float(inp2)))
}

print(test(inp1: 10,inp2: 20))

//Exercise: Conditions

//1.    You are given a fridge that knows when your food is going bad. You know that milk spoils after 21 days and eggs after 10 days. Given milkAge and eggsAge, write a function to determine if you should throw the milk, the eggs or both away or not. If you can keep both, print “you can still use your milk and eggs”. If you should throw away the milk, print “you should throw away the milk”. Similarly for the eggs.

func smartFridge(milkAge: Int, eggsAge: Int) -> String{
    let milkExpiry :Int = 21
    let eggsExpiry :Int = 10
    if milkAge <= milkExpiry && eggsAge <= eggsExpiry{
        return "You can use your eggs and milk"
    }else{
        if milkAge > milkExpiry && eggsAge > eggsExpiry{
            return "You  need to throw away both"
        }else if milkAge <= milkExpiry && eggsAge > eggsExpiry{
            return "You  need to throw away eggs"
        }else{
            return "You  need to throw away milk"
        }
    }
}

print(smartFridge(milkAge: 111, eggsAge:  10))

//2.    Write a function that takes in three variables “first, “second” and “third” that checks if at least two variables have the same value. If true, print “two values are at least identical” else print “the values are different”.

func similarElements(first: Int, second: Int, third: Int) -> String{
    let tr = "two values are at least identical"
    let fal = "the values are different"
    if first == second || first == third{
        return tr
    } else if second == third{
        return tr
    } else {
        return fal
    }
}

print(similarElements(first: 210, second: 20, third: 20))




//Exercise: Swift Dictionary and Tuples

//1-    Create an array of dictionaries in which each dictionary in the array contains the keys “firstName” and “lastName”. Create an array with a name of your choosing that contains only the values for “firstName” in each dictionary.


var d1:[String:String] = ["Steve": "Jobs","Tim":"Cook","John":"Doe","Pakalo":"Papito","Modi":"Ji"]
var firstNameArr = [String]();
for key in (d1.keys) {
    firstNameArr.append(key)
}
print(firstNameArr)

//2-    Using the array of dictionaries created previously, this time create an array that contains the values for “firstName” and “lastName” in each dictionary separated by a delimiter of your choice.
var completeNameArr = [String]();
for (key, value) in d1 {
    let str : String = "(\(key),\(value))";
    completeNameArr.append(str);
   
}

print(completeNameArr)

//3-    Create a datatype called MyTuple using the typealias feature of swift. It should be a tuple containing 2 Strings (String , String).
typealias myTuple = (String, String)

//4-    Declare and initialize a tuple with any values of your choice.
var test: myTuple = (firstName: "Krishna", lastName: "Vikas")

//5-    Print both values of the tuple individually in the console.
print(test.0)
print(test.1)




//Exercise: Swift Optionals

//1-    let optvar : Int = nil Correct the error in this line of code.
let optvar : Int? = nil

//2-    let unwrapme : String? = nil
//let unwrappedValue : String = unwrapme!
//The code snippet shown above will crash. Rewrite it with Optional Binding.
let unwrapme : String? = nil
if let unwrappedValue = unwrapme {
   print("Your string has - \(unwrappedValue)")
} else {
   print("Your string does not have a value")
}

//3 - Declare any optional variable of any type with the Optional keyword.
var serialNumber: Optional<String> = Optional("B342432b")
print(serialNumber!)

//4 -     var value1 : Int?
//var defaultValue : Int = 7
//Print the value of value1 to the console. If it contains nil use assign defaultValue to it.

var value1 : Int? = nil
var defaultValue = 7
if value1 != nil {
   print( value1! )
} else {
   value1=defaultValue
}


//ii) Use the nil coalescing operatior.
var value2 : Int? = nil
var val3 = value2 ?? defaultValue

print(val3);


//5-     If let name = txtname.text {
//If let address = txtaddress.text {
//sendToServer(name , address)
//}
//else {
//print (“No address provided”)
//}
//}
//else {
//print (“No name provided”)
//}
//
//Rewrite this piece of code using 2 guard statements.

var name = "nameField.txt"
var address = "addressField.text"
func submit(name: String, address: String) {
    guard  name == "nameField.text" else {
        print("No name provided")
        return
    }

    guard address == "addressField.text" else {
        print("No address provided")
        return
    }

   
    sendToServer(name:name, address: address)
}

func sendToServer(name: String, address: String) {
  print(name,address)
}

submit(name:"nameField.text",address:"addressField.text")
