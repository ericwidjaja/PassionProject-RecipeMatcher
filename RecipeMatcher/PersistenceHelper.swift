//  PersistenceHelper.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 8/10/20.
//  Copyright © 2020 Eric W. All rights reserved.

import Foundation

class PersistenceHelper<T: Codable> {
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func save(newElement: T) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func delete(num: Int) throws{
        var elements = try getObjects()
        elements.remove(at: num)
           let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func edit(num: Int, newElement: T) throws{
        var elements = try getObjects()
        elements[num] = newElement
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func replace(arrOfElements: [T]) throws {
        let serializedData = try PropertyListEncoder().encode(arrOfElements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    private let fileName: String
    
    private var url: URL {
        return filePathFromDocumentsDirectory(filename: fileName)
    }
    
    private func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func filePathFromDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
