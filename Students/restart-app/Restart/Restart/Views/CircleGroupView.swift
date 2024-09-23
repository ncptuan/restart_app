//
//  CircleGroupView.swift
//  Restart
//
//  Created by Mac on 21/07/2024.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var circleColor: Color;
    @State var circleOpacity: Double;
    @State private var isAnimation: Bool = false;
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(circleColor.opacity(circleOpacity), lineWidth: 80)
                .frame(width: 256, height: 256, alignment: .center)
            Circle()
                .stroke(circleColor.opacity(circleOpacity), lineWidth: 40)
                .frame(width: 256, height: 256, alignment: .center)
        }
        .onAppear(
            perform: {
                isAnimation = true;
            }
        )
        .blur(radius: isAnimation ? 0 : 40)
        .opacity(isAnimation ? 1 : 0)
        .scaleEffect(isAnimation ? 1 : 0.5)
        .animation(.easeInOut(duration: 1), value: isAnimation)
    }
}

#Preview {
    
    ZStack {
        Color(.blue)
            .ignoresSafeArea()
        CircleGroupView(circleColor: .white, circleOpacity: 0.2)
    }
}
