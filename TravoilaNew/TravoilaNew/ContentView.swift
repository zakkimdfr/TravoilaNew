//
//  ContentView.swift
//  TravoilaNew
//
//  Created by Zakki Mudhoffar on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
       SplashScreenView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
