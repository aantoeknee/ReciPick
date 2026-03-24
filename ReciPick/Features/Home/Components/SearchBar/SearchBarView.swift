//
//  SearchBarView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @Binding var hasFilter: Bool
    
    var showFilterButton: Bool = false
    var didTapFilter: (() -> Void)?
    var onCommit: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search recipes...", text: $searchText) {
                        self.onCommit?()
                    }
                    .submitLabel(.search)
                }
                .padding(12)
                .overlay (
                    RoundedRectangle(cornerRadius: 27)
                        .stroke(Color.gray)
                )
                .clipShape(RoundedRectangle(cornerRadius: 27))
                
                if showFilterButton {
                    SearchFilterButtonView(hasFilter: $hasFilter) {
                        didTapFilter?()
                    }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 27))
        }
    }
}

#Preview {
    SearchBarView(searchText: .constant(.empty), hasFilter: .constant(false), onCommit: {})
}
    
