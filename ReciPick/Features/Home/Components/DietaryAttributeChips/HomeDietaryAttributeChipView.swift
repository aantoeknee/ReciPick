//
//  DietaryAttributeChipView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import SwiftUI

struct HomeDietaryAttributeChipView: View {
    
    let attribute: DietaryAttribute
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(attribute.rawValue)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color(uiColor: attribute.bgColor))
        .cornerRadius(20)
        .overlay {
            Capsule()
                .stroke(Color.black.opacity(isSelected ? 0.5: 0.1), lineWidth: 2)
        }
    }
}

#Preview {
    HomeDietaryAttributeChipView(attribute: .all, isSelected: true)
}
