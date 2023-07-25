//
//  HomeView.swift
//  OnBoardingDemo
//
//  Created by Pankaj Gupta on 11/06/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onBoarding") var isOnBoardingDone: Bool = true
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                CircleGroupView(shapeColor: .secondary, shapeOpacity: 0.1)
                    .blur(radius: isAnimating ? 0 : 10)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .animation(Animation.easeOut(duration: 1.5).repeatForever(), value: isAnimating)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeOut(duration: 1.5)
                            .repeatForever()
                        , value: isAnimating
                    )
            }
            
            Text("""
                The time that's leads to mastery is
                depandent on the intensity of our
                focus.
                """)
            .font(.title3)
            .fontWeight(.light)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                playSound(name: "success", type: "m4a")
                withAnimation {
                    isOnBoardingDone = false
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                isAnimating = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
