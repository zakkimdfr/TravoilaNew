//
//  Theme.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import Foundation
import SwiftUI

enum ThemeColor {
    case primary
}

extension Color {
    static func themeColor(_ theme: ThemeColor) -> Color {
        switch theme {
        case .primary:
            return Color(red: 94/255, green: 154/255, blue: 219/255)
        }
    }
}
