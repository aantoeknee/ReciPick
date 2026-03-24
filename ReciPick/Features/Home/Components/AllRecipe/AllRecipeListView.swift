//
//  AllRecipeView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/22/26.
//

import SwiftUI

struct AllRecipeListView: View {
    
    let allRecipes: [Recipe]
    var didSelect: ((Recipe) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Recipes")
                .font(.system(size: 24, weight: .semibold))
            
            LazyVStack(spacing: 12) {
                ForEach(allRecipes.indices, id: \.self) { index in
                    let recipe = allRecipes[index]
                    VStack {
                        Button {
                            didSelect?(recipe)
                        } label: {
                            AllRecipeRowView(recipe: recipe)
                        }
                        .buttonStyle(.plain)
                        
                        if index != allRecipes.count - 1 {
                            Divider()
                        }
                    }
                }
            }
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .foregroundStyle(Color.white)
            )
        }
    }
}

#Preview {
    AllRecipeListView(allRecipes: [Recipe(
        id: .empty,
        title: "Pancake",
        description: "A yummu pancake",
        servings: 3,
        isFeatured: true,
        imageUrl: .empty,
        instructions: [],
        dietaryAttributes: [])
    ])
}
