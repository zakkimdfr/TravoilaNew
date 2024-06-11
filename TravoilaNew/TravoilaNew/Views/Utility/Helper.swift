//
//  Helper.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 10/06/24.
//

import SwiftUI

extension View{
    func applyBG() -> some View{
        self
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

enum Tab: String, CaseIterable{
    case home = "Home"
    case lable = "Label"
    case position = "Position"
    case found = "Found"
    case my = "My"
}
