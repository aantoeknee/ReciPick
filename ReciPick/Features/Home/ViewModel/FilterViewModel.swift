//
//  FilterViewModel.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import Combine
import Foundation

class FilterViewModel: ObservableObject {

    @Published var query: FilterSearchQueryModel
    
    var applyFilters: ((FilterSearchQueryModel) -> Void)?
    
    init(query: FilterSearchQueryModel = FilterSearchQueryModel()) {
         self.query = query
     }

}

// MARK: - Public functions
extension FilterViewModel {
    
    func didTapApplyFilters() {
        applyFilters?(query)
    }
    
    func clearFilters() {
        query = FilterSearchQueryModel()
        didTapApplyFilters()
    }
}
