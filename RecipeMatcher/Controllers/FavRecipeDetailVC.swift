//  FavRecipeDetailVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/20/20.

import UIKit
import SafariServices
import Kingfisher
import FirebaseAuth
import FirebaseFirestore

class FavRecipeDetailVC: UIViewController {
    
    enum HeartStatus {
        case filled
        case notFilled
    }
    
    //MARK: - Properties
    var selectedRecipe: Favorite!
//    var favDetailRecipe = RecipeDetailView()
    var detailRecipeView = RecipeDetailView()
    var heartStatus: HeartStatus = .notFilled
    
    //MARK: - Functions
    private func updateRecipeHearts(url: String) {
        FirestoreService.manager.getUserFavorites(userID: FirebaseAuthService.manager.currentUser?.uid ?? "") { (result) in
            print(result)
            switch result {
                
            case .failure(let error):
                print(error)
            case .success(let favedRecipes):
                if favedRecipes.contains(where: {(recipe) -> Bool in recipe.url == url
                }) {
                    self.makeHeartFill()
                } else {
                    self.makeHeartEmpty()
                }
            }
        }
    }
    
    private func setHeartImage() {
        switch heartStatus {
        case .filled:
            makeHeartFill()
        case .notFilled:
            makeHeartEmpty()
        }
    }
    
    private func makeHeartFill() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart.fill", withConfiguration: config)
        detailRecipeView.heartButton.setImage(heart, for: .normal)
        heartStatus = .filled
    }
    
    private func makeHeartEmpty() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        detailRecipeView.heartButton.setImage(heart, for: .normal)
        heartStatus = .notFilled
    }
    
    func setDetailRecipeView() {
        view.addSubview(detailRecipeView)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //https://cocoapods.org/pods/Kingfisher
        guard let selectedRecipe =  recipe else {
            fatalError("A recipe is expected at this point")
        }
        updateRecipeHearts(url: selectedRecipe.url)
        detailRecipeView.recipeImage.kf.indicatorType = .activity
        detailRecipeView.recipeImage.kf.setImage(
            with: URL(string: recipe?.image ?? ""),
            placeholder: UIImage(named: "RecipeImgHolder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(2))])
        
        detailRecipeView.recipeLabel.text = recipe?.label
        let lines = recipe?.ingredientLines.map {$0.replacingOccurrences(of: ",", with: "")}
            .map { $0 + "\n" }
        let arrangedIngredients = lines?.joined()
        detailRecipeView.ingredientsTxtView.text = arrangedIngredients
        
        //code start here to open in safari with url link
        let cookInstUrl = recipe?.url
    }
    
    func showSafariVC(for cookInstUrl: String) {
        guard let url = URL(string: cookInstUrl)
            else {return}
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func buttonsTapped () {
        detailRecipeView.urlButton.addTarget(self, action: #selector(cookingInstructionButtonPressed(_:)), for: .touchUpInside)
        detailRecipeView.heartButton.addTarget(self, action: #selector(heartButtonPressed(_:)), for: .touchUpInside)
        detailRecipeView.shareButton.addTarget(self, action: #selector(shareTapped(_:)), for: .touchUpInside)
        detailRecipeView.bookmarkButton.addTarget(self, action: #selector(bookmarkTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func cookingInstructionButtonPressed(_ sender: UIButton) {
        showSafariVC(for: "\(self.selectedRecipe.url)")
        print("safari is opening: \(self.selectedRecipe.url)")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailRecipeView()
        
    }
}
