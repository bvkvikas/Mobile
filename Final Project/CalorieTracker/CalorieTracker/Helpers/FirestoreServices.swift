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
        
         //   let json = try encodableObject.toJson(excluding: [])
          //  reference(to: collectionReference).addDocument(data: json)
            reference(to: collectionReference).document(user.emailID).setData([
                
                "firstName" : user.firstName!,
                "lastName" : user.lastName!,
                "emailID": user.emailID!,
                "age": user.age!,
                "gender": user.gender!,
                "heightFeet": user.heightFeet!,
                "heightInches": user.heightInches!,
                "totalCaloriesToConsume": user.totalCaloriesToConsume!,
                "weight": user.weight!
                  
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
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
                    
                let object = try snapshot.decode(as: objectType.self)
                    completion(object)
                
            } catch {
                print(error)
            }
            
            
        }
        
        
        
        
        
//        reference(to: .users).document(emailID)
//        .addSnapshotListener { (documentSnapshot, error) in
//          guard let document = documentSnapshot else {
//            print("Error fetching document: \(error!)")
//            return
//          }
//          guard let data = document.data() else {
//            var object = try document?.decode(as: objectType.self)
//            print("Document data was empty.")
//            return
//          }
//          print("Current data: \(data)")
//
//        }
//
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
