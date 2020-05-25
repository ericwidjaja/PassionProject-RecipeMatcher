//  RecipesCollResultsVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.

import UIKit
import Kingfisher
import FirebaseAuth
import FirebaseFirestore

class RecipesCollResultsVC: UIViewController {
    
    static func fromSearchVC(ingredients: [String]) -> RecipesCollResultsVC {
        let resultVC = RecipesCollResultsVC()
        resultVC.ingredients = ingredients
        //       print(ingredients)
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
    
    //MARK: - Functions
    private func ingredientsQueryString() -> String {
        return ingredients.compactMap({ ingredient in
            ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)})
            .joined(separator: "+")
    }
    
    private func loadSearchQuery() {
        RecipeAPIClient.searchRecipes(keyword: ingredientsQueryString()) { (error, recipe) in
            if let error =  error {
                print(error)
            } else if let recipe = recipe {
                self.recipesResult = recipe
            }
        }
    }
    
    private func updateRecipeHearts(url: String, cell: RecipesCollViewCell) {
        FirestoreService.manager.getUserFavorites(userID: FirebaseAuthService.manager.currentUser?.uid ?? "") { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let favedRecipes):
                if favedRecipes.contains(where: {(recipe) -> Bool in recipe.url == url
                }) {
                    cell.makeHeartFill()
                } else {
                    cell.makeHeartEmpty()
                }
            }
        }
    }
    
    private func updateCellWithFilteredRecipes(_ indexPath: IndexPath, _ cell: RecipesCollViewCell) {
        let filteredRecipes = recipesResult[indexPath.row]
        cell.recipeLabel.text = filteredRecipes.label
        cell.sourceLabel.text = filteredRecipes.source
        cell.heartButton.tag = indexPath.row
        cell.delegate = self
        updateRecipeHearts(url: filteredRecipes.url, cell: cell)
        cell.recipeImage.kf.indicatorType = .activity
        cell.recipeImage.kf.setImage(
            with: URL(string: filteredRecipes.image),
            placeholder: UIImage(named: "RecipeImgHolder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.80))])
    }
    
    //MARK: Firestore
    private func saveRecipeToFireStore(_ tag: Int) {
        let favedRecipe = recipesResult[tag]
        let newFirestoreRecipe = Favorite(creatorID: FirebaseAuthService.manager.currentUser?.uid ?? "", recipeTitle: favedRecipe.label, imageUrl: favedRecipe.image, dateCreated: FirebaseAuthService.manager.currentUser?.metadata.creationDate, urlCookInst: favedRecipe.url, ingredientLinesArr: favedRecipe.ingredientLines)
        FirestoreService.manager.createFavorites(favd: newFirestoreRecipe, recipeTitle: newFirestoreRecipe.label) { (result) in
            switch result {
            case .success:
                print("Saved in firestore")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func deleteRecipeFromFireStore(_ tag: Int) {
        let unFavoriteRecipe = recipesResult[tag]
        FirestoreService.manager.findIdToUnfavor(fave: unFavoriteRecipe.uri, userID: FirebaseAuthService.manager.currentUser?.uid ?? "") { (result) in
            FirestoreService.manager.unfavoritedRecipe(result: result) { (result) in
                switch result {
                case .failure(let error):
                    print("Problem deleting recipe from FireStore: \(error)")
                case .success:
                    print("Recipe successfully unfavorited")
                }
            }
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(recipesCollView)
        recipesCollView.recipeCollectionView.register(RecipesCollViewCell.self, forCellWithReuseIdentifier: "RecipeCell")
        recipesCollView.recipeCollectionView.dataSource = self
        recipesCollView.recipeCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadSearchQuery()
        self.navigationController?.navigationBar.isHidden = true
    }
}
//MARK: - Extension
extension RecipesCollResultsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  recipesCollView.recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipesCollViewCell else { return UICollectionViewCell()
        }
        updateCellWithFilteredRecipes(indexPath, cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Passing cell's data into DetailVC
        let recipeDestinationVC = RecipeDetailVC()
        recipeDestinationVC.recipe = recipesResult[indexPath.row]
        present(recipeDestinationVC, animated: true)
    }
}
//MARK: HeartButton
extension RecipesCollResultsVC: HeartButtonDelegate {
    func saveToPersistance(tag: Int) {
        saveRecipeToFireStore(tag)
    }
    
    func deleteFromPersistance(tag: Int) {
        deleteRecipeFromFireStore(tag)
    }
}
