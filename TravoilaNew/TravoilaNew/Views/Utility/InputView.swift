//
//  InputView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 02/06/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecured: Bool = true
    @Binding var isShowed: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
            
            HStack(alignment: .center) {
                Text(title)
                    .fontWeight(.semibold)
                    .frame(width: 88.25, alignment: .leading)
                
                Spacer()
                
                HStack {
                    if self.isSecured && !self.isShowed {
                        SecureField(placeholder, text: $text)
                            .frame(height: 22)
                    } else {
                        TextField(placeholder, text: $text)
                            .frame(height: 22)
                    }
                    
                    if isSecured {
                        Button(action: {
                            isShowed.toggle()
                        }) {
                            Image(systemName: isShowed ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.trailing)
            }
            .frame(width: UIScreen.main.bounds.width - 70)
        }
        .frame(width: UIScreen.main.bounds.width - 35, height: 62)
        .padding(.bottom, 1)
        
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeholder: "mail@example.com", isShowed: .constant(false))
}
