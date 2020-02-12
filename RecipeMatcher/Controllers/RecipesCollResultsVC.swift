//  RecipesCollResultsVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import Kingfisher

class RecipesCollResultsVC: UIViewController {
    
    static func fromSearchVC(ingredients: [String]) -> RecipesCollResultsVC {
        let resultVC = RecipesCollResultsVC()
        resultVC.ingredients = ingredients
//        print(ingredients)
        return resultVC
    }
    
    //MARK: - Properties
    var recipesCollView = RecipeCollView()
    var ingredients = [String]()
    
    var recipesResult = [RecipeWrapper]() {
        didSet {
            DispatchQueue.main.async {
                self.recipesCollView.recipeCollectionView.reloadData()
            }
        }
    }
    
    func getFavoritesAndSetHeart(cell: RecipesCollViewCell, recipe: RecipeWrapper) {
        var favorites = [Favorite]()
        let creatorID = FirebaseAuthService.manager.currentUser!.uid
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in FirestoreService.manager.getUserFavorites { (result) in
                switch result {
                case .success(let userFavorites):
                    favorites = userFavorites
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//            print(creatorID + recipe.label)
            
            if favorites.contains(where: {$0.id! == creatorID + recipe.label} ) {
                cell.faveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.recipesCollView.recipeCollectionView.reloadData()
            } else {
                cell.faveButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(recipesCollView)
        recipesCollView.recipeCollectionView.register(RecipesCollViewCell.self, forCellWithReuseIdentifier: "RecipeCell")
        recipesCollView.recipeCollectionView.dataSource = self
        recipesCollView.recipeCollectionView.delegate = self
    }
    
    private func updateData() {
        RecipeAPIClient.searchRecipes(keyword: ingredientsQueryString()) { (error, recipe) in
            if let error =  error {
                print(error)
            } else if let recipe = recipe {
                self.recipesResult = recipe
            }
        }  
    }
    
    private func ingredientsQueryString() -> String {
        return ingredients.compactMap({ ingredient in
            ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)})
            .joined(separator: "+")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
}

extension RecipesCollResultsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  recipesCollView.recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipesCollViewCell else { return UICollectionViewCell()
        }
        
        cell.cellDelegate = self
        cell.faveButton.tag = indexPath.row
        let recipeToSet = recipesResult[indexPath.row]
        getFavoritesAndSetHeart(cell: cell, recipe: recipeToSet)
       
        cell.recipeLabel.text = recipeToSet.label
        cell.sourceLabel.text = recipeToSet.source
        cell.recipeImage.kf.indicatorType = .activity
        cell.recipeImage.kf.setImage(
            with: URL(string: recipeToSet.image),
            placeholder: UIImage(named: "RecipeImgHolder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.80))])
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Passing cell's data into DetailVC
        let recipeDestinationVC = RecipeDetailVC()
        recipeDestinationVC.recipe = recipesResult[indexPath.row]
        present(recipeDestinationVC, animated: true)
    }
}

//Use firestoreservice to make a favorite on firebase.
extension RecipesCollResultsVC: buttonFunction {
    func heartButtonPressed(tag: Int) {
        let selectedIndex = IndexPath(row: tag, section: 0)
        let selectedRecipe = recipesCollView.recipeCollectionView.cellForItem(at: selectedIndex) as! RecipesCollViewCell
        let singleRecipe = recipesResult[tag]
        let favorited = Favorite(imageUrl: singleRecipe.image, creatorID: FirebaseAuthService.manager.currentUser?.uid ?? "NA", dateCreated: Date(), recipeTitle: singleRecipe.label, urlCookInst: singleRecipe.url, ingredientLinesArr: singleRecipe.ingredientLines)
        
        FirestoreService.manager.createFavorites(favd: favorited, recipeTitle: singleRecipe.label) { (result) in
            switch result {
            case .success:
                print("successfully written in Firestore")
                self.recipesCollView.recipeCollectionView.reloadData()
            case .failure (let error):
                print(error)
            }
        }
//        print(singleRecipe.label)
    }
}
