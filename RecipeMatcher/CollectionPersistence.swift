//  CollectionPersistence.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/10/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation

class CollectionPersistence {
    private init() {}
    static let manager = CollectionPersistence()
    private let persistanceHelper = PersistenceHelper<CookbookCollections>.init(fileName: "FaveCollections.plist")
    
    func save(newElement: CookbookCollections) throws {
        try persistanceHelper.save(newElement: newElement)
    }
    
    func replace(newArr: [CookbookCollections]) throws {
        try persistanceHelper.replace(arrOfElements: newArr)
    }
    
    func getRecipe() throws -> [CookbookCollections] {
        return try persistanceHelper.getObjects()
    }
}
