//  Recipes.swift
//  RecipeMatcher


import Foundation
struct Recipe: Codable {
    struct Hits: Codable {
        let recipe: RecipeWrapper
    }
    let hits: [Hits]
}

struct RecipeWrapper: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Double
    let dietLabels: [String]
    let healthLabels: [String]
    let ingredientLines: [String]
    let calories: Double
    let totalWeight: Double
    let totalTime: Int
}