//  APIClient.swift
//  RecipeMatcher

import Foundation

final class RecipeAPIClient {
    static func searchRecipes(keyword: String, completion: @escaping (AppError?, [RecipeWrapper]?) -> Void) {
        let endpointURLString = "https://api.edamam.com/search?q=\(keyword)&app_id=\(Secret.App_Id)&app_key=\(Secret.API_Key)&from=0&to=100"
        guard let url = URL(string: endpointURLString) else {
            print("bad url: \(endpointURLString)")
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(AppError.noDataReceived, nil)
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                    print("bad status code")
                    completion(AppError.badStatusCode, nil)
                    return
            }
            if let data = data {
                do {
                    let recipeSearch = try JSONDecoder().decode(Recipe.self, from: data)
                    let recipes = recipeSearch.hits.map { $0.recipe }
                    completion(nil, recipes)
                } catch {
                    completion(AppError.invalidJSONResponse, nil)
                }
            }
        }
        task.resume()
    }
}
