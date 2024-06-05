//
//  ShowErrorView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 24/05/24.
//

import SwiftUI

struct ShowErrorView: View {
    @State private var showError: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
                .frame(width: 358, height: 63)
                .foregroundColor(.red)
            
            Text("This field is required!")
                .background(.white)
                .foregroundColor(.red)

        }
    }
}

#Preview {
    ShowErrorView()
}
