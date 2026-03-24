//
//  NavigationBarView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import SwiftUI

struct NavigationBarView: View {
    var title: String = .empty
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 40, weight: .bold))
            Spacer()
        }
        .frame(height: 30)
        .padding(.bottom, 8)
    }
}

#Preview {
    NavigationBarView(title: "ReciPick")
}
