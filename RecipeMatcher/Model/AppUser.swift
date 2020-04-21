//  AppUser.swift
//  RecipeMatcher

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct AppUser {
    let email: String?
    let uid: String
    let userName: String?
    let dateCreated: Date?
    
//    MARK: - Init
    init(from user: User, userName: String) {
        self.userName = userName
        self.email = user.email
        self.uid = user.uid
        self.dateCreated = user.metadata.creationDate
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let userName = dict["userName"] as? String,
        let email = dict["email"] as? String,
        let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else {return nil}
        
        self.userName = userName
        self.email = email
        self.dateCreated = dateCreated
        self.uid = id
    }
    
    var fieldsDict: [String: Any] {
        return [
            "userName": self.userName ?? "n/a",
            "email": self.email ?? "",
            "dateCreated": self.dateCreated ?? ""
        ]
    }
}
