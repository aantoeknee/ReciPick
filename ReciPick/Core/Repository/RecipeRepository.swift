//
//  HomeRepository.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import Combine

protocol RecipeRepositoryProtocol {
    func loadRecipes() async throws -> [Recipe]
    func searchRecipes(query: FilterSearchQueryModel) async throws -> [Recipe]
}

class RecipeRepository: RecipeRepositoryProtocol {
    
    func loadRecipes() async throws -> [Recipe] {
        try? await Task.sleep(for: .milliseconds(100)) // to mimic api call
        
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json")
        else { return [] }
        
        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)

        return response.recipes
    }
    
    func searchRecipes(query: FilterSearchQueryModel) async throws -> [Recipe] {
        try? await Task.sleep(for: .milliseconds(100)) // to mimic api call
        
        let all = try await loadRecipes()

        return all
            .filter { recipe in
                switch query.attribute {
                case .all:
                    return true
                default:
                    return recipe.dietaryAttributes.contains(query.attribute)
                }
            }
            .filter { recipe in
                guard query.isVegetarian else { return true }
                return recipe.dietaryAttributes.contains(.vegetarian)
            }
            .filter { recipe in
                let min = recipe.servings >= query.minServings
                let max = recipe.servings <= query.maxServings
                return min && max
            }
            .filter { recipe in
                guard !query.ingredients.isEmpty else { return true }
                
                let includeNames = query.ingredients
                    .filter { $0.type == .include }
                    .compactMap { $0.name.lowercased() }
                
                let excludeNames = query.ingredients
                    .filter { $0.type == .exclude }
                    .compactMap { $0.name.lowercased() }
                
                
                let includes = recipe.ingredients.contains { ingredient in
                    guard !includeNames.isEmpty else { return true }
                    let words = ingredient.name
                        .lowercased()
                        .split(separator: " ")
                        .map(String.init)
                    
                    return includeNames.contains { inc in
                        words.contains(inc.lowercased())
                    }
                }
                
                let excludes = !recipe.ingredients.contains { ingredient in
                    guard !excludeNames.isEmpty else { return false }
                    let words = ingredient.name
                        .lowercased()
                        .split(separator: " ")
                        .map(String.init)
                    
                    return excludeNames.contains { exc in
                        words.contains(exc.lowercased())
                    }
                }
                
                return includes && excludes
            }
            .filter { recipe in
                guard !query.searchText.isEmpty else { return true }
                let searchKey = query.searchText.lowercased()
                let instructions = recipe.instructions.joined(separator: " ").lowercased()
                let title = recipe.title.lowercased()
                let description = recipe.description.lowercased()
                
                let inTitle = title.contains(searchKey)
                let inDescription = description.contains(searchKey)
                let inInstructions = query.includeInstructionSearch && instructions.contains(searchKey)
                
                return inTitle || inDescription || inInstructions
            }
    }
}
