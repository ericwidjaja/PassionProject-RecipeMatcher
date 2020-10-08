//  FirebaseAuthService.swift
//  RecipeMatcher

import Foundation
import FirebaseAuth

class FirebaseAuthService {
    
    //MARK: -Static Properties
    static let manager = FirebaseAuthService()
    
    //MARK: -Internal Properties
    private let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    
    //MARK: -Internal Functions
    func createNewUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                completion(.success(createdUser))
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping(Result<(), Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            
            if result?.user != nil {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func updateUserFields(userName: String? = nil, photoURL: String? = nil, completion: @escaping (Result<(),Error>) -> ()){
        let changeRequest = auth.currentUser?.createProfileChangeRequest()
        if let userName = userName {
            changeRequest?.displayName = userName
        }
        if let photoURL = URL(string: photoURL ?? "") {
            changeRequest?.photoURL = photoURL
        }
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }
    
    func logoutUser() {
        do {
            try auth.signOut()
            print("logging out")
        } catch {
            print(error)
        }
    }
    //MARK: -Private Initializers
    private init() {}
    
}
