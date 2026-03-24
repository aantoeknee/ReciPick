//
//  EmptyView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct EmptyView: View {
    
    var text: String = "No results found."
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "tray")
                .resizable()
                .frame(width: 60, height: 40)
            Text(text)
                .font(.system(size: 25, weight: .semibold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.clear)
    }
}

#Preview {
    EmptyView()
}
