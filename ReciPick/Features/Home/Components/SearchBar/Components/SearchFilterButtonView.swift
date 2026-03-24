//
//  SearchFilterButtonView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/24/26.
//

import SwiftUI

struct SearchFilterButtonView: View {
    
    @Binding var hasFilter: Bool
    
    var didTapFilter: (() -> Void)?
    
    var body: some View {
        Button {
            print("did tap filter")
            didTapFilter?()
        } label: {
            ZStack {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray)
                    .clipShape(Circle())
                
                if hasFilter {
                    Circle()
                        .foregroundStyle(.blue)
                        .frame(width: 10, height: 10)
                        .offset(x: 8, y: -8)
                }
            }
        }
        .buttonStyle(.plain)
        .contentShape(Capsule())
    }
}

#Preview {
    SearchFilterButtonView(hasFilter: .constant(false))
}
