//
//  StorageManager.swift
//  QuickGram
//
//  Created by Chirag Goel on 07/09/21.
//

import Foundation
import FirebaseStorage
public class StorageManager{
    static let shared = StorageManager()
    
    public enum IGStorageManagerError : Error{
        case failedToDownload
    }
    
    private let bucket = Storage.storage().reference()
    
    public func uploadUserPost(model :UserPost,completion :@escaping (Result<URL,Error>) -> Void){
        
    }
    public func downlaodImage(with reference : String, completion : @escaping (Result<URL,IGStorageManagerError>) -> Void){
        bucket.child(reference).downloadURL(completion: { url,err  in
            guard let url = url ,err == nil else{
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
}
public enum postType {
    case photo,video
}
public struct UserPost{
    
}

