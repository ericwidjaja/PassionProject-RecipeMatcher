////  FavRecipesCollectionVC.swift
////  RecipeMatcher
////  Created by Eric Widjaja on 12/25/19.

import UIKit
import Kingfisher


class FavRecipesCollectionVC: UICollectionViewController {
//    MARK: - Properties
        var faveRecipeView = FavRecipesView()
        var favedCell = RecipesCollViewCell()
    var favorited = [Favorite]() {
        didSet {
            self.faveRecipeView.favoriteList.reloadData()
        }
    }

private let reuseIdentifier = "FavoriteCell"

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(faveRecipeView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
