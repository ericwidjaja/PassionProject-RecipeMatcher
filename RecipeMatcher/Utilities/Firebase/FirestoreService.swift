//  FirestoreService.swift
//  RecipeMatcher

import Foundation
import FirebaseFirestore

fileprivate enum FireStoreCollections: String {
    case users
    case favorites
    case addComments
}

enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortDescending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}

class FirestoreService {
    
    static let manager = FirestoreService()
    
    private let db = Firestore.firestore()
    
    //        MARK: - AppUsers
    
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields: [String : Any] = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(()))
        }
    }
    
    func updateFavoriteRecipes(newStatus: Bool?, uri: String, completion: @escaping (Result <(), Error>) -> ()) {
        guard let userID = FirebaseAuthService.manager.currentUser?.uid else {
            return
        }
        var updateFields = [String : Any]()
        if let status = newStatus {
            updateFields["favoriteRecipes"] = status
            updateFields["userID"] = userID
        }
        let recipe = db.collection("recipes").document(uri)
        
        recipe.updateData(updateFields) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    private init() {}
}
