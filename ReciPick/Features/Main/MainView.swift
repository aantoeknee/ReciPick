//
//  MainView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var appState = AppState()
    @StateObject var savedRecipeViewModel = SavedRecipeViewModel()
    
    @State var selectedTab: TabBarView = .home
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                ZStack {
                    HomeView(path: $path).opacity(getOpacity(.home))
                    SavedRecipeView(path: $path).opacity(getOpacity(.saved))
                }
                Divider()
                BottomTabBarView(currentTab: $selectedTab)
            }
            .ignoresSafeArea(.keyboard)
            .overlay {
                if appState.isLoading {
                    LoadingView()
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
                    .environmentObject(savedRecipeViewModel)
            }
            .environmentObject(appState)
            .environmentObject(savedRecipeViewModel)
        }
    }
}


// Private Functions
extension MainView {
    private func getOpacity(_ tab: TabBarView) -> CGFloat {
        return selectedTab == tab ? 1 : 0
    }
}

#Preview {
    MainView()
}
