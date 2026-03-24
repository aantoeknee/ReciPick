//
//  HomeView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var filterViewModel = FilterViewModel()
    @Binding var path: NavigationPath
    
    @State var showFilterView: Bool = false
    
    var body: some View {
        ZStack {
            content
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .background(Color(uiColor: .secondarySystemBackground))
        .onAppear {
            viewModel.setAppState(appState)
            // handling of filters
            filterViewModel.applyFilters = { query in
                Task {
                    await viewModel.searchFilter(query: query)
                }
            }
        }
        .onChange(of: viewModel.query) { oldValue, newValue in
            filterViewModel.query = newValue
        }
        .task {
            guard !viewModel.hasInitiallyLoaded else { return }
            await viewModel.loadRecipes()
        }
        .refreshable {
            await viewModel.loadRecipes()
        }
        .alert("Something went wrong", isPresented: $viewModel.hasError) {
            Button("Okay") {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? .empty)
        }
        .sheet(isPresented: $showFilterView) {
            FilterView(viewModel: filterViewModel)
        }
    }
    
    private var content: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    NavigationBarView(title: "ReciPick")
                    
                    SearchBarView(
                        searchText: $viewModel.searchKey,
                        hasFilter: $viewModel.hasFilter,
                        showFilterButton: true) {
                            showFilterView.toggle()
                        } onCommit: {
                            Task { await viewModel.searchFilter(query: viewModel.query) }
                        }

                    
                    Divider().background(Color.black)
                    
                    // Dietary Chips
                    HomeDietaryAttributeChipListView(
                        dietaryAttributes: viewModel.dietaryAttributes,
                        selectedAttribute: $viewModel.selectedAttribute
                    )
                    
                    // Featured List
                    if !viewModel.featuredRecipes.isEmpty {
                        HorizontalFeaturedListView(featuredRecipes: viewModel.featuredRecipes) { recipe in
                            path.append(recipe)
                        }
                    }
                    
                    // All Recipe
                    if !viewModel.recipes.isEmpty {
                        AllRecipeListView(allRecipes: viewModel.recipes) { recipe in
                            path.append(recipe)
                        }
                    }
                    
                    if viewModel.featuredRecipes.isEmpty && viewModel.recipes.isEmpty {
                        EmptyView(text: "No results found")
                            .frame(maxWidth: .infinity)
                            .frame(height: geo.size.height * 0.5)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 8)
            }
            .scrollDismissesKeyboard(.immediately)
        }
    }
}

#Preview {
    HomeView(path: .constant(NavigationPath()))
}
