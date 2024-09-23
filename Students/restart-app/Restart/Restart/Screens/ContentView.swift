//
//  ContentView.swift
//  Restart
//
//  Created by Mac on 20/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("on_boarding") var isOnBoardingViewActive: Bool = true;
    
    var body: some View {
        if(isOnBoardingViewActive){
            OnBoardingView()
        }else{
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
