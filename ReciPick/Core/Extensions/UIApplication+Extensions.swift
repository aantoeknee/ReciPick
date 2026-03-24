//
//  UIApplication+Extensions.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/21/26.
//

import Foundation
import SwiftUI

extension UIApplication {

    static var topSafeArea: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first?.safeAreaInsets.top ?? 44
    }
}
