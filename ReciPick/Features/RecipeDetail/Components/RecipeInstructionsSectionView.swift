//
//  RecipeInstructionsSectionView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct RecipeInstructionsSectionView: View {
    
    let instructions: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.system(size: 20, weight: .semibold))
            LazyVStack(alignment: .leading, spacing: 18) {
                ForEach(instructions.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            generateNumberView(index + 1)
                            Text(instructions[index])
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func generateNumberView(_ index: Int) -> some View {
        Text(index.description)
            .foregroundStyle(.white)
            .padding(12)
            .background {
                Circle()
                    .foregroundStyle(.orange)
            }
    }
}

#Preview {
    RecipeInstructionsSectionView(instructions: ["Boil salted water and cook pasta"])
}
