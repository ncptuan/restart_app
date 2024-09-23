//
//  HomeView.swift
//  Restart
//
//  Created by Mac on 21/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("on_boarding") var isOnBoardingViewActive: Bool = false;
    @State private var isAnimating: Bool = false;
    
    var body: some View {
        VStack {
            Spacer()
            // MARK: Content
            
            ZStack {
                CircleGroupView(
                    circleColor: .gray,
                    circleOpacity: 0.2
                )
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(.easeInOut(duration: 4).repeatForever(), 
                               value: isAnimating)
            }
            Text("The time that leads to mastery is dependant on the intensity of our forcus")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
            
            Spacer()
            // MARK: Footer
            
            Button {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnBoardingViewActive = true;
                }
               
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                Text("Restart")
            }
            .font(.system(size: 24))
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
            Spacer()
        }
        .padding(16)
        .onAppear(
            perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    isAnimating = true;
                })
                
            })
    } // VStack
}

#Preview {
    HomeView()
}
