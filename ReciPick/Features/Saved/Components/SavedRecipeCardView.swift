//
//  SavedRecipeCardView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import Kingfisher
import SwiftUI

struct SavedRecipeCardView: View {
    
    let recipe: Recipe
    
    var body: some View {
        VStack(spacing: 8) {
            // Image
            ZStack {
                Color(hex: "FFF6E0")
                KFImage(URL(string: recipe.imageUrl))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .clipped()
            
            VStack(alignment: .leading) {
                // dietry attributes
                DietaryAttributeListView(dietaryAttributes: recipe.dietaryAttributes)
            
                // title and servings
                VStack(alignment: .leading) {
                    Text(recipe.title)
                        .font(.system(size: 20, weight: .semibold))
                    Text(recipe.description)
                        .font(.subheadline)
                        .foregroundStyle(Color.black.opacity(0.6))
                }
                .lineLimit(1)
                .padding(.leading, 12)
                .padding(.bottom, 8)
            }
            .padding(4)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .contentShape(RoundedRectangle(cornerRadius: 14))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    SavedRecipeCardView(recipe: Recipe(
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
