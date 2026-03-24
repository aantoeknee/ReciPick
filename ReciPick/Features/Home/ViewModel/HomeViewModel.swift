//
//  HomeViewModel.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import Combine


@MainActor
class HomeViewModel: ObservableObject {
    
    // Publishers
    @Published var searchKey: String = .empty
    @Published var hasError: Bool = false
    @Published var dietaryAttributes: [DietaryAttribute] = []
    @Published var featuredRecipes: [Recipe] = []
    @Published var selectedAttribute: DietaryAttribute = .all
    
    @Published var recipes: [Recipe] = [] // model that will be used in the view
    @Published var originalRecipes: [Recipe] = [] // original or raw data from response. (without filters)
    @Published var query = FilterSearchQueryModel() {
        didSet {
            hasFilter = query.isVegetarian == true
            || !query.ingredients.isEmpty
            || query.includeInstructionSearch == true
            || query.minServings > 1
            || query.maxServings < 10
        }
    }
    @Published var hasFilter = false
    
    // Private variables
    private let repository: RecipeRepositoryProtocol
    private var appState: AppState?
    private var cancellables = Set<AnyCancellable>()
    private var isSearching: Bool = false
    
    
    // Public variables
    var hasInitiallyLoaded = false
    var errorMessage: String? {
        didSet {
            hasError = errorMessage != nil
        }
    }
    
    init(repository: RecipeRepositoryProtocol? = nil) {
        self.repository = repository ?? RecipeRepository()
        self.initFilterListeners()
    }
}


// MARK: - Public Functions
extension HomeViewModel {
    func setAppState(_ appState: AppState) {
        self.appState = appState
    }
    
    func loadRecipes() async {
        appState?.isLoading = true
        
        defer {
            appState?.isLoading = false
            
            // flag if recipes are already loaded for the first time
            // this is to avoid .task in HomeView to always call loadRecipes.
            hasInitiallyLoaded = true
        }
        
        do {
            let loadedRecipes = try await repository.loadRecipes()
            self.originalRecipes = loadedRecipes
            self.recipes = loadedRecipes
            self.extractDietaryList()
            self.extractFeaturedRecipes()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func searchFilter(query: FilterSearchQueryModel) async {
        
        var finalQuery = query
        finalQuery.searchText = searchKey
        
        // assign current attribute as vegetarian if vegetarian is toggled in filter view.
        selectedAttribute = finalQuery.isVegetarian ? .vegetarian : query.attribute
        
        finalQuery.attribute = selectedAttribute
        self.query = finalQuery
        
        appState?.isLoading = true
        isSearching = true
        defer {
            appState?.isLoading = false
            isSearching = false
        }
        
        do {
            let loadedRecipes = try await repository.searchRecipes(query: finalQuery)
            self.recipes = loadedRecipes
            self.extractFeaturedRecipes()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

// MARK: - Private Functions
extension HomeViewModel {
    
    // extract dietry attributes from retrieved recipes.
    // this will be used on the horizontal dietary attribute chips.
    private func extractDietaryList() {
        let attributes = recipes.flatMap { recipe in
            recipe.dietaryAttributes
        }
        dietaryAttributes = Array(Set(attributes))
        dietaryAttributes = dietaryAttributes.sorted { $0.rawValue < $1.rawValue }
        
        // Add "All" category in the dietary attribute chips.
        dietaryAttributes.insert(.all, at: 0)
    }
    
    
    // extract feature recipes. this will be used on the horizontal featured list in HomeView.
    private func extractFeaturedRecipes() {
        featuredRecipes = recipes.filter { $0.isFeatured }
    }
    
    // listener for change in dietary attribute chips
    private func initFilterListeners() {
        $selectedAttribute
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .removeDuplicates { $0 == $1 }
            .sink { [weak self] selectedAttribute in
                guard let self, self.hasInitiallyLoaded else { return }
                
                self.query.attribute = selectedAttribute
                self.query.isVegetarian = selectedAttribute == .vegetarian
                
                Task {
                    await self.searchFilter(query: self.query)
                }
            }
            .store(in: &cancellables)
    }
    
    private func reloadFeaturedRecipes() {
        featuredRecipes = recipes.filter { $0.isFeatured }
    }
}
