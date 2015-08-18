//
//  AudioEffects.swift
//  Pitch Perfect
//
//  Created by Programming on 8/16/15.
//  Copyright © 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import Foundation
import AVFoundation


class AudioEffect {
    
    let session: AVAudioSession!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFile: AVAudioFile!
    var receivedAudio: RecordedAudio!
    var changeEffect: AVAudioUnitTimePitch!
    var echoEffect: AVAudioUnitDelay!
    var reverbEffect: AVAudioUnitReverb!


    init(){
        
        session = AVAudioSession.sharedInstance()
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: nil)
        
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        changeEffect = AVAudioUnitTimePitch()
        echoEffect = AVAudioUnitDelay()
        reverbEffect = AVAudioUnitReverb()
        
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(changeEffect)
        audioEngine.attachNode(echoEffect)
        audioEngine.attachNode(reverbEffect)

        audioEngine.connect(audioPlayerNode, to: changeEffect, format: nil)
        audioEngine.connect(changeEffect, to: audioEngine.outputNode, format: nil)
        audioEngine.connect(changeEffect, to: echoEffect, format: nil)
        audioEngine.connect(echoEffect, to: audioEngine.outputNode, format: nil)
        audioEngine.connect(echoEffect, to: reverbEffect, format: nil)
        audioEngine.connect(reverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioEngine.startAndReturnError(nil)
        
    }
    
    func playAudio(){

        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioPlayerNode.play()
    }
    
    func playAudioWithVariablePitch(pitch:Float) {
        stopAudio()
        changeEffect.pitch = pitch
        changeEffect.rate = 1.0
        echoEffect.delayTime = NSTimeInterval(0.0)
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.MediumHall)
        reverbEffect.wetDryMix = 0
        playAudio()
    }

    func playAudioWithVariableRate(rate: Float){
        stopAudio()
        changeEffect.pitch = 1.0
        changeEffect.rate = rate
        echoEffect.delayTime = NSTimeInterval(0.0)
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.MediumHall)
        reverbEffect.wetDryMix = 0
        playAudio()

    }
    
    func playAudioWithEcho (delayTime: NSTimeInterval){
        stopAudio()
        changeEffect.pitch = 1.0
        changeEffect.rate = 1.0
        echoEffect.delayTime = NSTimeInterval(delayTime)
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.MediumHall)
        reverbEffect.wetDryMix = 0
        playAudio()
    }
    
    func playAudioWithReverb (){
        stopAudio()
        changeEffect.pitch = 1.0
        changeEffect.rate = 1.0
        echoEffect.delayTime = NSTimeInterval(0.0)
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.Cathedral)
        reverbEffect.wetDryMix = 60
        playAudio()
    }
    
    func stopAudio(){
        audioPlayerNode.stop()
        audioEngine.reset()
    }
}