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
    
    
    
//MARK: - Functions

//    func addIngredient() {
//        if let ingredient = searchIngredient.ingredientTextField.text {
//        let trimmedIngredient = ingredient.trim()
//            if !trimmedIngredient.isEmpty {
//                self.ingredients.append(trimmedIngredient)
//                self.tableView.reloadData()
//                self.textField.text = ""
//                self.textField.placeholder = textFieldPlaceholder
//                dismissKeyboard()
//                searchButtonEnabled()
//            }
//        }
//    }
//
//    func deleteIngredient(sender: UIButton) {
//        let index: Int = (sender.layer.value(forKey: "index")) as! Int
//        ingredients.remove(at: index)
//        tableView.reloadData()
//        dismissKeyboard()
//        searchButtonEnabled()
//    }
    private func loadSearchData() {
        
        searchIngredient.ingredientsTblView.dataSource = self
        searchIngredient.ingredientsTblView.delegate = self
        searchIngredient.ingredientTextField.delegate = self
        
    }


//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchIngredient)
        loadSearchData()

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

extension SearchRecipesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchIngredient.ingredientsTblView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}
