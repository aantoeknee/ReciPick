//
//  BottomTabBarView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import SwiftUI

enum TabBarView: String, CaseIterable, Identifiable {
    case home, saved
    
    var id: Self { self }
    
    var icon: Image {
        switch self {
        case .home:
            return Image(systemName: "house")
        case .saved:
            return Image(systemName: "heart")
        }
    }
}

struct BottomTabBarView: View {
    
    @Binding var currentTab: TabBarView
    private let tabs = TabBarView.allCases
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                Button {
                    currentTab = tab
                } label: {
                    VStack(spacing: 6) {
                        tab.icon
                        Text(tab.rawValue.uppercased())
                            .font(.system(size: 12))
                    }
                    .foregroundStyle(currentTab == tab ? .orange : .black)
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 8)
    }
}

#Preview {
    BottomTabBarView(currentTab: .constant(.home))
}
