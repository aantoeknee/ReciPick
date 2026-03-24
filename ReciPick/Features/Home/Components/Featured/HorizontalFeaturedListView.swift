//
//  HorizontalFeaturedListView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import SwiftUI

struct HorizontalFeaturedListView: View {

    let featuredRecipes: [Recipe]
    var didSelect:((Recipe) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Featured")
                .font(.system(size: 24, weight: .semibold))
            ScrollView(.horizontal) {
                LazyHStack(spacing: 14) {
                    ForEach(featuredRecipes) { recipe in
                        Button {
                            didSelect?(recipe)
                        } label: {
                            FeaturedCardView(recipe: recipe)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.horizontal, -14)
            .contentMargins(.horizontal, 14, for: .scrollContent)
        }
    }
}

#Preview {
    HorizontalFeaturedListView(
        featuredRecipes: []
    )
}
