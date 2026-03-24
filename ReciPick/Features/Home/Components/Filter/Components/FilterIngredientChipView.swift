//
//  FilterIngredientChipView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct FilterIngredientChipView: View {
    
    let ingredient: FilterIngredientModel
    var didTapRemove: ((FilterIngredientModel) -> Void)?
    
    var body: some View {
        HStack(spacing: 4) {
            Text(ingredient.name.capitalized)
            
            Button {
                didTapRemove?(ingredient)
            } label: {
                Image(systemName: "x.circle")
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
        .background {
            Capsule()
                .foregroundStyle(Color(hex: ingredient.type.backgroundColor))
        }
    }
}

#Preview {
    FilterIngredientChipView(ingredient: .init(name: "Egg", type: .exclude))
}
