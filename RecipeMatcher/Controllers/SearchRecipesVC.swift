//  SearchRecipesVC.swift
//  RecipeMatcher

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

//class SearchRecipesVC : UIViewController {
//
//    //MARK: - Properties
//    var recipes = [RecipeWrapper]()
//    var searchView = SearchView()
//    var ingredients = [String]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.searchView.ingredientsTblView.reloadData()
//            }
//        }
//    }
//
//    //MARK: - OBJC Functions
//    @objc func findRecipeButtonPressed(_ sender: UIButton) {
//        let findRecipeVC = RecipesCollResultsVC.fromSearchVC(ingredients: ingredients)
//        navigationController?.pushViewController(findRecipeVC, animated: true)
//        //        dump(ingredients)
//    }
//    //MARK: - Functions
//    private func loadSearchData() {
//        searchView.ingredientsTblView.dataSource = self
//        searchView.ingredientsTblView.delegate = self
//        searchView.ingredientTextField.delegate = self
//    }
//
//
//    //MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(searchView)
//        loadSearchData()
//        searchView.findRecipesButton.addTarget(self, action: #selector(findRecipeButtonPressed), for: .touchUpInside)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        self.navigationController?.navigationBar.isHidden = false
//    }
//}
//
////MARK: - Extensions
//extension SearchRecipesVC: UITextFieldDelegate {
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        searchView.ingredientTextField.clearsOnBeginEditing = true
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchView.ingredientTextField.resignFirstResponder()
//        let ingredient = searchView.ingredientTextField.text
//        ingredients.append(ingredient ?? "Not Found")
//        searchView.ingredientTextField.text = ""
//        return true
//    }
//}
//
//extension SearchRecipesVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ingredients.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = searchView.ingredientsTblView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
//        cell.textLabel?.text = ingredients[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deselect = UITableViewRowAction(style: .destructive, title: "X") { [weak self] (action, indexPath) in
//            self?.ingredients.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//        return [deselect]
//    }
//}

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
    
    //MARK: - OBJC Functions
    @objc func findRecipeButtonPressed(_ sender: UIButton) {
        let inputIngredients = ingredients
        guard !inputIngredients.isEmpty else {
            showAlert(title: "Required Input", message: "Please enter 2 or more ingredients")
            return
        }
        
        let findRecipeVC = RecipesCollResultsVC.fromSearchVC(ingredients: inputIngredients)
        navigationController?.pushViewController(findRecipeVC, animated: true)
        //        dump(ingredients)
    }
    
    //MARK: - Functions
    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
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
