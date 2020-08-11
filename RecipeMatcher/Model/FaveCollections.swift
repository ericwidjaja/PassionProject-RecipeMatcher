//  FaveCollections.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/10/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation

struct FaveCollections: Codable {
    let recipeType: String
    let recipes: [RecipeWrapper]
    
    init?(from dict: [String: Any]) {
        guard let recipeType = dict["recipeType"] as? String,
            let recipes = (dict["recipes"] as? [[String: Any]]) else { return nil }
        self.recipeType = recipeType
        self.recipes = recipes.compactMap({RecipeWrapper(from: $0) })
    }
    var fieldsDict: [String: Any] {
        return [
            "recipeType": self.recipeType,
            "recipes": self.recipes.map({$0.fieldsDict})]
    }
    init(recipeType: String, recipes: [RecipeWrapper]) {
        self.recipeType = recipeType
        self.recipes = recipes
    }
}
