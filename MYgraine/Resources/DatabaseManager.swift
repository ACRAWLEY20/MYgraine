//
//  DatabaseManager.swift
//  MYgraine
//
//  Created by Anthony Crawley on 7/17/20.
//  Copyright © 2020 Anthony Crawley. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
}

//MARK: - Account Management

extension DatabaseManager {
    
    public func validateNewUser(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else{
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func insertUser(with user: MYgraineAppUser) {
        database.child(user.safeEmail).setValue(["first_name": user.firstName,
                                                    "last_name": user.lastName])
    }
    
}

struct MYgraineAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    // let profilePicture: URL
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
