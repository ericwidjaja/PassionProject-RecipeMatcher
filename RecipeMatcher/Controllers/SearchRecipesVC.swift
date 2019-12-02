//  SearchRecipesVC.swift

//import UIKit
//class SearchRecipesVC : UIViewController {
//
//    var recipes = [RecipeWrapper]()
//    var ingredients = [String]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.fridgeTableView.reloadData()
//            }
//        }
//    }
//
//    @IBOutlet weak var fridgeTxtField: UITextField!
//    @IBOutlet weak var fridgeTableView: UITableView!
//    @IBOutlet weak var searchRecipeButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .orange
//
//        updateUI()
//        updateData()
//
//    }
//
//    private func updateData() {
//        fridgeTableView.dataSource = self
//        fridgeTableView.delegate = self
//        fridgeTxtField.delegate = self
//
//    }
//
//    private func updateUI() {
//        searchRecipeButton.layer.cornerRadius = 15
//        fridgeTableView.layer.cornerRadius = 10
//    }
//
//    @IBAction func searchButtonPressed(_ sender: UIButton) {
//        print("write more code to show CollectionVC")
//    }
//}
//
//MARK: Extensions
//extension SearchRecipesVC: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ingredients.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = fridgeTableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
//        cell.textLabel?.text = ingredients[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//
//}
//
//extension SearchRecipesVC: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        let ingredient = fridgeTxtField.text
//        ingredients.append(ingredient ?? "Not Found")
//        fridgeTxtField.text = ""
//        return true
//    }
//}
//
import UIKit
import Foundation

class SearchRecipesVC : UIViewController {

    var searchIngredient = SearchView()
    
    
 

//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchIngredient)

    }
}
