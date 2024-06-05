//
//  ButtonView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 02/06/24.
//

import SwiftUI

struct ButtonView: View {
    let button: String
    var body: some View {
        Text(button)
            .frame(width: 357, height: 62)
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.white, lineWidth: 2))
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .padding(.top, 30)
    }
}

#Preview {
    ButtonView(button: "Sign In")
}
