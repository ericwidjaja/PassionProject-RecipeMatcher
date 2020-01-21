//  FavRecipeDetailVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/20/20.

import UIKit
import SafariServices
import Kingfisher

class FavRecipeDetailVC: UIViewController {

    //MARK: - Properties
    var selectedRecipe: Favorite!
    var favDetailRecipe = RecipeDetailView()
    
    //MARK: - Methods
    func setDetailRecipeView() {
        view.addSubview(favDetailRecipe)
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        favDetailRecipe.recipeImage.kf.indicatorType = .activity
        favDetailRecipe.recipeImage.kf.setImage(with: URL(string: selectedRecipe.imageUrl!), placeholder: UIImage(named: "RecipeImgHolder"), options: [
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(2))])
        
        favDetailRecipe.recipeLabel.text = selectedRecipe.label
        
        let cookingInstUrl = selectedRecipe.url
        
    }
    func showSafariVC(for cookingInstUrl: String) {
        guard let url = URL(string: cookingInstUrl)
            else {return}
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    @objc func cookingInstructionButtonPressed(_ sender: UIButton) {
        showSafariVC(for: "\(self.selectedRecipe.url)")
        print("safari is opening: \(self.selectedRecipe.url)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailRecipeView()
        favDetailRecipe.urlButton.addTarget(self, action: #selector(cookingInstructionButtonPressed(_:)), for: .touchUpInside)
    }
}
