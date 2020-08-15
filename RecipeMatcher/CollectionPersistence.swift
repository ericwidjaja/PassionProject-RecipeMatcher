//  CollectionPersistence.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/10/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation

class CollectionPersistence {
    private init() {}
    static let helper = CollectionPersistence()
    private let persistanceHelper = PersistenceHelper<FaveCollections>.init(fileName: "FaveCollections.plist")
    
    func save(newElement: FaveCollections) throws {
        try persistanceHelper.save(newElement: newElement)
    }
    func replace(newArr: [FaveCollections]) throws {
        try persistanceHelper.replace(arrOfElements: newArr)
    }
    
    func getRecipe() throws -> [FaveCollections] {
        return try persistanceHelper.getObjects()
    }
}
