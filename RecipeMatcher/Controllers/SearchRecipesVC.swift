//  SearchRecipesVC.swift
//  RecipeMatcher

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SearchRecipesVC : UIViewController {
    
    //MARK: - Properties
    var recipes = [RecipeWrapper]()
    var searchView = SearchView()
    var ingredients = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.ingredientsTblView.reloadData()
            }
        }
    }
    
    @objc func findRecipeButtonPressed(_ sender: UIButton) {
        
        let findRecipeVC = RecipesCollResultsVC.fromSearchVC(ingredients: ingredients)
        navigationController?.pushViewController(findRecipeVC, animated: true)
        dump(ingredients)
    }
    
    @objc private func signOut() {
      let alert = UIAlertController(title: "Sign Out from this App?", message: nil, preferredStyle: .actionSheet)
      let action = UIAlertAction.init(title: "Yes", style: .destructive, handler: .some({ (action) in
        DispatchQueue.main.async {
          FirebaseAuthService.manager.logoutUser()
          guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
            else {
              return
          }
            UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: {
            window.rootViewController = LogInScreenVC()
          }, completion: nil)
        }
      }))
      let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(action)
      alert.addAction(cancel)
      present(alert, animated:true)
    }
    private func loadSearchData() {
        searchView.ingredientsTblView.dataSource = self
        searchView.ingredientsTblView.delegate = self
        searchView.ingredientTextField.delegate = self
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchView)
        loadSearchData()
        searchView.findRecipesButton.addTarget(self, action: #selector(findRecipeButtonPressed), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
    }
}
//MARK: - Extensions

extension SearchRecipesVC: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchView.ingredientTextField.clearsOnBeginEditing = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchView.ingredientTextField.resignFirstResponder()
        let ingredient = searchView.ingredientTextField.text
        ingredients.append(ingredient ?? "Not Found")
        searchView.ingredientTextField.text = ""
        return true
    }
    
}

extension SearchRecipesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.ingredientsTblView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deselect = UITableViewRowAction(style: .destructive, title: "X") { [weak self] (action, indexPath) in
            self?.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deselect]
    }
}
