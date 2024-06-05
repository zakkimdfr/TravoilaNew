//
//  AddButtonView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 05/06/24.
//

import SwiftUI

struct AddButtonView: View {
    var body: some View {
       Image(systemName: "plus")
            .resizable()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 46, height: 46)
                    .foregroundColor(Color.themeColor(.primary))
                
            )
            .frame(width: 18, height: 18)
            
    }
}

#Preview {
    AddButtonView()
}
