//
//  LoadingView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/22/26.
//

import SwiftUI

struct LoadingView: View {
    
    var loadingMessage: String = "Loading..."
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            
            ProgressView(loadingMessage)
                .padding()
                .background(
                    Color.white
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
