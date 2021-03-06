//  FirestoreService.swift
//  RecipeMatcher

import Foundation
import FirebaseAuth
import FirebaseFirestore

fileprivate enum FireStoreCollections: String {
    case users
    case favoriteRecipes
    case addComments
}

enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortAscending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}

class FirestoreService {
    
    static let manager = FirestoreService()
    private let db = Firestore.firestore()
    
    // MARK: - AppUsers
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields: [String : Any] = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    func getUserInfo(userID: String, completion: @escaping (Result<AppUser,Error>) ->()) {
        db.collection("users").document(userID).getDocument { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot,
                let data = snapshot.data() {
                let userID = snapshot.documentID
                let user = AppUser(from: data, id: userID)
                if let appUser = user {
                    completion(.success(appUser))
                }
            }
        }
    }
    
    //MARK: Favorites
    
    func createFavorites(favd: Favorite, recipeTitle: String, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = favd.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.favoriteRecipes.rawValue).document(favd.id).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            } else {
                completion(.success(()))
                print("created favd.id = \(favd.id)")
            }
        }
    }
    
    func getAllFavorites(sortingCriteria: SortingCriteria?, completion: @escaping (Result<[Favorite], Error>) -> ()) {
        let completionHandler: FIRQuerySnapshotBlock = {
            (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let favorites = snapshot?.documents.compactMap({(snapshot) -> Favorite? in
                    let faveID = snapshot.documentID
                    let favorite = Favorite(from: snapshot.data(), id: faveID)
//                    print(faveID + " <--faveID")
                    return favorite
                })
                completion(.success(favorites ?? []))
            }
        }
        db.collection(FireStoreCollections.favoriteRecipes.rawValue).order(by: sortingCriteria?.rawValue ?? "dateCreated", descending: sortingCriteria?.shouldSortAscending ?? true).getDocuments(completion: completionHandler)
    }
    
    func getUserFavorites(userID: String, completion: @escaping (Result<[Favorite],Error>) ->()) {
        let userID = FirebaseAuthService.manager.currentUser?.uid
        db.collection(FireStoreCollections.favoriteRecipes.rawValue).whereField("creatorID", isEqualTo: userID!).getDocuments { (snapshot, error) in
            if let error = error{
                completion(.failure(error))
            } else {
                let users = snapshot?.documents.compactMap({ (snapshot) -> Favorite? in
                    let faveID = snapshot.documentID
                    let user = Favorite(from: snapshot.data(), id: faveID)
                    return user
                })
                completion(.success(users ?? []))
            }
        }
    }
    
    func findIdToUnfavor(fave id: String, userID: String, completionHandler: @escaping (Result<String,Error>) -> ()) {
        db.collection(FireStoreCollections.favoriteRecipes.rawValue).whereField("creatorID", isEqualTo: userID).whereField("faveId", isEqualTo: id).getDocuments {(snapshot,error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                let recipes = snapshot?.documents.compactMap({ (snapshot) -> Favorite? in
                    let faveID = snapshot.documentID
                    let singleRecipe = Favorite(from: snapshot.data(), id: faveID)
                    
//                    print("faveID from line 101 -> \(faveID)")
                    return singleRecipe
                })
                print(recipes!)
//                if let recipes = recipes {
//                    completionHandler(.success(recipes[0].id))
//                    print("findIdToUnfavor = \(recipes[0].id)")
//                }
            }
        }
    }
    
    func unfavoriteRecipe(faveId: String, completion: @escaping (Result<(),Error>) -> ()) {
        let creatorID = (FirebaseAuthService.manager.currentUser?.uid)!
        db.collection(FireStoreCollections.favoriteRecipes.rawValue).whereField("faveId", isEqualTo: faveId).getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                    completion(.success(()))
                }
            }
        }
    }
    
    func unfavoritedRecipe(result: (Result<String,Error>), completion: @escaping (Result<(),Error>) ->()) {
        switch result {
        case .success(let favId):
            db.collection(FireStoreCollections.favoriteRecipes.rawValue).document(favId).delete {
                (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func updateAppUser(id: String,newDisplayName: String,completion: @escaping (Result<(),Error>) -> ()) {
        db.collection(FireStoreCollections.users.rawValue).document(id).updateData(["userName": newDisplayName]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
