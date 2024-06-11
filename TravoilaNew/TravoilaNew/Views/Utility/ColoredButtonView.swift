//
//  ColoredButtonView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 08/06/24.
//

import SwiftUI

struct ColoredButtonView: View {
    let button:String
    
    var body: some View {
        Text(button)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 200, height: 50)
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.themeColor(.primary)))
    }
}

#Preview {
    ColoredButtonView(button: "Sign Out")
}
