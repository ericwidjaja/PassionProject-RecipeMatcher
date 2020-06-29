//  RecipeDetailVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/16/19.

import UIKit
import SafariServices
import Kingfisher
import FirebaseAuth
import FirebaseFirestore

class RecipeDetailVC: UIViewController {
    
    //MARK: - Properties
    var recipe: RecipeWrapper!
    var detailRecipe = RecipeDetailView()
    
    //MARK: - Functions
    func setDetailRecipeView() {
        view.addSubview(detailRecipe)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //https://cocoapods.org/pods/Kingfisher
        detailRecipe.recipeImage.kf.indicatorType = .activity
        detailRecipe.recipeImage.kf.setImage(
            with: URL(string: recipe.image),
            placeholder: UIImage(named: "RecipeImgHolder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(2))])
        
        detailRecipe.recipeLabel.text = recipe.label
        let lines = recipe.ingredientLines.map {$0.replacingOccurrences(of: ",", with: "")}
            .map { $0 + "\n" }
        let arrangedIngredients = lines.joined()
        detailRecipe.ingredientsTxtView.text = arrangedIngredients
        
        //code start here to open in safari with url link
        let cookInstUrl = recipe.url
    }
    
    func showSafariVC(for cookInstUrl: String) {
        guard let url = URL(string: cookInstUrl)
            else {return}
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @objc func cookingInstructionButtonPressed(_ sender: UIButton) {
        showSafariVC(for: "\(self.recipe.url)")
        print("\(self.recipe.url)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailRecipeView()
        detailRecipe.urlButton.addTarget(self, action: #selector(cookingInstructionButtonPressed(_:)), for: .touchUpInside)
    }
}
