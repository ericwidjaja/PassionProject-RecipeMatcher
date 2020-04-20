//  ButtonProtocol.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/24/19.

import Foundation

protocol HeartButtonDelegate {
    func saveToPersistance(tag: Int)
    func deleteFromPersistance(tag: Int)
}
