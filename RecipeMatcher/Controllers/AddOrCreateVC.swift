//
//  AddOrCreateVC.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 6/27/20.
//  Copyright © 2020 Eric W. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth
import FirebaseFirestore

class AddOrCreateVC: UIViewController {
    
    //MARK: - Properties
    var addOrCreateView = AddOrCreateView()
    var recipe: RecipeWrapper?
    var detailRecipe = RecipeDetailView()
    var recipesCollView = RecipeCollView()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addOrCreateView)
        

    }
    
}
