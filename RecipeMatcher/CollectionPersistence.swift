//  CollectionPersistence.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/10/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation

class CollectionPersistence {
    private init() {}
    static let manager = CollectionPersistence()
    private let persistanceHelper = PersistenceHelper<CookbookCollection>.init(fileName: "CkbkCollection.plist")
    
    func save(newElement: CookbookCollection) throws {
        try persistanceHelper.save(newElement: newElement)
    }
    
    func replace(newArr: [CookbookCollection]) throws {
        try persistanceHelper.replace(arrOfElements: newArr)
    }
    
    func getRecipe() throws -> [CookbookCollection] {
        return try persistanceHelper.getObjects()
    }
    
    func updateCollection(collection: CookbookCollection, index: Int) throws {
        do {
            try persistanceHelper.update(updatedElement: collection, indexToUpdate: index)
        }
    }
}
