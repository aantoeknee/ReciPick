//
//  FilterView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import Foundation
import SwiftUI

struct FilterView: View {
    
    @ObservedObject var viewModel: FilterViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            List {
                // isVegetarian toggle
                Section("Dietary") {
                    Toggle("Vegetarian Only", isOn: $viewModel.query.isVegetarian)
                }
                
                
                // min and max servings
                Section("Servings") {
                    VStack(spacing: 20) {
                        Stepper(
                            "Min: \(viewModel.query.minServings)",
                            value: $viewModel.query.minServings,
                            in: 1...10
                        )
                        Stepper(
                            "Max: \(viewModel.query.maxServings)",
                            value: $viewModel.query.maxServings,
                            in: viewModel.query.minServings...10
                        )
                    }
                }
                
                // include/exclude ingredients
                Section("Ingredients") {
                    FilterIngredientsView(selectedIngredients: $viewModel.query.ingredients)
                }
                
                // include instruction when searching in search bar
                Section("Instructions") {
                    Toggle("Search in steps", isOn: $viewModel.query.includeInstructionSearch)
                }
            }
            
            
            // bottom buttons
            VStack {
                Button {
                    viewModel.didTapApplyFilters()
                    dismiss()
                } label: {
                    Text("Apply Filters")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background {
                            RoundedRectangle(cornerRadius: 18)
                                .foregroundStyle(.orange)
                        }
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 12)
                
                Button {
                    viewModel.clearFilters()
                    dismiss()
                } label: {
                    Text("Clear filters")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.orange)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 12)
                .disabled(viewModel.query == FilterSearchQueryModel())
            }
        }
        .padding(.vertical, 20)
        .background(Color(uiColor: .secondarySystemBackground))
    }
}

#Preview {
    FilterView(viewModel: FilterViewModel(query: FilterSearchQueryModel()))
}
