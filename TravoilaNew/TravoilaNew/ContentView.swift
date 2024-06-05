//
//  ContentView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        SplashScreenView()
            .environmentObject(UserViewModel())
    }
}

#Preview {
    ContentView()
}
