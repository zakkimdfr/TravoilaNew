//
//  LearnView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 02/06/24.
//

import SwiftUI

struct AnimatedTextField: View {
    @State private var text: String = ""
    let title: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .foregroundColor(text.isEmpty ? .gray : .accentColor)
                .offset(y: text.isEmpty ? 0 : -30)
                .scaleEffect(text.isEmpty ? 1 : 0.7, anchor: .leading)
                .animation(.spring(), value: text.isEmpty)
            
            TextField(placeholder, text: $text)
                .padding(.top, text.isEmpty ? 0 : 20)
                .background(Color.clear)
        }
        .padding(.top, 30)
        .padding(.horizontal)
    }
}

#Preview {
    AnimatedTextField(title: "Email", placeholder: "")
}
