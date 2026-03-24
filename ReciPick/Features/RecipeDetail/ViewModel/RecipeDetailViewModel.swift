//
//  RecipeDetailViewModel.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/24/26.
//

import Combine
import Foundation

class RecipeDetailViewModel: ObservableObject {
    
    @Published var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
