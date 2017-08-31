//
//  LGSoundHelper.swift
//  LetsGo
//
//  Created by Menem Ragab on 8/31/17.
//  Copyright © 2017 Phoenix fitness. All rights reserved.
//
public enum TimerState
{
    case start
    case stop
    case pause
}

import UIKit
import AVFoundation

class LGSoundHelper: NSObject {
   static let sharedInstance = LGSoundHelper()
   var player: AVAudioPlayer?
    
    func playSoundfor(state:TimerState) {
        guard let url = Bundle.main.url(forResource: "tone", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url)
            //            guard let player = player else { return }
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                self.player?.play()
                
            }
            
        } catch let error {
            //            print(error.localizedDescription)
        }
    }
    
    func speak(text: String) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: text)
            utterance.rate = 0.7
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
        }
    }

    
}
