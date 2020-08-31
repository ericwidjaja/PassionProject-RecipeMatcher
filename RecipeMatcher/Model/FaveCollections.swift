//  FaveCollections.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/10/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation

struct FaveCollections: Codable {
    let recipeType: String
    var recipes: [RecipeWrapper]
    
    init(recipeType: String, recipes: [RecipeWrapper])
    {
        self.recipeType = recipeType
        self.recipes = recipes
    }
}
