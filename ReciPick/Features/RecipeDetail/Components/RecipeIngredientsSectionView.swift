//
//  RecipeIngredientsSectionView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct RecipeIngredientsSectionView: View {
    
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("Ingredients")
                    .font(.system(size: 20, weight: .semibold))
                
                Spacer()
                
                .foregroundStyle(.black)
            }
            LazyVStack(alignment: .leading) {
                let ingredients = recipe.ingredients
                ForEach(ingredients) { ingredient in
                    VStack {
                        HStack {
                            Circle()
                                .foregroundStyle(Color.orange)
                                .frame(width: 10, height: 10)
                            Text(ingredient.name)
                            Spacer()
                            Text(ingredient.amount)
                                .foregroundStyle(.gray)
                        }
                        
                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeIngredientsSectionView(recipe: Recipe(
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
