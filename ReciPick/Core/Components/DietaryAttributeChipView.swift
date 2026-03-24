//
//  FeaturedDietaryAttributeChipView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import SwiftUI

struct DietaryAttributeChipView: View {
    
    let attribute: DietaryAttribute
    
    var body: some View {
        Text(attribute.rawValue)
            .font(.system(size: 14, weight: .medium))
            .frame(height: 20)
            .padding(.horizontal, 8)
            .background(
                Color(uiColor: attribute.bgColor)
            )
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(Color.black.opacity(0.1), lineWidth: 2)
            }
    }
}

#Preview {
    DietaryAttributeChipView(attribute: .vegan)
}
