//
//  TripView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 27/05/24.
//

import SwiftUI

struct TripView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("My Trip")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Spacer()
                    
                    Text("See all trip")
                        .foregroundStyle(.white)
                        .font(.system(size: 14, weight: .regular))
                }
                .frame(width: 350, height: 26)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 350, height: 570)
                    .foregroundColor(.white)
                    .shadow(radius: 1)
            }
        }
    }
}

#Preview {
    TripView()
}
