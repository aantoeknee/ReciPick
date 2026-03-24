//
//  AppState.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/22/26.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var isLoading: Bool = false // this controls the loading state of the app.
}
