//  FavRecipeDetailVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/20/20.
import UIKit
import Kingfisher
import SafariServices
import FirebaseAuth
import FirebaseFirestore


class FavRecipeDetailVC: UIViewController {
    
    //MARK: - Properties
    var selectedFavRecipe: Favorite!
    var favDetailRecipe = RecipeDetailView()
    var heartStatus: HeartStatus = .notFilled
    
    //MARK: - Functions
    private func updateRecipeHearts(url: String) {
        FirestoreService.manager.getUserFavorites(userID: FirebaseAuthService.manager.currentUser?.uid ?? "") { (result) in
            print("Result from FavREcipeDetailVC \(result)")
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
        favDetailRecipe.heartButton.setImage(heart, for: .normal)
        heartStatus = .filled
    }
    
    private func makeHeartEmpty() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: UIImage.SymbolWeight.medium)
        let heart = UIImage(systemName: "heart", withConfiguration: config)
        favDetailRecipe.heartButton.setImage(heart, for: .normal)
        heartStatus = .notFilled
    }
    
    func setDetailRecipeView() {
        view.addSubview(favDetailRecipe)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        guard let selectedRecipe = selectedFavRecipe else {
            fatalError("A recipe, from FavDetailVC is expected at this point")
        }
        
        updateRecipeHearts(url: selectedRecipe.url)
        
        favDetailRecipe.recipeImage.kf.indicatorType = .activity
        favDetailRecipe.recipeImage.kf.setImage(with: URL(string: selectedFavRecipe.imageUrl!), placeholder: UIImage(named: "RecipeImgHolder"), options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(2))])
        
        favDetailRecipe.recipeLabel.text = selectedFavRecipe.label
        
        let linesFavDVC = selectedFavRecipe.ingredientLines.map{$0.replacingOccurrences(of: ",", with: "")}
            .map { $0 + "\n"}
        
        let arrangedIngredients = linesFavDVC.joined()
        favDetailRecipe.ingredientsTxtView.text = arrangedIngredients
        
        //code start here to open in safari with url link
        let cookingInstUrl = selectedFavRecipe.url
    }
    
    func showSafariVC(for cookingInstUrl: String) {
        guard let url = URL(string: cookingInstUrl)
            else {return}
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    @objc func cookingInstructionButtonPressed(_ sender: UIButton) {
        showSafariVC(for: "\(self.selectedFavRecipe.url)")
        print("safari is opening: \(self.selectedFavRecipe.url)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailRecipeView()
        favDetailRecipe.urlButton.addTarget(self, action: #selector(cookingInstructionButtonPressed(_:)), for: .touchUpInside)
    }
}
