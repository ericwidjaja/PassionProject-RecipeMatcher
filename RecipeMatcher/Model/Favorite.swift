//  Favorite.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 1/1/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation
import FirebaseFirestore

struct Favorite {
    let id: String
    let creatorID: String
    let label: String
    let imageUrl: String?
    let dateCreated: Date?
    let url: String
    let ingredientLines: [String]
    let faveId: String
    
    //create locally
    init(creatorID: String,
         recipeTitle: String,
         imageUrl: String? = nil,
         dateCreated: Date? = nil,
         urlCookInst: String,
         ingredientLinesArr: [String],
         faveId: String)
    {
        self.id = UUID.init().description
        self.creatorID = creatorID
        self.label = recipeTitle
        self.imageUrl = imageUrl
        self.dateCreated = dateCreated
        self.url = urlCookInst
        self.ingredientLines = ingredientLinesArr
        self.faveId = faveId
    }
    //create remotely
    init?(from dict: [String: Any], id: String)
    {
        guard let userID = dict["creatorID"] as? String,
            let recipeTitle = dict["recipeTitle"] as? String,
            let imageUrl = dict["imageUrl"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue(),
            let urlCookInst = dict["urlCookInst"] as? String,
            let ingredientLinesArr = dict["ingredientLines"] as? [String],
            let faveId = dict["faveId"] as? String
            else { return nil }
        self.id = id
        self.creatorID = userID
        self.label = recipeTitle
        self.imageUrl = imageUrl
        self.dateCreated = dateCreated
        self.url = urlCookInst
        self.ingredientLines = ingredientLinesArr
        self.faveId = faveId
    }
    
    var fieldsDict: [String: Any] {
        return [
            
            "creatorID": self.creatorID,
            "recipeTitle": self.label,
            "imageUrl": self.imageUrl as Any,
            "urlCookInst": self.url,
            "ingredientLines": self.ingredientLines,
            "faveId": self.faveId as Any
        ]
    }
}
