//  RecipesCollResultsVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/11/19.
import UIKit

class RecipesCollResultsVC: UIViewController {
    //MARK: - Properties
    var recipesCollView = RecipeCollView()
    var recipeCellView = RecipesCollViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)

        // Do any additional setup after loading the view.
    }
}
