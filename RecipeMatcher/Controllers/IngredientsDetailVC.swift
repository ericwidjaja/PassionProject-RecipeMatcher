//  IngredientsDetailVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/16/19.

import UIKit
import Kingfisher
import SafariServices

class RecipeDetailVC: UIViewController {
    
    //MARK: - Properties
    var recipe: RecipeWrapper!
    var detailIngredients = DetailView()
    var recipeCollresult = RecipesCollResultsVC()
    
//    static func fromRecipesCollResultVC(url: [String]) -> RecipeDetailVC {
//        let cookingInstrUrlVC = RecipeDetailVC()
//       
//    }
    
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
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            print("url is not found")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true) }
    
    @objc func cookingInstructionButtonPressed(_ sender: UIButton) {
        showSafariVC(for: "http://glutenfreegirl.com/2005/12/and-finally-theres-teff/")
        
        //code here to open in safari with url link
        print("need to code url link in safari")
//        print("\(recipesResult[indexPath.row].url)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailRecipeView()
        detailIngredients.urlButton.addTarget(self, action: #selector(cookingInstructionButtonPressed(_:)), for: .touchUpInside)

    }
}
