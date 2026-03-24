//
//  HomeDietaryAttributeChipListView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import SwiftUI

struct HomeDietaryAttributeChipListView: View {
    
    let dietaryAttributes: [DietaryAttribute]
    @Binding var selectedAttribute: DietaryAttribute
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(dietaryAttributes, id: \.self) { attribute in
                    Button {
                        selectedAttribute = attribute
                    } label: {
                        HomeDietaryAttributeChipView(
                            attribute: attribute,
                            isSelected: selectedAttribute == attribute
                        )
                    }
                    .buttonStyle(.plain)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 2)
        }
        .padding(.horizontal, -14)
        .contentMargins(.horizontal, 14, for: .scrollContent)
    }
}

#Preview {
    HomeDietaryAttributeChipListView(
        dietaryAttributes: [],
        selectedAttribute: .constant(.all)
    )
}
