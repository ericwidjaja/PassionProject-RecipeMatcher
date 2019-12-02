//  SearchRecipesVC.swift
//  RecipeMatcher

import UIKit
import Foundation

class SearchRecipesVC : UIViewController {

//MARK: - Properties
    var recipes = [RecipeWrapper]()
    var searchIngredient = SearchView()
    var ingredients = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.searchIngredient.ingredientsTblView.reloadData()
            }
        }
    }
    
    
    
 

//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchIngredient)

    }
}
//MARK: - Extensions

extension SearchRecipesVC: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchIngredient.ingredientTextField.clearsOnBeginEditing = true
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchIngredient.ingredientTextField.resignFirstResponder()
        let ingredient = searchIngredient.ingredientTextField.text
        ingredients.append(ingredient ?? "Not Found")
        searchIngredient.ingredientTextField.text = ""
        return true
    }
}
