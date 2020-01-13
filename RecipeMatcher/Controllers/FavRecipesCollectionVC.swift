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


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
}
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return recipeResult.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//        let recipeCollection = recipeResult[indexPath.row]
//        cell.isUserInteractionEnabled = false
//        let status = recipeCollection.favoriteStatus
//        switch status {
//        case true:
//            cell.backgroundColor = .darkGray
//        default:
//            cell.backgroundColor = #colorLiteral(red: 0.9961728454, green: 0.9902502894, blue: 1, alpha: 0.2004762414)
//        }
//
////        cell.recipeLabel.text = recipeCollection.label
////        cell.sourceLabel.text = recipeCollection.source
////        cell.recipeImage.kf.indicatorType = .activity
////        cell.recipeImage.kf.setImage(with: URL(string: recipeToSet.image), placeholder: UIImage(named: "RecipeImgHolder"))
//        return cell
//    }
//
//    // MARK: UICollectionViewDelegate
//
//    /*
//     Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }
//    */
//
//}
