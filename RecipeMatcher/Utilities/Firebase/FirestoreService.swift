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
    //MARK: Favorites
    func createFavorite(favd: Favorite, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = favd.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.favorites.rawValue).addDocument(data: fields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getFavorites(forUserID: String, completion: @escaping (Result<[Favorite], Error>) -> ()) {
        db.collection(FireStoreCollections.favorites.rawValue).whereField("creatorID", isEqualTo: forUserID).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                
            } else {
                let favorites = snapshot?.documents.compactMap({(snapshot) -> Favorite? in
                    let faveID = snapshot.documentID
                    let favorite = Favorite(from: snapshot.data(), id: faveID)
                    return favorite
                })
                completion(.success(favorites ?? []))
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
                    return favorite
                })
                completion(.success(favorites ?? []))
            }
        }
        db.collection(FireStoreCollections.favorites.rawValue).order(by: sortingCriteria?.rawValue ?? "dateCreated", descending: sortingCriteria?.shouldSortAscending ?? true).getDocuments(completion: completionHandler)
    }
//
//    private init() {}
}
