//
//  SavedRecipeView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct SavedRecipeView: View {
    
    @EnvironmentObject var viewModel: SavedRecipeViewModel
    @Binding var path: NavigationPath
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 18) {
                    NavigationBarView(title: "Saved Recipes")
                    
                    SearchBarView(searchText: $viewModel.searchText, hasFilter: .constant(false))
                    
                    if viewModel.hasNoResults {
                        EmptyView(text: viewModel.emptyStateTitle)
                            .frame(maxWidth: .infinity)
                            .frame(height: geo.size.height * 0.6)
                    } else {
                        LazyVStack {
                            ForEach(viewModel.savedRecipes) { recipe in
                                Button {
                                    path.append(recipe)
                                } label: {
                                    SavedRecipeCardView(recipe: recipe)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .navigationTitle("Saved Recipes")
            .background(Color(uiColor: .secondarySystemBackground))
        }
    }
}
#Preview {
    SavedRecipeView(path: .constant(NavigationPath()))
        .environmentObject(SavedRecipeViewModel())
}
