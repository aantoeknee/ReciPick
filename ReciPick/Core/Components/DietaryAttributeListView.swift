//
//  FeaturedDietaryAttributeListView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import SwiftUI

struct DietaryAttributeListView: View {
    
    let dietaryAttributes: [DietaryAttribute]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(dietaryAttributes, id: \.self) { attributes in
                    DietaryAttributeChipView(attribute: attributes)
                }
            }
            .padding(.vertical, 1)
        }
        .contentMargins(.horizontal, 12, for: .scrollContent)
        .fixedSize(horizontal: false, vertical: true)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    DietaryAttributeListView(dietaryAttributes: [])
}
