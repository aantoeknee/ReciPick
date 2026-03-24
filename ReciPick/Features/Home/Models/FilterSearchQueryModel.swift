//
//  FilterSearchQueryModel.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import Foundation

struct FilterSearchQueryModel: Equatable {
    var searchText: String = .empty
    var attribute: DietaryAttribute = .all
    var isVegetarian: Bool = false
    var minServings: Int = 1
    var maxServings: Int = 10
    var ingredients: [FilterIngredientModel] = []
    var includeInstructionSearch: Bool = false
}
