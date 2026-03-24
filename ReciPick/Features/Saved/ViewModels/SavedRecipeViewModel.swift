//
//  SavedRecipeViewModel.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import Combine
import Foundation

class SavedRecipeViewModel: ObservableObject {
    
    @Published var originalSavedRecipes: [Recipe] = []
    @Published var savedRecipes: [Recipe] = []
    @Published var searchText: String = .empty
    
    // title for empty state
    var emptyStateTitle: String {
        if isSavedRecipeEmpty {
            return "No saved recipes"
        } else {
            return "No results found"
        }
    }
    
    var hasNoResults: Bool {
        return isSavedRecipeEmpty || isSearchedRecipeEmpty
    }
    
    private var isSavedRecipeEmpty: Bool {
        return originalSavedRecipes.isEmpty
    }
    
    private var isSearchedRecipeEmpty: Bool {
        return savedRecipes.isEmpty
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        initSearchListener()
    }
}

// MARK: - Public functions
extension SavedRecipeViewModel {
    
    // called when user taps heart/favorite button in recipe detail
    func toggleFavorite(_ selectedRecipe: Recipe) {
        if !savedRecipes.contains(selectedRecipe) {
            savedRecipes.append(selectedRecipe)
        } else {
            savedRecipes.removeAll { recipe in
               selectedRecipe == recipe
            }
        }
        originalSavedRecipes = savedRecipes
    }
    
    // checks if recipe is already saved
    func isSaved(_ recipe: Recipe) -> Bool {
        return originalSavedRecipes.contains(recipe)
    }
}

// MARK: - Private Functions
extension SavedRecipeViewModel {
    
    // listener for search bar
    func initSearchListener() {
        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchText in
                guard let self else { return }
                if searchText.isEmpty {
                    savedRecipes = originalSavedRecipes
                } else {
                    self.savedRecipes = originalSavedRecipes.filter { recipe in
                        recipe.title.lowercased().contains(searchText.lowercased())
                    }
                }
            }
            .store(in: &cancellables)
    }
}
