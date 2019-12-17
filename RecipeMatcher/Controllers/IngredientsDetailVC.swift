//
//  IngredientsDetailVC.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 12/16/19.
//  Copyright © 2019 Eric W. All rights reserved.
//

import UIKit

class IngredientsDetailVC: UIViewController {
    
    var recipe: RecipeWrapper!
    var detailIngredients = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.detailIngredients.loadingActivity.isHidden = false
        self.detailIngredients.loadingActivity.startAnimating()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
