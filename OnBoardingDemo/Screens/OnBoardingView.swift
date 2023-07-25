//
//  OnBoardingView.swift
//  OnBoardingDemo
//
//  Created by Pankaj Gupta on 12/06/23.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onBoarding") var isOnBoardingDone: Bool = false
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffSet: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffSet: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var titleText: String = "Share."
    
    let hapticNotification = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                // TOP
                VStack {
                    Text(titleText)
                        .font(.system(size: 60, weight: .heavy))
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(titleText)
                    
                    Text("""
                        It's not how much we give but
                        How much we love into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(Animation.easeOut(duration: 1), value: isAnimating)
                
                // Center
                
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffSet.width * -1)
                        .blur(radius: abs(imageOffSet.width/5))
                        .animation(Animation.easeOut(duration: 1), value: imageOffSet)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .offset(x: imageOffSet.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffSet.width/20)))
                        .opacity(isAnimating ? 1: 0)
                        .animation(Animation.easeOut(duration: 0.5), value: isAnimating)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffSet.width) <= 150 {
                                        imageOffSet = gesture.translation
                                        withAnimation(.easeOut(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            titleText = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffSet = .zero
                                    withAnimation(.easeOut(duration: 0.25)) {
                                        indicatorOpacity = 1.0
                                        titleText = "Share."
                                    }
                                })
                        ).animation(Animation.linear(duration: 1), value: imageOffSet)
                }
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .offset(y: 10)
                        .font(.system(size: 44))
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                        .opacity(isAnimating ? indicatorOpacity : 0)
                        .animation(Animation.easeOut(duration: 1).delay(2), value: isAnimating)
                    , alignment: .bottom
                )
                
                Spacer()
                
                // Bottom
                
                ZStack {
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffSet+80)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .frame(width: 80, height: 80, alignment: .center)
                        .foregroundColor(.white)
                        .offset(x: buttonOffSet)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffSet <= buttonWidth - 80  {
                                        buttonOffSet = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    withAnimation(Animation.easeOut(duration: 1)) {
                                        if buttonOffSet < buttonWidth/2 {
                                            buttonOffSet = 0
                                            hapticNotification.notificationOccurred(.warning)
                                        } else {
                                            buttonOffSet = buttonWidth-80
                                            hapticNotification.notificationOccurred(.success)
                                            playSound(name: "chimeup", type: "mp3")
                                            isOnBoardingDone = true
                                        }
                                    }
                                })
                        )
                        
                        Spacer()
                    }
                }
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(Animation.easeOut(duration: 1), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
