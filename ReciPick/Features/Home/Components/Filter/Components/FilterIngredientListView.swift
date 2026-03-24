//
//  FilterIngredientListView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct FilterIngredientListView: View {
    
    @Binding var selectedIngredients: [FilterIngredientModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // sticky header
            HStack {
                Text("Include")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Exclude")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 8)
            .background(Color(.systemBackground))

            // content
            ScrollView {
                HStack(alignment: .top, spacing: 12) {
                    // Include column
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(
                            selectedIngredients.filter { $0.type == .include },
                            id: \.self
                        ) { item in
                            FilterIngredientChipView(ingredient: item) { ingredient in
                                selectedIngredients.removeAll { $0 == ingredient }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Rectangle()
                        .fill(Color(.separator))
                        .frame(width: 0.5)
                        .frame(maxHeight: .infinity)

                    // Exclude column
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(
                            selectedIngredients.filter { $0.type == .exclude },
                            id: \.self
                        ) { item in
                            FilterIngredientChipView(ingredient: item) { ingredient in
                                selectedIngredients.removeAll { $0 == ingredient }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 4)
            }
            .frame(height: 120)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    FilterIngredientListView(
        selectedIngredients: .constant([
            FilterIngredientModel(name: "Milk", type: .exclude),
            FilterIngredientModel(name: "Egg", type: .exclude)
        ])
    )
}
