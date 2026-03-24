//
//  RecipeAmountsSectionView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct RecipeAmountsSectionView: View {
    
    enum RecipeAmountType: String, CaseIterable, Identifiable {
        case servings, ingredients, instructions

        var id: String { rawValue }
    }
    
    let recipe: Recipe
    
    var body: some View {

        HStack {
            ForEach(RecipeAmountType.allCases) { item in
                VStack(spacing: 0) {
                    Group {
                        switch item {
                        case .servings:
                            Text("\(recipe.servings)")
                        case .ingredients:
                            Text("\(recipe.ingredients.count)")
                        case .instructions:
                            Text("\(recipe.instructions.count)")
                        }
                    }
                    .font(.system(size: 20, weight: .bold))
        
                    Text(item.rawValue.capitalized)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.gray)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color(hex: "FAF6EE"))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black.opacity(0.3), lineWidth: 1)
                        }
                )
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    RecipeAmountsSectionView(recipe: Recipe(
        id: .empty,
        title: "Pancake",
        description: "A light, colorful pasta loaded with seasonal vegetables and a bright lemon-garlic sauce.",
        servings: 3,
        isFeatured: true,
        imageUrl: "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800",
        ingredients: [.init(name: "Milk", amount: "100g")],
        instructions: [],
        dietaryAttributes: [.vegan, .vegetarian])
    )
}
