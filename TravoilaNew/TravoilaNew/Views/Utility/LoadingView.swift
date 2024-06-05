//
//  LoadingView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 23/05/24.
//

import SwiftUI

struct LoadingView: View {
    @State var scale: CGFloat = 0.5
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.7)
                .ignoresSafeArea()
            VStack {
                HStack {
                    DotView()
                    DotView(delay: 0.2)
                    DotView(delay: 0.4)
                }
                
                Text("Loading")
                    .foregroundColor(.white)
                    .font(.system(size: 21, weight: .regular))
                    .padding(.top, 5)
            }
        }
    }
}

struct DotView: View {
    @State var delay: CGFloat = 0
    @State var scale: CGFloat = 0.5
    var body: some View{
        Circle()
            .fill(.white)
            .frame(width: 20, height: 20)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.6).repeatForever().delay(delay))
            .onAppear {
                withAnimation {
                    self.scale = 1
                }
            }
    }
}

#Preview {
    LoadingView()
}
