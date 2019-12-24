//  RecipesCollResultsVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Kingfisher

class RecipesCollResultsVC: UIViewController {
    
    static func fromSearchVC(ingredients: [String]) -> RecipesCollResultsVC {
        let resultVC = RecipesCollResultsVC()
        resultVC.ingredients = ingredients
        print(ingredients)
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


extension RecipesCollResultsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  recipesCollView.recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipesCollViewCell else { return UICollectionViewCell() }
        let recipeToSet = recipesResult[indexPath.row]
        cell.recipeLabel.text = recipeToSet.label
        cell.sourceLabel.text = recipeToSet.source
        cell.recipeImage.kf.indicatorType = .activity
        cell.recipeImage.kf.setImage(with: URL(string: recipeToSet.image), placeholder: UIImage(named: "RecipeImgHolder"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let recipeDestinationVC = IngredientsDetailVC()
        recipeDestinationVC.recipe = recipesResult[indexPath.row]
//        recipeDestinationVC.cookingInstruction = recipesResult[indexPath.row].url
        present(recipeDestinationVC, animated: true)
        print("pass data to recipeDetailVC")
        
    }
}
