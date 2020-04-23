//
//  FirestoreServices.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/16/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FireStoreServices {
    
    private init() {}
    static let shared = FireStoreServices()
    
    func configure() {
        FirebaseApp.configure()
    }
    
    private func reference(to collectionReference: FirebaseCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
    
    func createUser(user : User, in collectionReference: FirebaseCollectionReference) {
        reference(to: collectionReference).document(user.emailID).setData([
            
            "firstName" : user.firstName!,
            "lastName" : user.lastName!,
            "emailID": user.emailID!,
            "age": user.age!,
            "gender": user.gender!,
            "heightFeet": user.heightFeet!,
            "heightInches": user.heightInches!,
            "totalCaloriesToConsume": user.totalCaloriesToConsume!,
            "weight": user.weight!,
            ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        reference(to: collectionReference).document(user.emailID).collection("testRecord")
        
    }
    
    func create<T: Encodable>(for encodableObject: T, in collectionReference: FirebaseCollectionReference) {
        do {
            let json = try encodableObject.toJson(excluding: ["itemID"])
            reference(to: collectionReference).addDocument(data: json)
            
        } catch {
            print(error)
        }
    }
    
    func getUser<T:Decodable>(emailID: String , from collectionReference: FirebaseCollectionReference, returning objectType : T.Type, completion : @escaping (T) -> Void){
        
        
        
        reference(to: .users).document(emailID).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else { return }
            
            do {
                
                let object = try snapshot.decodeUser(as: objectType.self)
                completion(object)
                
            } catch {
                print(error)
            }
            
            
        }
    }
    
    func getRecordsForTheDate(date: String, completion: @escaping(_ response: [String: String]) -> Void){
        let collectionRef = reference(to: .users).document((Auth.auth().currentUser?.email)!).collection("testRecord")
        collectionRef.document(date).addSnapshotListener{documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            if let data = document.data() {
                print("Current data: \(data["totalCaloriesForTheDate"]!)")
                let cals = data["totalCaloriesForTheDate"]!
                completion(["totalCaloriesForTheDate": String(format: "%@", cals as! CVarArg)])
            }else{
                print("Document data was empty.")
                completion([String: String]())
            }
            
        }
    }
    
    func getItems<T: Decodable>(from collectionReference: FirebaseCollectionReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
        
        reference(to: collectionReference).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else { return }
            
            do {
                
                var objects = [T]()
                for document in snapshot.documents {
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                
                completion(objects)
                
            } catch {
                print(error)
            }
            
            
        }
        
    }
    
    func delete<T: Identifiable>(_ identifiableObject: T, in collectionReference: FirebaseCollectionReference) {
        
        do {
            
            guard let itemID = identifiableObject.itemID else { throw MyError.encodingError }
            reference(to: collectionReference).document(itemID).delete()
            
        } catch {
            print(error)
        }
        
        
    }
    
    func updateMeal(dateToUpdate: String, typeOfMeal: String, totalCalories: Double, items: [String], in collectionReference: FirebaseCollectionReference) {
        
        do {
            let collectionRef = reference(to: .users).document((Auth.auth().currentUser?.email)!).collection("testRecord")
            let recordDocRef = collectionRef.document(dateToUpdate)
            recordDocRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    recordDocRef.updateData(["totalCaloriesForTheDate" : document.get("totalCaloriesForTheDate")! as! Double + totalCalories])
                    let mealDocRef = recordDocRef.collection(typeOfMeal).document(typeOfMeal)
                    mealDocRef.getDocument { (mealDoc, err)in
                        if let doc = mealDoc, doc.exists{
                            for item in items {
                                mealDocRef.updateData(["items": FieldValue.arrayUnion([item])]){
                                    err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully updated!")
                                    }
                                }
                            }
                            
                        }else{
                            let newDoc = recordDocRef.collection(typeOfMeal).document(typeOfMeal)
                            newDoc.setData(["items": items]){
                                err in
                                if let err = err {
                                    print("Error writing typeofmeals: \(err)")
                                } else {
                                    print("meals successfully written!")
                                }
                            }
                        }
                    }
                    
                } else {
                    let newDoc = collectionRef.document(dateToUpdate)
                    newDoc.setData(["date": dateToUpdate, "totalCaloriesForTheDate": totalCalories])
                    let newDoc2 = newDoc.collection(typeOfMeal).document(typeOfMeal)
                    newDoc2.setData(["items": items]){
                        err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    print(error)
                }
            }
            
        }
    }
    
    func update<T: Encodable & Identifiable>(for encodableObject: T, in collectionReference: FirebaseCollectionReference) {
        
        do {
            
            let json = try encodableObject.toJson(excluding: ["itemID"])
            guard let itemID = encodableObject.itemID else { throw MyError.encodingError }
            reference(to: collectionReference).document(itemID).setData(json)
            
        } catch {
            print(error)
        }
        
        
        
    }
}
