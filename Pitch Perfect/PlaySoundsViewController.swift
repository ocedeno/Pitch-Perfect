//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Programming on 8/12/15.
//  Copyright © 2015 Cedeno Enterprise, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioEffect: AudioEffect!
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    
    let backgroundColor: UIColor = UIColor(red: 0, green: 0.451, blue: 0.698, alpha: 1)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        backgroundView.backgroundColor = backgroundColor
    }
    
    func changeImageToPause(imageName: String){
        playPauseButton.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
    }
    
    @IBAction func slowAudio(sender: UIButton) {
        changeImageToPause("Pause")
        audioEffect.playAudioWithVariableRate(0.5)
    }
    
    @IBAction func fastAudio(sender: UIButton) {
        changeImageToPause("Pause")
        audioEffect.playAudioWithVariableRate(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        changeImageToPause("Pause")
        audioEffect.playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthAudio(sender: UIButton) {
        changeImageToPause("Pause")
        audioEffect.playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        changeImageToPause("Pause")
        audioEffect.playAudioWithEcho(0.3)
    }
    @IBAction func playReverbAudio(sender: UIButton) {
        changeImageToPause("Pause")
        audioEffect.playAudioWithReverb()
    }
    
    @IBAction func pausePlayAudio(sender: UIButton) {
        if playPauseButton.imageView?.image == UIImage(named: "Pause") {
            audioEffect.audioPlayerNode.pause()
            changeImageToPause("Play")
        }else{
            audioEffect.audioPlayerNode.play()
            changeImageToPause("Pause")
        }
    }

    @IBAction func stopAudio(sender: UIButton) {
        audioEffect.stopAudio()
    }
}
