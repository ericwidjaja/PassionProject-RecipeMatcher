//  FavRecipesVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/23/19.

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class FavRecipesVC: UIViewController {
    
    //MARK: - Properties
    var faveRecipe = FavRecipesView()
    var favoriteRecipe = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.faveRecipe.favoriteList.reloadData()
                //checking if the recipes that user favorited are existed
                dump(self.favoriteRecipe)
            }
        }
    }

    @objc private func signOut() {
        let alert = UIAlertController(title: "Sign Out from this App?", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction.init(title: "Yes", style: .destructive, handler: .some({ (action) in
            DispatchQueue.main.async {
                FirebaseAuthService.manager.logoutUser()
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                    else {
                        return
                }
                UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut
                    , animations: {
                        window.rootViewController = LogInScreenVC()
                }, completion: nil)
            }
        }))
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated:true)
    }
    
    private func getUserFavorites() {
        FirestoreService.manager.getAllFavorites(sortingCriteria: .fromNewestToOldest)
        {(result) in
            switch result {
            case .success(let favorites):
                self.favoriteRecipe = favorites
            case .failure(let error):
                print("error getting fave recipes \(error)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
        view.backgroundColor = .red
        getUserFavorites()
        
    }
}
