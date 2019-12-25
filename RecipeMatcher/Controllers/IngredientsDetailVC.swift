//  IngredientsDetailVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/16/19.

import UIKit
import Kingfisher

class IngredientsDetailVC: UIViewController {
    
    //MARK: - Properties
    var recipe: RecipeWrapper!
//    var cookingInstruction: RecipeWrapper!
    var detailIngredients = DetailView()
    
    
    //MARK: Private Methods
    private func setDetailRecipeView() {
        view.addSubview(detailIngredients)
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        detailIngredients.recipeImage.kf.indicatorType = .activity
        detailIngredients.recipeImage.kf.setImage(with: URL(string: recipe.image), placeholder: UIImage(named: "RecipeImgHolder"))
        
        detailIngredients.recipeLabel.text = recipe.label
        let lines = recipe.ingredientLines.map {$0.replacingOccurrences(of: ",", with: "")}
            .map { $0 + "\n" }
        let arrangedIngredients = lines.joined()
        detailIngredients.ingredientsTxtView.text = arrangedIngredients
    }
    @objc func cookingInstructionButtonPressed(_ sender: UIButton) {
        //code here to open in safari with url link
        print("need to code url link in safari")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailRecipeView()
        detailIngredients.urlButton.addTarget(self, action: #selector(cookingInstructionButtonPressed(_:)), for: .touchUpInside)

    }
}
