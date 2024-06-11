//
//  CustomBackButton.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 08/06/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Cancel")
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.gray)
        }
    }
}

#Preview {
    CustomBackButton()
}
