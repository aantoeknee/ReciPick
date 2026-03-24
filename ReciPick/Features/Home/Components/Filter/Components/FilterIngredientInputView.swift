//
//  FilterIngredientInputView.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/23/26.
//

import SwiftUI

struct FilterIngredientInputView: View {
    
    @State var addedIngredient: String = .empty
    var didAddIngredient: ((FilterIngredientModel) -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add ingredient..", text: $addedIngredient)
                    .padding(8)
                    .background {
                        Rectangle()
                            .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack(spacing: 0) {
                    Group {
                        Button {
                            print("did tap include \(addedIngredient)")
                            let ingredient = FilterIngredientModel(name: addedIngredient, type: .include)
                            didAddIngredient?(ingredient)
                            addedIngredient = .empty
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        
                        Button {
                            print("did tap exclude \(addedIngredient)")
                            let ingredient = FilterIngredientModel(name: addedIngredient, type: .exclude)
                            didAddIngredient?(ingredient)
                            addedIngredient = .empty
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.orange)
                    .disabled(addedIngredient.isEmpty)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    FilterIngredientInputView()
}
