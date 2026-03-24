//
//  FilterIngredientsView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct FilterIngredientsView: View {
    
    @Binding var selectedIngredients: [FilterIngredientModel]

    var body: some View {
        VStack(alignment: .leading) {
            
            // ingredient input field
            FilterIngredientInputView { ingredient in
                selectedIngredients.append(ingredient)
            }
            
            // ingredient list
            FilterIngredientListView(selectedIngredients: $selectedIngredients)
        }
    }
}

#Preview {
    FilterIngredientsView(selectedIngredients: .constant([]))
}
