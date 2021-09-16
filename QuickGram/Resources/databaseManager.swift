//
//  databaseManager.swift
//  QuickGram
//
//  Created by Chirag Goel on 07/09/21.
//
import FirebaseDatabase
import Foundation

public class databaseManager{
    static let shared = databaseManager()
    private let database = Database.database().reference()
    ///check if a user can be created with the given details
    public func canCreateNewUser(with email : String,username :String, completion: (Bool)->Void){
        completion(true)
    }
    
    
    //insert new User to data base
    public func insertNewUser(with email:String , username:String,completion : @escaping (Bool)->Void){
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username": username]) { (err, ref) in
            if err == nil{
                completion(true)
                return
            }else {
                completion(false)
                return
            }
        }
    }
}

