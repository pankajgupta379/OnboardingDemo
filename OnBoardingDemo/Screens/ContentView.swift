//
//  ContentView.swift
//  OnBoardingDemo
//
//  Created by Pankaj Gupta on 11/06/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onBoarding") var isOnBoardingDone: Bool = false
    
    var body: some View {
        if !isOnBoardingDone {
            OnBoardingView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
