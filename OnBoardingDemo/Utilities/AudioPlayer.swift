//
//  AudioPlayer.swift
//  OnBoardingDemo
//
//  Created by Pankaj Gupta on 12/06/23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(name: String, type: String) {
  if let path = Bundle.main.path(forResource: name, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
      print("Could not play the sound file.")
    }
  }
}
