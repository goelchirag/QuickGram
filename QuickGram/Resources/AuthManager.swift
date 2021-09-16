//
//  AuthManager.swift
//  QuickGram
//
//  Created by Chirag Goel on 07/09/21.
//

import Foundation
import FirebaseAuth
public class AuthManager{
    static let shared = AuthManager()
    
    ///Register a new User
    public func registerNewUser(username : String,email : String, password :String,completion :@escaping (Bool) -> Void){
        databaseManager.shared.canCreateNewUser(with: email, username: username) { (canCreate) in
            if canCreate{
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                    guard  err == nil ,result != nil else{
                        completion(false)
                        return
                    }
                    ///INSERT into Database
                    databaseManager.shared.insertNewUser(with: email, username: username) { (success) in
                        if(success){
                            completion(true)
                            return
                        }else{
                            completion(false)
                            return
                        }
                    }
                }
            }else{
                completion(false)
            }
        }
    }
    
    ///Login User
    public func loginUser(username : String?,email : String? , password : String,completion :@escaping ((Bool)->Void)){
        
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                guard result != nil ,err == nil else {
                    completion(false)
                    return;
                }
                completion(true)
            }
        }else if let username = username{
            print(username)
            
        }
    }
    
    public func logOut(completion :@escaping (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            completion(false)
            return
        }
    }
}
