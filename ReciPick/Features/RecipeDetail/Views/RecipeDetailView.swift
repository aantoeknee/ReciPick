//
//  RecipeDetailView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/22/26.
//

import Kingfisher
import SwiftUI

struct RecipeDetailView: View {
    
    @EnvironmentObject var savedRecipeViewModel: SavedRecipeViewModel
    @ObservedObject var viewModel: RecipeDetailViewModel
    
    @State var imageHeight: CGFloat = 300.0
    
    var body: some View {
        content
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .secondarySystemBackground))
            .ignoresSafeArea(edges: .top)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        savedRecipeViewModel.toggleFavorite(viewModel.recipe)
                    } label: {
                        Image(systemName: savedRecipeViewModel.isSaved(viewModel.recipe) ? "heart.fill": "heart" )
                            .foregroundStyle(savedRecipeViewModel.isSaved(viewModel.recipe) ? .red : .black)
                    }
                }
            }
    }
    
    
    @ViewBuilder
    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                // Header Image
                GeometryReader { geo in
                    AsyncImage(url: URL(string: viewModel.recipe.imageUrl)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(
                        width: geo.size.width,
                        height: geo.size.width * 0.8
                    )
                    .clipped()
                }
                .onGeometryChange(for: CGFloat.self, of: { geo in
                    geo.size.width * 0.8
                }, action: { newValue in
                    imageHeight = newValue
                })
                .frame(maxWidth: .infinity, minHeight: imageHeight)
                
                // Dietary Attribute Chips
                DietaryAttributeListView(dietaryAttributes: viewModel.recipe.dietaryAttributes)
                
                // Title & Description
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.recipe.title)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.primary)
                    Text(viewModel.recipe.description)
                        .foregroundStyle(.secondary)
                    
                    // # of servings, ingredients and instructions
                    RecipeAmountsSectionView(recipe: viewModel.recipe)
                    
                    // ingredients
                    RecipeIngredientsSectionView(recipe: viewModel.recipe)
                        .padding(.top, 10)
                    
                    // instructions
                    RecipeInstructionsSectionView(instructions: viewModel.recipe.instructions)
                        .padding(.top, 10)
                }
                .padding(.horizontal, 18)
                .padding(.top, -8)
            }
        }
    }
}

#Preview {
    RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: Recipe(
        id: .empty,
        title: "Pancake",
        description: "A light, colorful pasta loaded with seasonal vegetables and a bright lemon-garlic sauce.",
        servings: 3,
        isFeatured: true,
        imageUrl: "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800",
        ingredients: [.init(name: "Milk", amount: "100g")],
        instructions: [],
        dietaryAttributes: [.vegan, .vegetarian]))
    )
    .environmentObject(SavedRecipeViewModel())
}
