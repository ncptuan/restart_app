//
//  BoardingView.swift
//  Restart
//
//  Created by Mac on 21/07/2024.
//

import SwiftUI

struct OnBoardingView: View {
    
    
    @AppStorage("on_boarding") var isOnBoardingViewActive: Bool = true;
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 40;
    @State private var buttonOffset: Double = 0;
    @State private var isAnimating: Bool = false;
    @State private var isMoveCharacterOffset: Double = 0;
    
    private var slideHeight: Double = 80;
    
    let hapticFeedBack = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        let _anchorRedDotPosition: Double = (buttonWidth - slideHeight);
        let _halfOfSlideButton: Double = _anchorRedDotPosition/2;
        // MARK: - Content
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack (spacing: 16) {
                
                // MARK: - HEADER
                
                VStack(){
                    Text( isMoveCharacterOffset != 0 ? "Get." : "Share." )
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                }
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                
                // MARK: - Center
                
                ZStack{
                    CircleGroupView(
                        circleColor: .white,
                        circleOpacity: 0.2
                    )
                    .offset(x: isMoveCharacterOffset * -1)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x: isMoveCharacterOffset, y: isAnimating ? 0 : -40)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                    
                }
            
                
                Image(systemName: "arrowshape.left.arrowshape.right.fill")
                    .foregroundColor(.white)
                    .gesture(DragGesture().onChanged(
                            { gesture in
                                 isMoveCharacterOffset = gesture.translation.width
                            }
                        )
                        .onEnded({ _ in
                            isMoveCharacterOffset = 0;
                        })
                    )
                
                
                // MARK: - FOOTER
                
                ZStack(){
                    Capsule()
                        .fill(.white.opacity(0.1))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    HStack(){
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(
                                width: buttonOffset + slideHeight,
                                height: slideHeight
                            )
                        
                        Spacer()
                    }
                    
                    HStack(){
                        ZStack(){
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 26))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .offset(x: buttonOffset)
                    .gesture(
                        DragGesture().onChanged({ gesture in
                            let gestureWidth: Double = gesture.translation.width;
                            if ((gestureWidth > 0) && (gestureWidth <= _anchorRedDotPosition) ) {
                                buttonOffset = gestureWidth;
                            }
                        })
                        .onEnded({ end in
                            withAnimation(Animation.easeOut(duration: 0.4)) {
                                if buttonOffset <= _halfOfSlideButton {
                                    buttonOffset = 0
                                    hapticFeedBack.notificationOccurred(.warning)
                                }else {
                                    hapticFeedBack.notificationOccurred(.success)
                                    playSound(sound: "chimeup", type: "mp3")
                                    buttonOffset = _anchorRedDotPosition;
                                    isOnBoardingViewActive = false;
                                }
                            }
                        })
                    )
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                .frame(width: buttonWidth, height: slideHeight, alignment: .center)
                
            } //: VStack
            
            .padding(16)
        } //: ZStack
        .onAppear(
            perform: {
                isAnimating = true;
            }
        )
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnBoardingView()
}
