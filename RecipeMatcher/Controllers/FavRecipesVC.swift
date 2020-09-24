//  FavRecipesVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/23/19.

import UIKit
import Kingfisher
import FirebaseFirestore
import FirebaseAuth

class FavRecipesVC: UIViewController {
    
    //MARK: - Properties
    var faveRecipeView = FavRecipesView()
    var favedCell = FavdRecipesCell()
    var favoriteRecipe = [Favorite]() {
        didSet {
            DispatchQueue.main.async {
                self.faveRecipeView.favoriteCollView.reloadData()
                //checking if the recipes that user favorited are existed
                //                dump(self.favoriteRecipe)
            }
        }
    }
    
    //MARK: - Functions
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func getUserFavorites() {
        DispatchQueue.global(qos: .default).async {
            guard FirebaseAuthService.manager.currentUser != nil else
            { return }
            FirestoreService.manager.getAllFavorites(sortingCriteria: .fromNewestToOldest)
            {(result) in
                switch result {
                case .success(let favorites):
                    self.favoriteRecipe = favorites
                case .failure(let error):
                    self.showAlert(with: "Oopps, encountered error in getting Faved Recipes", and: "\(error)")
                }
            }
        }
    }
    
    private func updateCellsWithFaveRecipes(_ indexPath: IndexPath,_ cell: FavdRecipesCell) {
        let favdRecipeToSet = favoriteRecipe[indexPath.row]
        cell.favdRecipeLabel.text = favdRecipeToSet.recipe.label
        cell.favdRecipeImage.kf.indicatorType = .activity
        cell.favdRecipeImage.kf.setImage(
            with: URL(string: favdRecipeToSet.recipe.image),
            placeholder: UIImage(named: "RecipeImgHolder"),
            options: [ .scaleFactor(UIScreen.main.scale),
                       .transition(.flipFromRight(3))])
    }
    
    private func setFaveDelegates() {
        faveRecipeView.favoriteCollView.delegate = self
        faveRecipeView.favoriteCollView.dataSource = self
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(faveRecipeView)
        getUserFavorites()
        setFaveDelegates()
        faveRecipeView.favoriteCollView.register(FavdRecipesCell.self, forCellWithReuseIdentifier: "FavdCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserFavorites()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
}

//MARK: - Extensions
extension FavRecipesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteRecipe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let favCell = faveRecipeView.favoriteCollView.dequeueReusableCell(withReuseIdentifier: "FavdCell", for: indexPath) as? FavdRecipesCell else {
            return UICollectionViewCell()
        }
        updateCellsWithFaveRecipes(indexPath, favCell)
        return favCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        Passing selected FavRecipe into DetailVC
        let favToDetailVC = RecipeDetailVC()
        favToDetailVC.recipe = favoriteRecipe[indexPath.row].recipe
        present(favToDetailVC, animated: true)
    }
}

extension FavRecipesVC : HeartButtonDelegate {
    func saveToPersistance(tag: Int) {
    }
    
    func deleteFromPersistance(tag: Int) {
    }
}

