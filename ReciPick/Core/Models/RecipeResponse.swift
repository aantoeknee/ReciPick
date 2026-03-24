//
//  RecipeResponse.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import UIKit

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let servings: Int
    let isFeatured: Bool
    let imageUrl: String
    var ingredients: [Ingredient] = []
    let instructions: [String]
    let dietaryAttributes: [DietaryAttribute]
    
}

struct Ingredient: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let amount: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case amount
    }
}

enum DietaryAttribute: String, Codable, Hashable, Equatable {
    case all = "All"
    case highProtein = "High Protein"
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case dairyFree = "Dairy-Free"
    case glutenFree = "Gluten-Free"

    var bgColor: UIColor {
        switch self {
        case .all:
            return UIColor(hex: "FFF3E0")
        case .highProtein:
            return UIColor(hex: "FFF3E0")
        case .vegetarian:
            return UIColor(hex: "E8F5E2")
        case .vegan:
            return UIColor(hex: "E0F2E9")
        case .dairyFree:
            return UIColor(hex: "E3F2FD")
        case .glutenFree:
            return UIColor(hex: "FFF8E1")
        }
    }
}
