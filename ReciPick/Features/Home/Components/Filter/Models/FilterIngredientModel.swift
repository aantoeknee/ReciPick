//
//  FilterIngredientModel.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import Foundation
import SwiftUI

struct FilterIngredientModel: Hashable {
    let name: String
    let type: FilterIngredientType
}

enum FilterIngredientType {
    case include
    case exclude
    
    
    var backgroundColor: String {
        switch self {
        case .include:
            return "E8F5E2"
        case .exclude:
            return "F08080"
        }
    }
}
