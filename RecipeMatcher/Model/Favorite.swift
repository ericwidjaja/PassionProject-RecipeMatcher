//  Favorite.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/1/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation
import FirebaseFirestore

struct Favorite {
    let id: String
    let creatorID: String
    let dateCreated: Date?
    let faveId: String
    let recipe: RecipeWrapper
    
    //create locally
    init(creatorID: String,
         dateCreated: Date? = nil,
         faveId: String,
         recipe: RecipeWrapper)
    {
        self.id = UUID.init().description
        self.creatorID = creatorID
        self.dateCreated = dateCreated
        self.faveId = faveId
        self.recipe = recipe
    }
    
    //create remotely
    init?(from dict: [String: Any], id: String)
    {
        guard let userID = dict["creatorID"] as? String,
            let recipeWrapper = dict ["recipe"] as? [String: Any],
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue(),
            let faveId = dict["faveId"] as? String
            else { return nil }
        self.id = id
        self.creatorID = userID
        self.faveId = faveId
        self.dateCreated = dateCreated
        self.recipe = RecipeWrapper(from: recipeWrapper)!
    }
    
    var fieldsDict: [String: Any] {
        return [
            "creatorID": self.creatorID,
            "faveId": self.faveId as Any,
            "dateCreated": self.dateCreated as Any, 
            "recipe": self.recipe.fieldsDict
        ]
    }
}
