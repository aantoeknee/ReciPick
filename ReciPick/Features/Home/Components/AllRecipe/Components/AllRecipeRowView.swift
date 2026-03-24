//
//  AllRecipeRowView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/22/26.
//

import Kingfisher
import SwiftUI

struct AllRecipeRowView: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 16) {
            iconView
            
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
            
    }
    
    @ViewBuilder
    var iconView: some View {
        let imageUrl = URL(string: recipe.imageUrl)
        KFImage(imageUrl)
            .placeholder {
                ProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .background {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(Color(hex: "F2F2F7"))
        }
    }
}

#Preview {
    AllRecipeRowView(recipe: Recipe(
        id: .empty,
        title: "Pancake",
        description: "A light, colorful pasta loaded with seasonal vegetables and a bright lemon-garlic sauce.",
        servings: 3,
        isFeatured: true,
        imageUrl: "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800",
        ingredients: [.init(name: "Milk", amount: "100g")],
        instructions: [],
        dietaryAttributes: [.vegan, .vegetarian])    )
}
